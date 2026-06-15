import React, { useState, useEffect, useRef } from 'react';
import { useParams, useNavigate, useLocation, useSearchParams } from 'react-router-dom';
import { Card, Button } from '../components/common';
import { useCurrency } from '../context/CurrencyContext';
import { useAuth } from '../context/AuthContext';
import tripsApi, { type TripResponse } from '../api/trips';
import routesApi, { type RouteResponse } from '../api/routes';
import reservationsApi from '../api/reservations';
import './TripDetailsPage.css';

interface PassengerState {
  fullName: string;
  seatNumber: string;
}

interface ToastState {
  id: string;
  message: string;
  type: 'success' | 'error';
}

export const TripDetailsPage: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const location = useLocation();
  const [searchParams] = useSearchParams();
  const { user } = useAuth();
  const { formatPrice } = useCurrency();

  // Parse search query variables
  const fromCity = searchParams.get('fromCity') || '';
  const fromTerminalId = searchParams.get('fromTerminalId') ? Number(searchParams.get('fromTerminalId')) : null;
  const toCity = searchParams.get('toCity') || '';
  const toTerminalId = searchParams.get('toTerminalId') ? Number(searchParams.get('toTerminalId')) : null;
  const passengerCount = Number(searchParams.get('passengers')) || 1;

  // Component states
  const [trip, setTrip] = useState<TripResponse | null>(null);
  const [route, setRoute] = useState<RouteResponse | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [bookingProcessing, setBookingProcessing] = useState(false);

  // Form states
  const [passengersList, setPassengersList] = useState<PassengerState[]>([]);
  const [selectedSeats, setSelectedSeats] = useState<string[]>([]);
  const [previousReservationId, setPreviousReservationId] = useState<number | null>(null);

  // Load saved form state from sessionStorage if it exists (e.g. user navigated back from payment)
  useEffect(() => {
    if (!id) return;
    const saved = sessionStorage.getItem(`booking_form_${id}`);
    if (saved) {
      try {
        const { passengersList: savedList, selectedSeats: savedSeats, reservationId: savedResId } = JSON.parse(saved);
        if (savedList && savedList.length > 0) {
          setPassengersList(savedList);
        }
        if (savedSeats && savedSeats.length > 0) {
          setSelectedSeats(savedSeats);
        }
        if (savedResId) {
          setPreviousReservationId(Number(savedResId));
        }
      } catch (e) {
        console.error('Failed to parse saved booking form', e);
      }
    }
  }, [id]);

  // 3-minute booking timer states
  const [timerSeconds, setTimerSeconds] = useState(180);
  const [showTimerModal, setShowTimerModal] = useState(false);

  // Refs for scrolling
  const passengersCardRef = useRef<HTMLDivElement>(null);
  const seatMapCardRef = useRef<HTMLDivElement>(null);

  // Validation state
  const [showValidationErrors, setShowValidationErrors] = useState(false);

  // Regex format validation helper
  const validateNameFormat = (name: string): boolean => {
    const trimmed = name.trim();
    const nameParts = trimmed.split(/\s+/);
    if (nameParts.length < 2) return false;
    const nameRegex = /^[\p{L}'-]+$/u;
    return nameParts.every(part => nameRegex.test(part) && part.length >= 2);
  };
  // Toast notifications states
  const [toasts, setToasts] = useState<ToastState[]>([]);

  // 1. Fetch trip and route details on mount
  useEffect(() => {
    const fetchDetails = async () => {
      if (!id) return;
      setLoading(true);
      setError('');
      try {
        const tripData = await tripsApi.getById(Number(id), {
          fromTerminalId,
          fromCity,
          toTerminalId,
          toCity
        });

        // Validation: check if the trip is already sold out
        if (tripData.availableSeats.length < passengerCount) {
          navigate('/search' + location.search, {
            state: { showSoldOutModal: true, fromCity, toCity }
          });
          return;
        }

        setTrip(tripData);

        const routeData = await routesApi.getById(tripData.routeId);
        setRoute(routeData);
      } catch {
        setError('Failed to load booking details.');
      } finally {
        setLoading(false);
      }
    };

    fetchDetails();
  }, [id, passengerCount, fromCity, fromTerminalId, location.search, navigate, toCity, toTerminalId]);

  // 2. Synchronize passenger list size with passengerCount parameter
  useEffect(() => {
    setPassengersList((prev) => {
      if (prev.length === passengerCount) return prev;

      const newList = Array.from({ length: passengerCount }, (_, i) => {
        if (prev[i]) return prev[i];
        return {
          fullName: i === 0 && user ? `${user.firstName} ${user.lastName}`.trim() : '',
          seatNumber: selectedSeats[i] || ''
        };
      });
      return newList;
    });
  }, [passengerCount, user, selectedSeats]);

  // 3. Countdown Timer Effect
  useEffect(() => {
    if (loading || error || !trip) return;

    if (timerSeconds <= 0) {
      setShowTimerModal(true);
      return;
    }

    const interval = setInterval(() => {
      setTimerSeconds((prev) => prev - 1);
    }, 1000);

    return () => clearInterval(interval);
  }, [timerSeconds, loading, error, trip]);

  // Toast notifications helpers
  const triggerToast = (message: string, type: 'success' | 'error' = 'success') => {
    const toastId = Math.random().toString(36).substring(2, 9);
    setToasts((prev) => [...prev, { id: toastId, message, type }]);
    setTimeout(() => {
      dismissToast(toastId);
    }, 3000);
  };

  const dismissToast = (toastId: string) => {
    setToasts((prev) => prev.filter((t) => t.id !== toastId));
  };

  // Timer reset handlers
  const handleExtendTimer = () => {
    setTimerSeconds(180);
    setShowTimerModal(false);
  };

  const handleCancelBooking = () => {
    navigate('/search' + location.search);
  };

  // Passenger form inputs updates
  const handlePassengerNameChange = (index: number, val: string) => {
    setPassengersList((prev) => {
      const updated = [...prev];
      updated[index] = { ...updated[index], fullName: val };
      return updated;
    });
  };

  // Seat layout calculation parameters
  // coach contains 14 rows, 53 seats, WC on row 6 right, exit stairs on row 7 right
  const getSeatLayoutRows = () => {
    const rowsList = [];
    let seatNumberCounter = 1;
    for (let r = 1; r <= 14; r++) {
      const rowSeats = [];
      if (r === 14) {
        // Rear row spans 5 seats
        for (let c = 1; c <= 5; c++) {
          rowSeats.push({ type: 'seat', number: String(seatNumberCounter++) });
        }
      } else {
        // Columns 1 & 2 (Left)
        rowSeats.push({ type: 'seat', number: String(seatNumberCounter++) });
        rowSeats.push({ type: 'seat', number: String(seatNumberCounter++) });
        // Columns 3 & 4 (Right)
        if (r === 6) {
          rowSeats.push({ type: 'wc' });
          rowSeats.push({ type: 'wc' });
        } else if (r === 7) {
          rowSeats.push({ type: 'stairs' });
          rowSeats.push({ type: 'stairs' });
        } else {
          rowSeats.push({ type: 'seat', number: String(seatNumberCounter++) });
          rowSeats.push({ type: 'seat', number: String(seatNumberCounter++) });
        }
      }
      rowsList.push({ rowNum: r, seats: rowSeats });
    }
    return rowsList;
  };

  // Seat Category Surcharge Helper (dynamic from backend rules)
  const isSeatPanoramic = (seatNo: string) => {
    if (!trip?.seatLayout) return false;
    try {
      const layout = JSON.parse(trip.seatLayout);
      const panoramic = layout?.categories?.PANORAMIC || [];
      return panoramic.includes(seatNo);
    } catch {
      return false;
    }
  };

  const getPanoramicSurcharge = () => {
    if (!route || !trip) return 0;
    const sortedStops = [...route.stops].sort((a, b) => a.sequenceOrder - b.sequenceOrder);
    const startStop = sortedStops.find((s) => s.terminalName === trip.originTerminalName);
    const endStop = sortedStops.find((s) => s.terminalName === trip.destinationTerminalName);
    if (!startStop || !endStop) return 0;
    const distance = Math.abs(endStop.distanceFromOrigin - startStop.distanceFromOrigin);
    return Number((distance * 0.004).toFixed(2));
  };

  // Toggle seat selections and link them to passengers in order without StrictMode duplication
  const handleSeatClick = (seatNo: string, isAvailable: boolean) => {
    if (!isAvailable) return;

    const isAlreadySelected = selectedSeats.includes(seatNo);
    if (isAlreadySelected) {
      // Deselect
      const updatedSeats = selectedSeats.filter((s) => s !== seatNo);
      setSelectedSeats(updatedSeats);
      setPassengersList((passengers) =>
        passengers.map((p, idx) => ({
          ...p,
          seatNumber: updatedSeats[idx] || ''
        }))
      );
    } else {
      // Select
      if (selectedSeats.length >= passengerCount) {
        triggerToast(`You can only select up to ${passengerCount} seat${passengerCount > 1 ? 's' : ''}.`, 'error');
        return;
      }
      const updatedSeats = [...selectedSeats, seatNo];
      setSelectedSeats(updatedSeats);
      triggerToast(`Seat ${seatNo} reserved.`, 'success');
      setPassengersList((passengers) =>
        passengers.map((p, idx) => ({
          ...p,
          seatNumber: updatedSeats[idx] || ''
        }))
      );
    }
  };

  // Calculate pricing values
  const getTicketTotal = () => {
    if (!trip) return 0;
    return trip.price * passengerCount;
  };

  const getSurchargesTotal = () => {
    const surchargeVal = getPanoramicSurcharge();
    return selectedSeats.filter((s) => isSeatPanoramic(s)).length * surchargeVal;
  };

  const getServiceFee = () => {
    // Service fee is always 0.5 EUR
    return 0.5;
  };

  const getBookingTotal = () => {
    return getTicketTotal() + getSurchargesTotal() + getServiceFee();
  };

  // Submit flow to create reservation
  const handlePayClick = async () => {
    const hasSeatUnselected = selectedSeats.length < passengerCount;
    const hasInvalidNames = passengersList.some((p) => !p.fullName.trim() || !validateNameFormat(p.fullName));

    if (hasSeatUnselected || hasInvalidNames) {
      setShowValidationErrors(true);
      const isVerticalVersion = window.innerWidth <= 1166;
      passengersCardRef.current?.scrollIntoView({
        behavior: 'smooth',
        block: isVerticalVersion ? 'center' : 'start'
      });
      return;
    }

    if (bookingProcessing) return;

    if (!trip || !route) return;

    const sortedStops = [...route.stops].sort((a, b) => a.sequenceOrder - b.sequenceOrder);
    const startStop = sortedStops.find((s) => s.terminalName === trip.originTerminalName);
    const endStop = sortedStops.find((s) => s.terminalName === trip.destinationTerminalName);
    if (!startStop || !endStop) return;

    setBookingProcessing(true);

    try {
      const passengerRequests = passengersList.map((p, idx) => {
        const fullName = p.fullName.trim();
        const spaceIdx = fullName.indexOf(' ');
        const firstName = spaceIdx !== -1 ? fullName.substring(0, spaceIdx) : fullName;
        const lastName = spaceIdx !== -1 ? fullName.substring(spaceIdx + 1) : '';

        return {
          firstName,
          lastName,
          seatNumber: selectedSeats[idx],
          fromStopOrder: startStop.sequenceOrder,
          toStopOrder: endStop.sequenceOrder
        };
      });

      // Cancel previous reservation if it exists to release selected seats
      if (previousReservationId) {
        try {
          await reservationsApi.cancel(previousReservationId);
        } catch (e) {
          console.error('Failed to cancel previous reservation', e);
        }
      }

      const body = {
        tripId: trip.id,
        passengers: passengerRequests
      };

      const res = await reservationsApi.create(body);
      
      // Save current booking form state to restore if user hits 'Back' on payment page
      sessionStorage.setItem(`booking_form_${trip.id}`, JSON.stringify({
        passengersList,
        selectedSeats,
        reservationId: res.id
      }));

      // Success: redirect to mockup payment page (do NOT use replace: true, allowing back navigation)
      navigate(`/payment/${res.id}`);
    } catch (err) {
      const error = err as { response?: { data?: { message?: string }; status?: number }; message?: string };
      const responseData = error.response?.data;
      const errorMsg = responseData?.message || error.message || '';

      if (errorMsg.toLowerCase().includes('seat') || error.response?.status === 409) {
        // Seat already occupied (collision check)
        triggerToast('Some of the selected seats are no longer available. Please select new seats.', 'error');
        try {
          // Re-fetch updated trip details
          const updatedTrip = await tripsApi.getById(trip.id, {
            fromTerminalId,
            fromCity,
            toTerminalId,
            toCity
          });
          setTrip(updatedTrip);

          // Clear no longer available selected seats
          setSelectedSeats((prev) => {
            const valid = prev.filter((s) => updatedTrip.availableSeats.includes(s));
            // Sync with passenger list
            setPassengersList((passengers) => {
              return passengers.map((p, idx) => ({
                ...p,
                seatNumber: valid[idx] || ''
              }));
            });
            return valid;
          });

          // Check if seats count available has dropped below passengerCount
          if (updatedTrip.availableSeats.length < passengerCount) {
            navigate('/search' + location.search, {
              state: { showSoldOutModal: true, fromCity, toCity }
            });
          }
        } catch {
          alert('Could not update available seats list. Please refresh the page.');
        }
      } else {
        alert(errorMsg || 'Booking creation failed. Please try again.');
      }
      setBookingProcessing(false);
    }
  };

  if (loading) {
    return (
      <div className="trip-details-page">
        <div className="loading-state">
          <div className="loading-spinner" />
          <p>Loading booking details...</p>
        </div>
      </div>
    );
  }

  if (error || !trip) {
    return (
      <div className="trip-details-page">
        <div className="error-state">
          <h2>Booking details not found</h2>
          <p>{error}</p>
          <Button onClick={() => navigate('/search')}>Back to Search</Button>
        </div>
      </div>
    );
  }

  // Formatting datetimes
  const formatTime = (datetime: string) => {
    return new Date(datetime).toLocaleTimeString('en-US', {
      hour: '2-digit',
      minute: '2-digit',
      hour12: false
    });
  };

  const formatDate = (datetime: string) => {
    return new Date(datetime).toLocaleDateString('en-US', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  };

  const formatDuration = (departure: string, arrival: string) => {
    const start = new Date(departure);
    const end = new Date(arrival);
    const diff = (end.getTime() - start.getTime()) / (1000 * 60);
    const hours = Math.floor(diff / 60);
    const mins = Math.round(diff % 60);
    return `${hours}h ${mins}m`;
  };

  // Find index ranges for stops route highlights
  const sortedStops = route ? [...route.stops].sort((a, b) => a.sequenceOrder - b.sequenceOrder) : [];
  const startStopIdx = sortedStops.findIndex((s) => s.terminalName === trip.originTerminalName);
  const endStopIdx = sortedStops.findIndex((s) => s.terminalName === trip.destinationTerminalName);

  // De-duplicate bus manufacturer name inside model name
  const getCleanBusName = () => {
    const m = trip.busName || '';
    // Format: "Manufacturer Model" or just "Model"
    // Check if the manufacturer word is repeated in the model
    const parts = m.split(' ');
    if (parts.length > 1 && parts[0].toLowerCase() === parts[1].toLowerCase()) {
      return parts.slice(1).join(' ');
    }
    return m;
  };

  const formatTimerString = (sec: number) => {
    const m = Math.floor(sec / 60);
    const s = sec % 60;
    return `${String(m).padStart(2, '0')}:${String(s).padStart(2, '0')}`;
  };

  const standardSeats = selectedSeats.filter((s) => !isSeatPanoramic(s));
  const panoramicSeats = selectedSeats.filter((s) => isSeatPanoramic(s));

  return (
    <div className="trip-details-page">
      {/* Toast Notification area */}
      <div className="toast-container-fixed">
        {toasts.map((t) => (
          <div key={t.id} className={`toast-item-notification ${t.type}`} onClick={() => dismissToast(t.id)}>
            <div className="toast-icon-wrapper">
              {t.type === 'success' ? (
                <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" strokeWidth="3.5" fill="none">
                  <polyline points="20 6 9 17 4 12" />
                </svg>
              ) : (
                <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" strokeWidth="3.5" fill="none">
                  <line x1="18" y1="6" x2="6" y2="18" />
                  <line x1="6" y1="6" x2="18" y2="18" />
                </svg>
              )}
            </div>
            <span>{t.message}</span>
          </div>
        ))}
      </div>

      <div className="trip-details-grid">
        {/* Main Column */}
        <div className="trip-main-column">
          {/* Card 1: Journey Details Header */}
          <Card className="trip-header-card animate-card">
            <div className="trip-header-main-row">
              <h1>Journey Details</h1>
              <span className={`status-badge status-${trip.status.toLowerCase()}`}>
                {trip.status}
              </span>
            </div>

            {/* Redesigned search-card style timeline layout */}
            <div className="trip-header-timeline">
              <div className="timeline-station-point departure">
                <span className="station-time">{formatTime(trip.departureDatetime)}</span>
                <div className="station-date">{formatDate(trip.departureDatetime)}</div>
                <span className="station-name-label">{trip.originTerminalName}</span>
              </div>

              <div className="trip-duration-line-container">
                <span className="duration-label">{formatDuration(trip.departureDatetime, trip.arrivalDatetime)}</span>
                <div className="duration-line-horizontal">
                  <div className="dot start-dot" />
                  <div className="line-connector" />
                  <div className="dot end-dot" />
                </div>
              </div>

              <div className="timeline-station-point arrival">
                <span className="station-time">{formatTime(trip.arrivalDatetime)}</span>
                <div className="station-date">{formatDate(trip.arrivalDatetime)}</div>
                <span className="station-name-label">{trip.destinationTerminalName}</span>
              </div>
            </div>

            {/* Vertical Route Stops Timeline */}
            <div className="trip-header-route-details">
              <div className="route-number-badge">Route N.{500 + trip.routeId}</div>
              <div className="route-stops-vertical">
                {sortedStops.map((stop, idx) => {
                  const minIdx = Math.min(startStopIdx, endStopIdx);
                  const maxIdx = Math.max(startStopIdx, endStopIdx);
                  const isBookedStop = idx >= minIdx && idx <= maxIdx;
                  const isBookedLine = idx >= minIdx && idx < maxIdx;

                  return (
                    <div key={`${stop.terminalName}-${idx}`} className="stop-vertical-item">
                      <div className="stop-marker-container">
                        <div className={`stop-circle ${isBookedStop ? 'booked' : ''}`} />
                        {idx < sortedStops.length - 1 && (
                          <div className={`stop-line-segment ${isBookedLine ? 'booked' : ''}`} />
                        )}
                      </div>
                      <span className="stop-name-text">
                        {stop.terminalName}
                      </span>
                    </div>
                  );
                })}
              </div>
            </div>

            {/* Bus & Onboard Features Section */}
            <div className="bus-features-section">
              <div className="bus-label-text">Bus</div>
              <div className="bus-details-row">
                <strong className="bus-model-name">{getCleanBusName()}</strong>
                <div className="trip-features-icons">
                  <span className="feature-icon-badge-only" title="High-speed Wi-Fi">
                    <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" strokeWidth="2.5" fill="none" strokeLinecap="round" strokeLinejoin="round">
                      <path d="M5 12.55a11 11 0 0 1 14.08 0" />
                      <path d="M1.42 9a16 16 0 0 1 21.16 0" />
                      <path d="M8.53 16.11a6 6 0 0 1 6.95 0" />
                      <line x1="12" y1="20" x2="12.01" y2="20" />
                    </svg>
                  </span>
                  <span className="feature-icon-badge-only" title="USB & Power Outlets">
                    <svg viewBox="18 16 131 133" width="16" height="16" fill="none">
                      <g transform="translate(0.000000,165.000000) scale(0.100000,-0.100000)" fill="currentColor" stroke="none">
                        <path d="M280 1410 c-19 -19 -20 -33 -20 -434 l0 -415 26 -20 c25 -20 39 -21 238 -21 200 0 214 1 234 20 22 21 22 22 22 435 0 402 -1 416 -20 435 -19 19 -33 20 -240 20 -207 0 -221 -1 -240 -20z m290 -40 c0 -5 -22 -10 -50 -10 -27 0 -50 5 -50 10 0 6 23 10 50 10 28 0 50 -4 50 -10z m180 -380 l0 -330 -230 0 -230 0 0 330 0 330 230 0 230 0 0 -330z m-206 -376 c9 -8 16 -19 16 -24 0 -11 -29 -40 -40 -40 -5 0 -16 10 -24 22 -14 20 -14 24 1 40 20 22 27 22 47 2z" />
                        <path d="M492 1082 c-39 -59 -72 -110 -72 -114 0 -5 18 -8 41 -8 34 0 39 -3 35 -17 -16 -54 -28 -113 -24 -124 4 -12 148 183 148 201 0 5 -18 10 -40 10 -46 0 -46 0 -24 82 8 33 14 64 12 69 -2 4 -36 -40 -76 -99z" />
                        <path d="M986 1334 c-24 -23 -24 -385 0 -408 8 -9 20 -16 25 -16 12 0 12 23 -1 36 -7 7 -9 77 -8 190 l3 179 170 0 170 0 3 -179 c1 -113 -1 -183 -8 -190 -13 -13 -13 -36 -1 -36 5 0 17 7 25 16 24 23 24 385 0 408 -13 13 -45 16 -189 16 -144 0 -176 -3 -189 -16z" />
                        <path d="M1107 1214 c-13 -13 -7 -71 8 -84 19 -16 28 4 23 51 -3 32 -17 46 -31 33z" />
                        <path d="M1217 1213 c-10 -10 -8 -81 2 -87 18 -11 32 22 25 58 -6 35 -14 43 -27 29z" />
                        <path d="M1052 1082 c-9 -7 -12 -47 -10 -168 l3 -159 130 0 130 0 3 159 c2 121 -1 161 -10 168 -7 4 -62 8 -123 8 -60 0 -116 -4 -123 -8z" />
                        <path d="M1130 692 c0 -35 4 -52 15 -56 12 -4 15 -29 15 -133 0 -70 -5 -144 -10 -164 -15 -54 -51 -101 -95 -126 -37 -21 -52 -23 -215 -23 -163 0 -178 2 -215 23 -26 14 -48 37 -62 67 -27 51 -30 115 -8 124 11 4 15 20 15 56 l0 50 -50 0 -50 0 0 -50 c0 -30 5 -52 13 -57 8 -4 17 -30 20 -57 13 -95 71 -163 160 -187 24 -6 106 -9 201 -7 173 3 211 13 263 70 51 54 63 103 63 258 0 134 2 147 21 163 15 13 19 27 17 55 -3 37 -4 37 -50 40 l-48 3 0 -49z" />
                      </g>
                    </svg>
                  </span>
                  <span className="feature-icon-badge-only" title="Adjustable Comfort Seats">
                    <svg viewBox="20 10 232 252" width="16" height="16" fill="none">
                      <g transform="translate(0.000000,272.000000) scale(0.100000,-0.100000)" fill="currentColor" stroke="none">
                        <path d="M1008 2614 c-33 -17 -49 -46 -77 -137 -24 -80 -20 -115 20 -153 22 -21 41 -28 84 -32 l55 -4 0 -78 0 -77 -102 -5 c-63 -4 -118 -12 -141 -22 -45 -20 -109 -76 -136 -119 -19 -31 -146 -448 -195 -640 -35 -135 -41 -231 -26 -412 l13 -156 41 -21 c23 -11 67 -40 99 -64 33 -24 69 -44 80 -44 12 0 90 13 172 30 207 40 307 51 471 52 183 0 307 -15 531 -62 51 -11 104 -20 117 -20 13 0 50 20 83 44 32 24 76 53 99 64 l41 21 13 156 c15 181 9 277 -26 412 -49 192 -176 609 -195 640 -27 43 -91 99 -136 119 -23 10 -78 18 -140 22 l-103 5 0 77 0 78 55 4 c64 5 109 39 119 89 5 29 -23 138 -50 191 -29 56 -42 58 -406 58 -275 -1 -338 -3 -360 -16z m532 -404 l0 -80 -170 0 -170 0 0 80 0 80 170 0 170 0 0 -80z m32 -390 c80 -25 156 -74 181 -118 26 -45 43 -114 66 -277 21 -146 51 -488 51 -581 l0 -54 -53 0 -53 0 -12 190 c-13 202 -44 469 -68 585 -17 80 -36 105 -105 134 -144 62 -411 39 -488 -43 -37 -39 -81 -330 -103 -676 l-12 -190 -54 0 -55 0 7 138 c12 242 49 564 78 681 25 101 64 148 163 192 116 52 324 60 457 19z" />
                        <path d="M355 665 c-47 -17 -82 -57 -91 -103 -7 -36 11 -195 27 -248 5 -17 22 -42 37 -56 21 -21 277 -157 355 -190 16 -7 17 8 17 230 l0 238 -35 13 c-19 6 -53 28 -77 47 -83 70 -162 94 -233 69z" />
                        <path d="M2290 671 c-46 -10 -87 -32 -139 -75 -23 -19 -57 -41 -76 -47 l-35 -13 0 -238 0 -238 28 12 c15 7 92 46 172 87 143 72 182 98 202 135 11 21 38 184 38 236 0 95 -89 161 -190 141z" />
                        <path d="M1160 614 c-48 -6 -311 -53 -332 -60 -17 -5 -18 -26 -18 -250 l0 -244 560 0 560 0 0 244 c0 224 -1 245 -17 250 -10 3 -81 17 -158 32 -118 22 -172 27 -350 29 -115 2 -226 1 -245 -1z" />
                      </g>
                    </svg>
                  </span>
                  <span className="feature-icon-badge-only" title="Individually Controlled Climate Control">
                    <svg viewBox="15 25 170 160" width="16" height="16" fill="none">
                      <g transform="translate(0.000000,200.000000) scale(0.100000,-0.100000)" fill="currentColor" stroke="none">
                        <path d="M1222 1673 c-46 -25 -86 -52 -89 -60 -6 -15 9 -114 28 -185 10 -40 25 -46 78 -31 22 5 23 9 17 54 -4 27 -4 49 0 49 20 0 110 -68 156 -119 63 -68 110 -153 132 -237 20 -78 20 -213 1 -289 -46 -176 -189 -328 -368 -390 -62 -21 -62 -22 -61 -59 2 -58 14 -63 91 -38 189 61 350 217 419 405 104 289 -7 619 -266 786 l-61 40 30 16 c17 8 31 22 31 31 0 24 -29 74 -43 74 -6 -1 -49 -21 -95 -47z" />
                        <path d="M773 1626 c-136 -51 -271 -161 -342 -279 -185 -311 -93 -711 207 -905 l63 -41 -30 -16 c-17 -8 -31 -22 -31 -31 0 -21 29 -74 40 -74 20 0 182 93 187 108 6 14 -9 113 -28 185 -10 39 -25 45 -78 30 -22 -5 -23 -9 -17 -54 4 -27 4 -49 0 -49 -20 0 -110 68 -156 119 -63 68 -110 153 -132 237 -20 78 -20 213 -1 289 46 175 187 325 368 390 67 24 76 39 58 88 -13 33 -27 33 -108 3z" />
                        <path d="M957 1424 c-4 -4 -7 -48 -7 -98 l0 -91 -38 -16 -37 -16 -67 65 c-63 61 -69 65 -93 54 -14 -6 -31 -23 -37 -37 -11 -24 -7 -30 54 -93 l65 -67 -16 -37 -16 -37 -95 -3 -95 -3 0 -45 0 -45 95 -3 95 -3 16 -37 16 -37 -65 -67 c-61 -63 -65 -69 -54 -93 6 -14 23 -31 37 -37 24 -11 30 -7 93 54 l67 65 37 -16 37 -16 3 -95 3 -95 45 0 45 0 3 95 3 95 37 16 37 16 67 -65 c63 -61 69 -65 93 -54 14 6 31 23 37 37 11 24 7 30 -54 93 l-65 67 16 37 16 37 95 3 95 3 0 45 0 45 -95 3 -95 3 -16 37 -16 37 65 67 c61 63 65 69 54 93 -6 14 -23 31 -37 37 -24 11 -30 7 -93 -54 l-67 -65 -37 16 -37 16 -3 95 -3 95 -40 3 c-23 2 -44 0 -48 -4z m100 -303 c96 -44 102 -190 11 -237 -76 -39 -160 -9 -192 69 -20 47 -20 47 0 95 15 38 28 51 64 70 53 27 63 27 117 3z" />
                      </g>
                    </svg>
                  </span>
                </div>
              </div>
            </div>
          </Card>

          {/* Card 2: Contact Details */}
          <Card className="contact-info-card animate-card">
            <h3>Contact Information</h3>
            <div className="contact-fields-row">
              <div className="contact-field-group">
                <label htmlFor="contact-email">Email Address</label>
                <input
                  id="contact-email"
                  name="email"
                  type="email"
                  className="contact-input-readonly"
                  value={user?.email || ''}
                  autoComplete="email"
                  disabled
                  readOnly
                />
              </div>
              <div className="contact-field-group">
                <label htmlFor="contact-phone">Phone Number</label>
                <input
                  id="contact-phone"
                  name="phone"
                  type="text"
                  className="contact-input-readonly"
                  value={user?.phone || 'Not specified'}
                  autoComplete="tel"
                  disabled
                  readOnly
                />
              </div>
            </div>
          </Card>

          {/* Card 3: Passengers Form list */}
          <div ref={passengersCardRef}>
            <Card className="passengers-card animate-card">
              <h3>Passengers</h3>
              <div className="passengers-list-container">
                {passengersList.map((passenger, idx) => (
                  <div key={idx} className="passenger-input-row">
                    <div className="passenger-name-field">
                      <label htmlFor={`passenger-name-${idx}`}>Passenger {idx + 1} (First name, Last name)</label>
                      <input
                        id={`passenger-name-${idx}`}
                        name={`passengerName-${idx}`}
                        type="text"
                        className={`passenger-fullname-input ${showValidationErrors && (!passenger.fullName.trim() || !validateNameFormat(passenger.fullName)) ? 'input-error' : ''}`}
                        placeholder="e.g. John Doe"
                        value={passenger.fullName}
                        onChange={(e) => handlePassengerNameChange(idx, e.target.value)}
                        autoComplete="name"
                        required
                      />
                    </div>

                    <div className="passenger-seat-field">
                      <label style={{ fontSize: 'var(--text-xs)', fontWeight: 'var(--font-bold)', color: 'var(--text-muted)' }}>Assigned Seat</label>
                      <div
                        className={`passenger-seat-indicator ${passenger.seatNumber ? 'assigned' : ''} ${showValidationErrors && !passenger.seatNumber ? 'input-error' : ''}`}
                        onClick={() => seatMapCardRef.current?.scrollIntoView({ behavior: 'smooth', block: 'start' })}
                      >
                        <svg className="seat-indicator-icon" viewBox="20 10 232 252" width="15" height="15" fill="none">
                          <g transform="translate(0.000000,272.000000) scale(0.100000,-0.100000)" fill="currentColor" stroke="none">
                            <path d="M1008 2614 c-33 -17 -49 -46 -77 -137 -24 -80 -20 -115 20 -153 22 -21 41 -28 84 -32 l55 -4 0 -78 0 -77 -102 -5 c-63 -4 -118 -12 -141 -22 -45 -20 -109 -76 -136 -119 -19 -31 -146 -448 -195 -640 -35 -135 -41 -231 -26 -412 l13 -156 41 -21 c23 -11 67 -40 99 -64 33 -24 69 -44 80 -44 12 0 90 13 172 30 207 40 307 51 471 52 183 0 307 -15 531 -62 51 -11 104 -20 117 -20 13 0 50 20 83 44 32 24 76 53 99 64 l41 21 13 156 c15 181 9 277 -26 412 -49 192 -176 609 -195 640 -27 43 -91 99 -136 119 -23 10 -78 18 -140 22 l-103 5 0 77 0 78 55 4 c64 5 109 39 119 89 5 29 -23 138 -50 191 -29 56 -42 58 -406 58 -275 -1 -338 -3 -360 -16z m532 -404 l0 -80 -170 0 -170 0 0 80 0 80 170 0 170 0 0 -80z m32 -390 c80 -25 156 -74 181 -118 26 -45 43 -114 66 -277 21 -146 51 -488 51 -581 l0 -54 -53 0 -53 0 -12 190 c-13 202 -44 469 -68 585 -17 80 -36 105 -105 134 -144 62 -411 39 -488 -43 -37 -39 -81 -330 -103 -676 l-12 -190 -54 0 -55 0 7 138 c12 242 49 564 78 681 25 101 64 148 163 192 116 52 324 60 457 19z" />
                            <path d="M355 665 c-47 -17 -82 -57 -91 -103 -7 -36 11 -195 27 -248 5 -17 22 -42 37 -56 21 -21 277 -157 355 -190 16 -7 17 8 17 230 l0 238 -35 13 c-19 6 -53 28 -77 47 -83 70 -162 94 -233 69z" />
                            <path d="M2290 671 c-46 -10 -87 -32 -139 -75 -23 -19 -57 -41 -76 -47 l-35 -13 0 -238 0 -238 28 12 c15 7 92 46 172 87 143 72 182 98 202 135 11 21 38 184 38 236 0 95 -89 161 -190 141z" />
                            <path d="M1160 614 c-48 -6 -311 -53 -332 -60 -17 -5 -18 -26 -18 -250 l0 -244 560 0 560 0 0 244 c0 224 -1 245 -17 250 -10 3 -81 17 -158 32 -118 22 -172 27 -350 29 -115 2 -226 1 -245 -1z" />
                          </g>
                        </svg>
                        <span>{passenger.seatNumber ? `Seat ${passenger.seatNumber}` : 'Select a seat'}</span>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </Card>
          </div>

          {/* Card 4: Seat reservation layout */}
          <div ref={seatMapCardRef}>
            <Card className="seat-map-card animate-card">
              <h3>Select Seats</h3>
              <div className="seat-map-legend">
                <div className="legend-item">
                  <div className="legend-color available" />
                  <span>Available</span>
                </div>
                <div className="legend-item">
                  <div className="legend-color occupied" />
                  <span>Occupied</span>
                </div>
                <div className="legend-item">
                  <div className="legend-color panoramic" />
                  <span>Panoramic (+{formatPrice(getPanoramicSurcharge())})</span>
                </div>
                <div className="legend-item">
                  <div className="legend-color selected" />
                  <span>Selected</span>
                </div>
              </div>

              <div className="seat-map-scroll-area">
                {/* SVG interactive layout (Resized: 360 width) */}
                <svg className="bus-svg-container" width="360" height="980" viewBox="0 0 360 980">
                  {/* Bus border (grey) */}
                  <rect className="bus-body-outline" x="10" y="10" width="340" height="960" rx="30" ry="30" fill="none" stroke="var(--border-hover)" strokeWidth="3" />

                  {/* Cockpit separating dashed line */}
                  <line x1="10" y1="88" x2="350" y2="88" stroke="var(--border-hover)" strokeWidth="2" strokeDasharray="6,6" />

                  {/* Driver steering wheel */}
                  <circle cx="80" cy="53" r="25" fill="none" stroke="var(--border-hover)" strokeWidth="3.5" />
                  <circle cx="80" cy="53" r="7" fill="var(--border-hover)" />
                  <line x1="80" y1="28" x2="80" y2="78" stroke="var(--border-hover)" strokeWidth="3" />
                  <line x1="55" y1="53" x2="105" y2="53" stroke="var(--border-hover)" strokeWidth="3" />

                  {/* Render seat rows in SVG */}
                  {getSeatLayoutRows().map((rowObj) => {
                    const y = 100 + (rowObj.rowNum - 1) * 60;

                    if (rowObj.rowNum === 14) {
                      // Back row (5 seats) - evenly spaced
                      const xPositions = [24, 89, 154, 219, 284];
                      return rowObj.seats.map((seat, seatIdx) => {
                        const x = xPositions[seatIdx];
                        const isOccupied = trip.occupiedSeats.includes(seat.number!);
                        const isSelected = selectedSeats.includes(seat.number!);
                        const isPanoramic = isSeatPanoramic(seat.number!);

                        let seatClass = 'available';
                        if (isOccupied) seatClass = 'occupied';
                        else if (isSelected) seatClass = 'selected';
                        if (isPanoramic) seatClass += ' panoramic';

                        return (
                          <g
                            key={seat.number!}
                            className={`seat-element-group ${seatClass}`}
                            onClick={() => handleSeatClick(seat.number!, !isOccupied)}
                          >
                            <rect
                              className="seat-rect"
                              x={x}
                              y={y}
                              width="52"
                              height="42"
                              rx="8"
                              fill={isSelected ? 'var(--primary)' : isOccupied ? 'rgba(113, 128, 150, 0.12)' : 'white'}
                              stroke={isSelected ? 'var(--primary)' : isOccupied ? 'var(--border-default)' : 'var(--border-default)'}
                            />
                            {isPanoramic && !isOccupied && !isSelected && (
                              <polygon
                                points={`${x + 26},${4 + y} ${x + 29},${10 + y} ${x + 35},${10 + y} ${x + 30},${14 + y} ${x + 32},${20 + y} ${x + 26},${16 + y} ${x + 20},${20 + y} ${x + 22},${14 + y} ${x + 17},${10 + y} ${x + 23},${10 + y}`}
                                fill="var(--border-hover)"
                              />
                            )}
                            <text
                              className="seat-text"
                              x={x + 26}
                              y={y + (isPanoramic && !isOccupied && !isSelected ? 32 : 26)}
                              textAnchor="middle"
                              fill={isSelected ? 'white' : isOccupied ? 'var(--text-muted)' : 'var(--text-secondary)'}
                            >
                              {isOccupied ? '✕' : seat.number!}
                            </text>
                          </g>
                        );
                      });
                    } else {
                      // Rows 1-13
                      // Column placements (xPlacements) with expanded central aisle (88px wide)
                      const xPlacements = [24, 84, 224, 284];

                      // Row number in the middle aisle
                      const rowNumberText = (
                        <text key={`row-${rowObj.rowNum}`} x="154" y={y + 26} textAnchor="middle" fill="var(--text-muted)" fontSize="12" fontWeight="bold">
                          {rowObj.rowNum}
                        </text>
                      );

                      const seatsJsx = rowObj.seats.map((seat, seatIdx) => {
                        const x = xPlacements[seatIdx];

                        if (seat.type === 'wc') {
                          // Render WC rect once for the row (when seatIdx is 2)
                          if (seatIdx === 2) {
                            return (
                              <g key={`wc-${rowObj.rowNum}`}>
                                <rect x="224" y={y} width="112" height="42" rx="8" fill="var(--bg-elevated)" stroke="var(--border-hover)" strokeWidth="1.5" />
                                <text x="280" y={y + 26} textAnchor="middle" fill="var(--border-hover)" fontSize="12" fontWeight="bold">WC</text>
                              </g>
                            );
                          }
                          return null;
                        }

                        if (seat.type === 'stairs') {
                          // Render Exit/Stairs rect once (when seatIdx is 2)
                          if (seatIdx === 2) {
                            return (
                              <g key={`stairs-${rowObj.rowNum}`}>
                                <rect x="224" y={y} width="112" height="42" rx="8" fill="var(--bg-elevated)" stroke="var(--border-hover)" strokeWidth="1.5" />
                                <line x1="244" y1={y + 10} x2="296" y2={y + 10} stroke="var(--border-hover)" strokeWidth="1.5" />
                                <line x1="244" y1={y + 21} x2="296" y2={y + 21} stroke="var(--border-hover)" strokeWidth="1.5" />
                                <line x1="244" y1={y + 32} x2="296" y2={y + 32} stroke="var(--border-hover)" strokeWidth="1.5" />
                              </g>
                            );
                          }
                          return null;
                        }

                        const isOccupied = trip.occupiedSeats.includes(seat.number!);
                        const isSelected = selectedSeats.includes(seat.number!);
                        const isPanoramic = isSeatPanoramic(seat.number!);

                        let seatClass = 'available';
                        if (isOccupied) seatClass = 'occupied';
                        else if (isSelected) seatClass = 'selected';
                        if (isPanoramic) seatClass += ' panoramic';

                        return (
                          <g
                            key={seat.number!}
                            className={`seat-element-group ${seatClass}`}
                            onClick={() => handleSeatClick(seat.number!, !isOccupied)}
                          >
                            <rect
                              className="seat-rect"
                              x={x}
                              y={y}
                              width="52"
                              height="42"
                              rx="8"
                              fill={isSelected ? 'var(--primary)' : isOccupied ? 'rgba(113, 128, 150, 0.12)' : 'white'}
                              stroke={isSelected ? 'var(--primary)' : isOccupied ? 'var(--border-default)' : 'var(--border-default)'}
                            />
                            {isPanoramic && !isOccupied && !isSelected && (
                              <polygon
                                points={`${x + 26},${4 + y} ${x + 29},${10 + y} ${x + 35},${10 + y} ${x + 30},${14 + y} ${x + 32},${20 + y} ${x + 26},${16 + y} ${x + 20},${20 + y} ${x + 22},${14 + y} ${x + 17},${10 + y} ${x + 23},${10 + y}`}
                                fill="var(--border-hover)"
                              />
                            )}
                            <text
                              className="seat-text"
                              x={x + 26}
                              y={y + (isPanoramic && !isOccupied && !isSelected ? 32 : 26)}
                              textAnchor="middle"
                              fill={isSelected ? 'white' : isOccupied ? 'var(--text-muted)' : 'var(--text-secondary)'}
                            >
                              {isOccupied ? '✕' : seat.number!}
                            </text>
                          </g>
                        );
                      });

                      return (
                        <React.Fragment key={`row-group-${rowObj.rowNum}`}>
                          {rowNumberText}
                          {seatsJsx}
                        </React.Fragment>
                      );
                    }
                  })}
                </svg>
              </div>
            </Card>
          </div>
        </div>

        {/* Sidebar receipt column */}
        <div className="trip-sidebar-column">
          <Card className="checkout-receipt-card animate-card">
            <h3>Your Booking Summary</h3>

            {/* Timer count badge */}
            <div className="checkout-timer-badge">
              <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" strokeWidth="2.5" fill="none">
                <circle cx="12" cy="12" r="10" />
                <polyline points="12 6 12 12 16 14" />
              </svg>
              <span>Time left: <strong>{formatTimerString(timerSeconds)}</strong></span>
            </div>

            {/* Departure & Arrival Terminals */}
            <div className="receipt-route-info">
              <div className="receipt-route-point">
                <span className="point-dot departure-dot"></span>
                <div className="point-details">
                  <span className="point-label">Departure Terminal</span>
                  <span className="point-value">{trip.originTerminalName}</span>
                </div>
              </div>
              <div className="receipt-route-connector"></div>
              <div className="receipt-route-point">
                <span className="point-dot arrival-dot"></span>
                <div className="point-details">
                  <span className="point-label">Arrival Terminal</span>
                  <span className="point-value">{trip.destinationTerminalName}</span>
                </div>
              </div>
            </div>

            {/* Grouped Receipt calculation details */}
            <div className="receipt-items-list">
              <div className="receipt-item-row">
                <span>{passengerCount}x Base Ticket</span>
                <span>{formatPrice(getTicketTotal())}</span>
              </div>

              {/* Grouped seats list sub-details */}
              <div className="receipt-seats-breakdown">
                {standardSeats.length > 0 && (
                  <div className="receipt-seat-group-detail">
                    <span className="label">Standard Seats:</span>
                    <span className="values">{standardSeats.join(', ')}</span>
                  </div>
                )}
                {panoramicSeats.length > 0 && (
                  <div className="receipt-seat-group-detail">
                    <span className="label">Panoramic Seats:</span>
                    <span className="values">{panoramicSeats.join(', ')}</span>
                  </div>
                )}
              </div>

              {/* Multiplied Panoramic seat surcharges */}
              {panoramicSeats.length > 0 && (
                <div className="receipt-item-row surcharge-row">
                  <span>{panoramicSeats.length}x Panoramic Surcharge (+{formatPrice(getPanoramicSurcharge())})</span>
                  <span>+{formatPrice(getSurchargesTotal())}</span>
                </div>
              )}

              <div className="receipt-item-row">
                <span>Service Fee</span>
                <span>{formatPrice(getServiceFee())}</span>
              </div>
            </div>

            <div className="receipt-total-section">
              <div className="receipt-total-row">
                <span>Total</span>
                <span className="total-price-val">{formatPrice(getBookingTotal())}</span>
              </div>
            </div>

            <Button
              variant="primary"
              size="lg"
              fullWidth
              onClick={handlePayClick}
              loading={bookingProcessing}
            >
              Continue to Payment
            </Button>

            {(selectedSeats.length < passengerCount || passengersList.some(p => !p.fullName.trim() || !validateNameFormat(p.fullName))) && (
              <div className="booking-validation-error-msg">
                <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" strokeWidth="2.5" fill="none" strokeLinecap="round" strokeLinejoin="round" className="error-msg-icon">
                  <circle cx="12" cy="12" r="10" />
                  <line x1="12" y1="8" x2="12" y2="12" />
                  <line x1="12" y1="16" x2="12" y2="16" />
                </svg>
                <span>Please specify passenger details and select seats first.</span>
              </div>
            )}
          </Card>
        </div>
      </div>

      {/* Timeout Countdown Alert Modal Overlay */}
      {showTimerModal && (
        <div className="logout-modal-overlay">
          <div className="logout-modal-card" onClick={(e) => e.stopPropagation()}>
            <div className="modal-icon">
              <svg viewBox="0 0 24 24" width="28" height="28" stroke="var(--primary)" strokeWidth="2" fill="none">
                <circle cx="12" cy="12" r="10" />
                <polyline points="12 6 12 12 16 14" />
              </svg>
            </div>
            <h2>Need More Time?</h2>
            <p>Your booking reservation slot has expired. Would you like to extend this booking session or return to search results?</p>
            <div className="modal-buttons">
              <Button variant="ghost" onClick={handleCancelBooking}>
                Cancel
              </Button>
              <Button variant="primary" onClick={handleExtendTimer}>
                More Time
              </Button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default TripDetailsPage;
