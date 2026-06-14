import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { Card, Button } from '../components/common';
import { useCurrency } from '../context/CurrencyContext';
import { reservationsApi, type ReservationResponse } from '../api/reservations';
import './ReservationsPage.css';

export const ReservationsPage: React.FC = () => {
  const navigate = useNavigate();
  const { formatPrice } = useCurrency();
  const [reservations, setReservations] = useState<ReservationResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  
  // Cancellation confirmation modal states
  const [isCancelModalOpen, setIsCancelModalOpen] = useState(false);
  const [reservationToCancel, setReservationToCancel] = useState<ReservationResponse | null>(null);
  const [cancellingId, setCancellingId] = useState<number | null>(null);

  // Success Toast states
  const [showToast, setShowToast] = useState(false);
  const [toastMessage, setToastMessage] = useState('');

  // Active filter tab
  const [filter, setFilter] = useState<'upcoming' | 'all'>('upcoming');

  // Ticket modal overlay state
  const [isTicketOpen, setIsTicketOpen] = useState(false);
  const [selectedReservation, setSelectedReservation] = useState<ReservationResponse | null>(null);

  useEffect(() => {
    fetchReservations();
  }, []);

  // Block page scroll when ticket window overlay is open
  useEffect(() => {
    if (isTicketOpen) {
      document.body.style.overflow = 'hidden';
    } else {
      document.body.style.overflow = '';
    }
    return () => {
      document.body.style.overflow = '';
    };
  }, [isTicketOpen]);

  const fetchReservations = async () => {
    setLoading(true);
    try {
      const data = await reservationsApi.getMyReservations();
      setReservations(data);
    } catch {
      setError('Failed to load reservations');
    } finally {
      setLoading(false);
    }
  };

  const handleOpenCancelModal = (reservation: ReservationResponse) => {
    setReservationToCancel(reservation);
    setIsCancelModalOpen(true);
  };

  const handleConfirmCancel = async () => {
    if (!reservationToCancel) return;
    
    const id = reservationToCancel.id;
    setCancellingId(id);
    try {
      await reservationsApi.cancel(id);
      
      // Update local state to mark status as CANCELLED
      setReservations(prev =>
        prev.map(r => r.id === id ? { ...r, status: 'CANCELLED' } : r)
      );

      // Trigger detailed success toast notification
      const origin = reservationToCancel.originTerminalName;
      const dest = reservationToCancel.targetTerminalName;
      const depDate = formatDate(reservationToCancel.trip.departure);
      const depTime = formatTime(reservationToCancel.trip.departure);
      
      setToastMessage(
        `Trip from ${origin} to ${dest} departing on ${depDate} ${depTime} has been successfully cancelled. Please expect a refund within a week.`
      );
      setShowToast(true);
      setIsCancelModalOpen(false);
      setReservationToCancel(null);
    } catch {
      alert('Failed to cancel reservation');
    } finally {
      setCancellingId(null);
    }
  };

  const formatDate = (datetime: string) => {
    return new Date(datetime).toLocaleDateString('en-US', {
      weekday: 'short',
      month: 'short',
      day: 'numeric',
      year: 'numeric'
    });
  };

  const formatTime = (datetime: string) => {
    return new Date(datetime).toLocaleTimeString('en-US', {
      hour: '2-digit',
      minute: '2-digit',
      hour12: false
    });
  };

  const getDisplayStatus = (reservation: ReservationResponse) => {
    const status = reservation.status.toUpperCase();
    const isPast = new Date(reservation.trip.departure) < new Date();
    
    if (status === 'CANCELLED') {
      return 'CANCELLED';
    }
    if (status === 'CONFIRMED' || status === 'PAID') {
      if (isPast) {
        const hasCheckedIn = reservation.passengers.some(p => p.checkedIn);
        return hasCheckedIn ? 'COMPLETED' : 'EXPIRED';
      }
      return 'UPCOMING';
    }
    if (status === 'PENDING' && isPast) {
      return 'EXPIRED';
    }
    return status;
  };

  const getStatusClass = (status: string) => {
    switch (status.toUpperCase()) {
      case 'UPCOMING':
      case 'CONFIRMED':
      case 'PAID':
        return 'status-success';
      case 'COMPLETED':
        return 'status-completed';
      case 'EXPIRED':
      case 'CANCELLED':
        return 'status-error';
      default:
        return 'status-pending';
    }
  };

  const getDeterministicPlatform = (id: number, type: 'departure' | 'arrival') => {
    const letters = ['A', 'B', 'C', 'D'];
    const typeSalt = type === 'departure' ? 7 : 13;
    const val = (id * typeSalt + 3) % 40; // 10 numbers * 4 letters = 40 possibilities
    const number = Math.floor(val / 4) + 1; // 1 to 10
    const letter = letters[val % 4];
    return `${number}${letter}`;
  };

  const getCleanBusName = (busName: string) => {
    const m = busName || '';
    const parts = m.split(' ');
    if (parts.length > 1 && parts[0].toLowerCase() === parts[1].toLowerCase()) {
      return parts.slice(1).join(' ');
    }
    return m;
  };

  const isSeatPanoramic = (seatNo: string, seatLayout: string | null) => {
    if (!seatLayout) return false;
    try {
      const layout = JSON.parse(seatLayout);
      const panoramic = layout?.categories?.PANORAMIC || [];
      return panoramic.includes(seatNo);
    } catch {
      return false;
    }
  };

  const getPanoramicSurcharge = (reservation: ReservationResponse) => {
    return Number((reservation.distance * 0.004).toFixed(2));
  };
 
  const handleShowTicket = (reservation: ReservationResponse) => {
    setSelectedReservation(reservation);
    setIsTicketOpen(true);
  };

  // Filter reservations based on active tab:
  // - 'upcoming': ONLY confirmed future trips (no cancelled, no pending, no past)
  // - 'all': confirmed trips (both future and past), fully EXCLUDING cancelled and pending trips
  const filteredReservations = reservations.filter(r => {
    const status = r.status.toUpperCase();
    const isConfirmed = status === 'CONFIRMED' || status === 'PAID';
    const isFuture = new Date(r.trip.departure) >= new Date();

    if (filter === 'upcoming') {
      return isConfirmed && isFuture;
    } else {
      return isConfirmed; // 'all' filter shows only confirmed trips
    }
  });

  // Sort reservations:
  // - 'upcoming': chronologically (earliest departure first)
  // - 'all': 
  //   1. All upcoming trips first, sorted chronologically (closest first)
  //   2. All completed trips second, sorted reverse-chronologically (newest completed first)
  //   3. For multiple reservations on the same trip, sort by creation date (createdAt) descending (newest first)
  const sortedReservations = [...filteredReservations].sort((a, b) => {
    const dateA = new Date(a.trip.departure).getTime();
    const dateB = new Date(b.trip.departure).getTime();
    
    if (dateA === dateB) {
      // Same trip, sort by createdAt desc (newest first)
      const createdA = new Date(a.createdAt).getTime();
      const createdB = new Date(b.createdAt).getTime();
      return createdB - createdA;
    }

    if (filter === 'upcoming') {
      return dateA - dateB;
    } else {
      const isFutureA = dateA >= Date.now();
      const isFutureB = dateB >= Date.now();

      // 1. If one is future (upcoming) and one is past (completed), future comes first
      if (isFutureA && !isFutureB) return -1;
      if (!isFutureA && isFutureB) return 1;

      // 2. If both are future, sort chronologically (earliest first)
      if (isFutureA && isFutureB) {
        return dateA - dateB;
      }

      // 3. If both are past, sort reverse-chronologically (latest completed first)
      return dateB - dateA;
    }
  });

  // Toast auto-close timeout
  useEffect(() => {
    if (showToast) {
      const timer = setTimeout(() => {
        setShowToast(false);
      }, 5000);
      return () => clearTimeout(timer);
    }
  }, [showToast]);

  return (
    <div className="dashboard-page">
      <div className="profile-container reservations-container">
        <div className="profile-neobrutalist-card no-shadow">
          <div className="profile-card-header">
            <div className="profile-header-title-row">
              <span className="profile-sheet-title">MY RESERVATIONS</span>
            </div>
            <div className="profile-divider-line" />
          </div>

          <div className="reservations-body">
            {loading ? (
              <div className="loading-state">
                <div className="loading-spinner" />
                <p>Loading your reservations...</p>
              </div>
            ) : (
              <>
                {error && <div className="error-message">{error}</div>}

                {/* Filter Switcher with counters */}
                {reservations.length > 0 && (
                  <div className="reservations-switcher-container">
                    <div className="reservations-switcher">
                      <button
                        type="button"
                        className={`switcher-tab ${filter === 'upcoming' ? 'active' : ''}`}
                        onClick={() => setFilter('upcoming')}
                      >
                        Upcoming
                        <span className="switcher-badge">
                          {reservations.filter(r => {
                            const isConfirmed = r.status.toUpperCase() === 'CONFIRMED' || r.status.toUpperCase() === 'PAID';
                            const isFuture = new Date(r.trip.departure) >= new Date();
                            return isConfirmed && isFuture;
                          }).length}
                        </span>
                      </button>
                      <button
                        type="button"
                        className={`switcher-tab ${filter === 'all' ? 'active' : ''}`}
                        onClick={() => setFilter('all')}
                      >
                        All
                        <span className="switcher-badge">
                          {reservations.filter(r => {
                            const status = r.status.toUpperCase();
                            return status === 'CONFIRMED' || status === 'PAID';
                          }).length}
                        </span>
                      </button>
                    </div>
                  </div>
                )}

                {sortedReservations.length === 0 ? (
                  <div className="empty-state">
                    <div className="empty-icon">
                      <svg viewBox="0 0 80 50" width="80" height="50" fill="none" xmlns="http://www.w3.org/2000/svg">
                        {/* Outer ticket shape with notches cut out using clip */}
                        <rect x="2" y="2" width="76" height="46" rx="7" fill="white" stroke="#B0B7C3" strokeWidth="3"/>
                        {/* Left notch - white circle over border */}
                        <circle cx="2" cy="25" r="7" fill="#F3F4F6"/>
                        <path d="M2 18 A7 7 0 0 1 2 32" fill="#F3F4F6" stroke="#B0B7C3" strokeWidth="3"/>
                        {/* Right notch */}
                        <circle cx="78" cy="25" r="7" fill="#F3F4F6"/>
                        <path d="M78 18 A7 7 0 0 0 78 32" fill="#F3F4F6" stroke="#B0B7C3" strokeWidth="3"/>
                        {/* Dashed vertical separator */}
                        <line x1="22" y1="5" x2="22" y2="45" stroke="#B0B7C3" strokeWidth="2.5" strokeDasharray="4 4" strokeLinecap="round"/>
                        {/* Three horizontal lines in main area */}
                        <line x1="32" y1="17" x2="68" y2="17" stroke="#B0B7C3" strokeWidth="3" strokeLinecap="round"/>
                        <line x1="32" y1="25" x2="68" y2="25" stroke="#B0B7C3" strokeWidth="3" strokeLinecap="round"/>
                        <line x1="32" y1="33" x2="60" y2="33" stroke="#B0B7C3" strokeWidth="3" strokeLinecap="round"/>
                      </svg>
                    </div>
                    <h3>No reservations found</h3>
                    <p>
                      {reservations.length === 0
                        ? 'Start exploring amazing destinations and book your first trip!'
                        : "You don't have any upcoming active reservations. Switch to All to see your travel history."}
                    </p>
                    <Button variant="primary" onClick={() => {
                      navigate('/');
                      setTimeout(() => {
                        const el = document.getElementById('search-panel');
                        if (el) el.scrollIntoView({ behavior: 'smooth', block: 'center' });
                      }, 150);
                    }}>
                      Find Trips
                    </Button>
                  </div>
                ) : (
                  <div className="reservations-list">
                    {sortedReservations.map((reservation) => {
                      const displayStatus = getDisplayStatus(reservation);
                      const isCancelled = displayStatus === 'CANCELLED';
                      const isUpcoming = displayStatus === 'UPCOMING';
                      
                      return (
                        <Card 
                          key={reservation.id} 
                          className={`reservation-card ${isCancelled ? 'cancelled' : ''}`}
                          variant="outline"
                        >
                          <div className="reservation-header">
                            <div className="trip-header-time">
                              <span className="header-date">{formatDate(reservation.trip.departure)}</span>
                              <span className="header-time">{formatTime(reservation.trip.departure)}</span>
                            </div>
                            <span className={`status-badge ${getStatusClass(displayStatus)}`}>
                              {displayStatus}
                            </span>
                          </div>

                          <div className="reservation-content">
                            {/* Vertical timeline details with orange connector line */}
                            <div className="reservation-route-container">
                              <div className="reservation-route-line"></div>

                              <div className="reservation-route-point">
                                <span className="reservation-point-label">Departure Terminal</span>
                                <div className="reservation-point-value-container">
                                  <span className="reservation-point-dot departure-dot"></span>
                                  <span className="reservation-point-value">{reservation.originTerminalName}</span>
                                </div>
                              </div>

                              <div className="reservation-route-point">
                                <span className="reservation-point-label">Arrival Terminal</span>
                                <div className="reservation-point-value-container">
                                  <span className="reservation-point-dot arrival-dot"></span>
                                  <span className="reservation-point-value">{reservation.targetTerminalName}</span>
                                </div>
                              </div>
                            </div>

                            <div className="passengers-info">
                              <span className="passengers-label">Passengers</span>
                              <div className="passengers-list">
                                {reservation.passengers.map((p, i) => (
                                  <span key={i} className="passenger-name">
                                    {p.firstName} {p.lastName}{p.seatNumber ? ` (Seat ${p.seatNumber})` : ''}
                                  </span>
                                ))}
                              </div>
                            </div>
                          </div>

                          <div className="reservation-actions">
                            {!isCancelled && (
                              <>
                                {/* Cancel button only visible for UPCOMING status */}
                                {isUpcoming && (
                                  <Button
                                    variant="outline"
                                    onClick={() => handleOpenCancelModal(reservation)}
                                    loading={cancellingId === reservation.id}
                                  >
                                    Cancel
                                  </Button>
                                )}
                                <Button
                                  variant="primary"
                                  onClick={() => handleShowTicket(reservation)}
                                >
                                  Show Ticket
                                </Button>
                              </>
                            )}
                            {isCancelled && (
                              <span className="cancelled-indicator-stamp">CANCELLED</span>
                            )}
                          </div>
                        </Card>
                      );
                    })}
                  </div>
                )}
              </>
            )}
          </div>
        </div>
      </div>

      {/* Flat Paper Ticket Modal Overlay */}
      {isTicketOpen && selectedReservation && (
        <div className="ticket-overlay-backdrop" onClick={() => setIsTicketOpen(false)}>
          {/* Big close cross positioned in the corner of the window backdrop */}
          <button className="ticket-window-close-btn" onClick={() => setIsTicketOpen(false)} title="Close Ticket">
            ✕
          </button>

          <div className="ticket-paper-card no-shadow" onClick={(e) => e.stopPropagation()}>
            {/* Ticket Header */}
            <div className="ticket-header">
              <div className="ticket-header-title">BOARDING TICKET</div>
              <div className="ticket-ref-box">
                <span className="ticket-ref-label">BOOKING REF</span>
                <span className="ticket-ref-value">{selectedReservation.bookingReference}</span>
              </div>
            </div>

            {/* Journey Segment Details with vertical connector and arrival times */}
            <div className="ticket-journey-section">
              <div className="ticket-station-column">
                <div className="ticket-station-time">
                  <span className="ticket-time">{formatTime(selectedReservation.trip.departure)}</span>
                  <span className="ticket-date">{formatDate(selectedReservation.trip.departure)}</span>
                </div>
                <div className="ticket-station-name">
                  <div className="ticket-terminal-title">{selectedReservation.originTerminalName}</div>
                  <div className="ticket-platform-tag">
                    Platform {getDeterministicPlatform(selectedReservation.id, 'departure')}
                  </div>
                </div>
              </div>

              {/* Vertical Connector Arrow */}
              <div className="ticket-vertical-arrow-row">
                <div className="ticket-arrow-spacer"></div>
                <div className="ticket-arrow-container">
                  <span className="vertical-arrow">↓</span>
                </div>
              </div>

              <div className="ticket-station-column">
                <div className="ticket-station-time">
                  <span className="ticket-time">{formatTime(selectedReservation.trip.arrivalDatetime)}</span>
                  <span className="ticket-date">{formatDate(selectedReservation.trip.arrivalDatetime)}</span>
                </div>
                <div className="ticket-station-name">
                  <div className="ticket-terminal-title">{selectedReservation.targetTerminalName}</div>
                  <div className="ticket-platform-tag">
                    Platform {getDeterministicPlatform(selectedReservation.id, 'arrival')}
                  </div>
                </div>
              </div>
            </div>

            {/* Driver & Bus Info */}
            <div className="ticket-meta-section">
              <div className="ticket-meta-grid">
                <div className="ticket-meta-item">
                  <span className="ticket-meta-label">DRIVER</span>
                  <span className="ticket-meta-value">{selectedReservation.trip.driverName || 'N/A'}</span>
                </div>
                <div className="ticket-meta-item">
                  <span className="ticket-meta-label">BUS MODEL</span>
                  <span className="ticket-meta-value">{getCleanBusName(selectedReservation.trip.busName)}</span>
                </div>
                <div className="ticket-meta-item">
                  <span className="ticket-meta-label">PLATE NUMBER</span>
                  <span className="ticket-meta-value">{selectedReservation.trip.busRegistrationNumber}</span>
                </div>
              </div>
            </div>

            {/* Flat dashed divider (no side punch holes) */}
            <div className="ticket-stub-divider flat" />

            {/* Passengers & Large QR Codes Section */}
            <div className="ticket-passengers-section">
              <div className="ticket-section-title">PASSENGERS & SEATS</div>
              <div className="ticket-passengers-list">
                {selectedReservation.passengers.map((passenger, i) => {
                  const qrData = `${selectedReservation.bookingReference}-${passenger.firstName}-${passenger.lastName}-${passenger.seatNumber || 'NS'}`;
                  return (
                    <div key={i} className="ticket-passenger-card vertical">
                      <div className="ticket-passenger-details">
                        <div className="ticket-passenger-name">
                          {passenger.firstName} {passenger.lastName}
                        </div>
                        <div className="ticket-passenger-seat">
                          SEAT: <span className="seat-bold">{passenger.seatNumber || 'Not specified'}</span>
                        </div>
                      </div>
                      <div className="ticket-qr-container large">
                        <img 
                          src={`https://api.qrserver.com/v1/create-qr-code/?size=220x220&data=${encodeURIComponent(qrData)}`} 
                          alt="Passenger QR Code" 
                          className="ticket-qr-image"
                        />
                      </div>
                    </div>
                  );
                })}
              </div>
            </div>

            {/* Flat dashed divider 2 */}
            <div className="ticket-stub-divider flat" />

            {/* Bottom Receipt Details matching Booking card layout */}
            {(() => {
              const allSeats = selectedReservation.passengers.map(p => p.seatNumber).filter(Boolean);
              const panoramicSeats = allSeats.filter(seat => isSeatPanoramic(seat, selectedReservation.trip.seatLayout));
              const standardSeats = allSeats.filter(seat => !isSeatPanoramic(seat, selectedReservation.trip.seatLayout));
              const panoramicSurchargePerSeat = getPanoramicSurcharge(selectedReservation);
              const surchargesTotal = panoramicSeats.length * panoramicSurchargePerSeat;
              const serviceFee = 0.5;
              const baseTicketTotal = Math.max(0, selectedReservation.totalAmount - serviceFee - surchargesTotal);

              return (
                <div className="ticket-receipt-section">
                  <div className="ticket-receipt-title">booking receipt</div>
                  <div className="ticket-receipt-grid font-small">
                    <div className="ticket-receipt-row">
                      <span>{selectedReservation.passengers.length}x Base Ticket</span>
                      <span className="price-bold">{formatPrice(baseTicketTotal)}</span>
                    </div>
                    
                    {/* Assigned Seats header & nested lists */}
                    <div className="ticket-receipt-row assigned-seats-header-row">
                      <span className="label-bold">Assigned Seats</span>
                    </div>
                    <div className="ticket-seat-breakdown-row nested-seat-row">
                      <span className="label">Standard:</span>
                      <span className="values">[{standardSeats.join(', ')}]</span>
                    </div>
                    <div className="ticket-seat-breakdown-row nested-seat-row">
                      <span className="label">Panoramic:</span>
                      <span className="values">[{panoramicSeats.join(', ')}]</span>
                    </div>

                    {/* Surcharges */}
                    {panoramicSeats.length > 0 && (
                      <div className="ticket-receipt-row surcharge-row">
                        <span>{panoramicSeats.length}x Panoramic Surcharge (+{formatPrice(panoramicSurchargePerSeat)})</span>
                        <span>+{formatPrice(surchargesTotal)}</span>
                      </div>
                    )}

                    {/* Service Fee */}
                    <div className="ticket-receipt-row">
                      <span>Service Fee</span>
                      <span>{formatPrice(serviceFee)}</span>
                    </div>

                    <div className="ticket-receipt-row total">
                      <span>Total Paid</span>
                      <span className="total-price-val">{formatPrice(selectedReservation.totalAmount)}</span>
                    </div>
                  </div>
                </div>
              );
            })()}
          </div>
        </div>
      )}

      {/* Asynchronous Cancellation Confirmation Modal */}
      {isCancelModalOpen && reservationToCancel && (
        <div className="logout-modal-overlay" onClick={() => setIsCancelModalOpen(false)}>
          <div className="logout-modal-card no-shadow" onClick={(e) => e.stopPropagation()}>
            <div className="modal-icon">
              <svg viewBox="0 0 24 24" width="28" height="28" stroke="var(--primary)" strokeWidth="2" fill="none">
                <circle cx="12" cy="12" r="10" />
                <line x1="12" y1="8" x2="12" y2="12" />
                <line x1="12" y1="16" x2="12" y2="16" />
              </svg>
            </div>
            <h2>Cancel Reservation</h2>
            <p>
              Are you sure you want to cancel the trip from{' '}
              <strong>{reservationToCancel.originTerminalName}</strong> to{' '}
              <strong>{reservationToCancel.targetTerminalName}</strong> departing on{' '}
              {formatDate(reservationToCancel.trip.departure)} at{' '}
              {formatTime(reservationToCancel.trip.departure)}?
            </p>
            <div className="modal-buttons">
              <Button variant="ghost" onClick={() => setIsCancelModalOpen(false)}>
                Abort Action
              </Button>
              <Button 
                variant="primary" 
                onClick={handleConfirmCancel} 
                className="btn-danger"
                loading={cancellingId === reservationToCancel.id}
              >
                Cancel Trip
              </Button>
            </div>
          </div>
        </div>
      )}

      {/* Large Success Toast Notification */}
      <div 
        className={`toast-notification large-toast ${showToast ? 'show' : ''}`}
        onClick={() => setShowToast(false)}
      >
        <div className="toast-icon">
          <svg viewBox="0 0 24 24" width="28" height="28" stroke="var(--success)" strokeWidth="2.5" fill="none">
            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" />
            <polyline points="22 4 12 14.01 9 11.01" />
          </svg>
        </div>
        <span className="toast-message font-medium">{toastMessage}</span>
      </div>
    </div>
  );
};

export default ReservationsPage;
