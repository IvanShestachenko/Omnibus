import React, { useState, useEffect, useRef } from 'react';
import { useSearchParams, useNavigate, useLocation } from 'react-router-dom';
import { Card, Button, SearchPanel } from '../components/common';
import { useCurrency } from '../context/CurrencyContext';
import { useAuth } from '../context/AuthContext';
import { tripsApi, type TripResponse } from '../api/trips';
import './SearchPage.css';

export const SearchPage: React.FC = () => {
  const [searchParams] = useSearchParams();
  const navigate = useNavigate();
  const location = useLocation();
  const { formatPrice } = useCurrency();
  const { isAuthenticated } = useAuth();

  const [isAuthModalOpen, setIsAuthModalOpen] = useState(false);
  const [showSoldOutModal, setShowSoldOutModal] = useState(false);

  useEffect(() => {
    if (location.state?.showSoldOutModal) {
      setShowSoldOutModal(true);
      // clear router state
      window.history.replaceState({}, document.title);
    }
  }, [location.state]);

  const fromCity = searchParams.get('fromCity') || '';
  const fromTerminalId = searchParams.get('fromTerminalId');
  const toCity = searchParams.get('toCity') || '';
  const toTerminalId = searchParams.get('toTerminalId');
  const date = searchParams.get('date') || '';
  const passengers = Number(searchParams.get('passengers')) || 1;

  const [trips, setTrips] = useState<TripResponse[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [sortBy, setSortBy] = useState<'earliest' | 'cheapest' | 'fastest'>('earliest');
  const [isSortOpen, setIsSortOpen] = useState(false);
  const sortDropdownRef = useRef<HTMLDivElement>(null);

  // Click outside listener for sort dropdown
  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (sortDropdownRef.current && !sortDropdownRef.current.contains(e.target as Node)) {
        setIsSortOpen(false);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  // Search trips when params change
  useEffect(() => {
    if (fromCity && toCity && date) {
      const fetchTrips = async () => {
        setLoading(true);
        setError('');
        try {
          const params = {
            fromCity,
            fromTerminalId: fromTerminalId ? Number(fromTerminalId) : null,
            toCity,
            toTerminalId: toTerminalId ? Number(toTerminalId) : null,
            date,
            passengers
          };
          const data = await tripsApi.search(params);
          setTrips(data);
          if (data.length === 0) {
            setError('No trips found matching your query. Try a different date or locations.');
          }
        } catch {
          setError('Failed to search trips. Please try again.');
          setTrips([]);
        } finally {
          setLoading(false);
        }
      };
      fetchTrips();
    } else {
      setTrips([]);
    }
  }, [fromCity, fromTerminalId, toCity, toTerminalId, date, passengers]);

  // Group trips by departure date (YYYY-MM-DD) in local timezone
  const groupTripsByDate = (tripsList: TripResponse[]) => {
    const groups: { [key: string]: TripResponse[] } = {};
    tripsList.forEach(trip => {
      const d = new Date(trip.departureDatetime);
      const yyyy = d.getFullYear();
      const mm = String(d.getMonth() + 1).padStart(2, '0');
      const dd = String(d.getDate()).padStart(2, '0');
      const dateKey = `${yyyy}-${mm}-${dd}`;
      if (!groups[dateKey]) {
        groups[dateKey] = [];
      }
      groups[dateKey].push(trip);
    });
    return groups;
  };

  const formatDateHeader = (dateStr: string) => {
    const [year, month, day] = dateStr.split('-').map(Number);
    const d = new Date(year, month - 1, day);
    return d.toLocaleDateString('en-US', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  };

  const formatTime = (datetime: string) => {
    return new Date(datetime).toLocaleTimeString('en-US', {
      hour: '2-digit',
      minute: '2-digit',
      hour12: false
    });
  };

  const getDaysDifference = (departure: string, arrival: string) => {
    const depDate = new Date(departure);
    const arrDate = new Date(arrival);
    const depMidnight = new Date(depDate.getFullYear(), depDate.getMonth(), depDate.getDate());
    const arrMidnight = new Date(arrDate.getFullYear(), arrDate.getMonth(), arrDate.getDate());
    const diffTime = arrMidnight.getTime() - depMidnight.getTime();
    return Math.round(diffTime / (1000 * 60 * 60 * 24));
  };

  const formatDuration = (departure: string, arrival: string) => {
    const start = new Date(departure);
    const end = new Date(arrival);
    const diff = (end.getTime() - start.getTime()) / (1000 * 60);
    const hours = Math.floor(diff / 60);
    const mins = Math.round(diff % 60);
    return `${hours}h ${mins}m`;
  };

  // Client-side sorting logic
  const getSortedTrips = (tripsList: TripResponse[]) => {
    const tripsCopy = [...tripsList];
    if (sortBy === 'cheapest') {
      return tripsCopy.sort((a, b) => a.price - b.price);
    }
    if (sortBy === 'fastest') {
      return tripsCopy.sort((a, b) => {
        const durationA = new Date(a.arrivalDatetime).getTime() - new Date(a.departureDatetime).getTime();
        const durationB = new Date(b.arrivalDatetime).getTime() - new Date(b.departureDatetime).getTime();
        return durationA - durationB;
      });
    }
    // default earliest
    return tripsCopy.sort((a, b) => new Date(a.departureDatetime).getTime() - new Date(b.departureDatetime).getTime());
  };

  const handleCardClick = (tripId: number) => {
    if (!isAuthenticated) {
      setIsAuthModalOpen(true);
    } else {
      navigate(`/trip/${tripId}${location.search}`);
    }
  };

  // Reusable redesigned trip card rendering matching the layout in the screenshot
  const renderTripCard = (trip: TripResponse) => {
    const isSoldOut = trip.availableSeats.length === 0;
    const isInsufficient = trip.availableSeats.length > 0 && trip.availableSeats.length < passengers;
    const isUnavailable = isSoldOut || isInsufficient;
    const hasNextDay = getDaysDifference(trip.departureDatetime, trip.arrivalDatetime) > 0;
    return (
      <Card
        key={trip.id}
        className={`trip-card-redesign ${isUnavailable ? 'disabled' : ''}`}
        hoverable={!isUnavailable}
        onClick={() => !isUnavailable && handleCardClick(trip.id)}
      >
        <div className="trip-card-main-row">
          <div className={`trip-timeline-col ${hasNextDay ? 'has-next-day' : ''}`}>
            <div className="trip-time-start">
              <span className="time">{formatTime(trip.departureDatetime)}</span>
            </div>

            <div className="trip-duration-line-container">
              <span className="duration-label">{formatDuration(trip.departureDatetime, trip.arrivalDatetime)}</span>
              <div className="duration-line-horizontal">
                <div className="dot start-dot" />
                <div className="line-connector" />
                <div className="dot end-dot" />
              </div>
            </div>

            <div className="trip-time-end">
              <span className="time">{formatTime(trip.arrivalDatetime)}</span>
              {(() => {
                const diff = getDaysDifference(trip.departureDatetime, trip.arrivalDatetime);
                return diff > 0 ? (
                  <span className="next-day-label">(+{diff} day{diff > 1 ? 's' : ''})</span>
                ) : null;
              })()}
            </div>

            <div className="trip-station-start">
              <span className="station">{trip.originTerminalName}</span>
            </div>

            <div className="trip-station-middle-spacer" />

            <div className="trip-station-end">
              <span className="station">{trip.destinationTerminalName}</span>
            </div>
          </div>

          <div className="trip-price-col desktop-price">
            <span className="trip-price-val">{formatPrice(trip.price)}</span>
            <span className="trip-price-sub">per seat</span>
          </div>
        </div>

        <div className="trip-card-footer-row">
          <div className="trip-fleet-icons">
            <span className="fleet-icon-wrapper" title="High-speed Wi-Fi">
              <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" strokeWidth="2.5" fill="none" strokeLinecap="round" strokeLinejoin="round">
                <path d="M5 12.55a11 11 0 0 1 14.08 0" />
                <path d="M1.42 9a16 16 0 0 1 21.16 0" />
                <path d="M8.53 16.11a6 6 0 0 1 6.95 0" />
                <line x1="12" y1="20" x2="12.01" y2="20" />
              </svg>
            </span>
            <span className="fleet-icon-wrapper" title="USB & Power Outlets">
              <svg viewBox="18 16 131 133" width="16" height="16" fill="none">
                <g transform="translate(0.000000,165.000000) scale(0.100000,-0.100000)" fill="currentColor" stroke="none">
                  <path d="M280 1410 c-19 -19 -20 -33 -20 -434 l0 -415 26 -20 c25 -20 39 -21 238 -21 200 0 214 1 234 20 22 21 22 22 22 435 0 402 -1 416 -20 435 -19 19 -33 20 -240 20 -207 0 -221 -1 -240 -20z m290 -40 c0 -5 -22 -10 -50 -10 -27 0 -50 5 -50 10 0 6 23 10 50 10 28 0 50 -4 50 -10z m180 -380 l0 -330 -230 0 -230 0 0 330 0 330 230 0 230 0 0 -330z m-206 -376 c9 -8 16 -19 16 -24 0 -11 -29 -40 -40 -40 -5 0 -16 10 -24 22 -14 20 -14 24 1 40 20 22 27 22 47 2z"/>
                  <path d="M492 1082 c-39 -59 -72 -110 -72 -114 0 -5 18 -8 41 -8 34 0 39 -3 35 -17 -16 -54 -28 -113 -24 -124 4 -12 148 183 148 201 0 5 -18 10 -40 10 -46 0 -46 0 -24 82 8 33 14 64 12 69 -2 4 -36 -40 -76 -99z"/>
                  <path d="M986 1334 c-24 -23 -24 -385 0 -408 8 -9 20 -16 25 -16 12 0 12 23 -1 36 -7 7 -9 77 -8 190 l3 179 170 0 170 0 3 -179 c1 -113 -1 -183 -8 -190 -13 -13 -13 -36 -1 -36 5 0 17 7 25 16 24 23 24 385 0 408 -13 13 -45 16 -189 16 -144 0 -176 -3 -189 -16z"/>
                  <path d="M1107 1214 c-13 -13 -7 -71 8 -84 19 -16 28 4 23 51 -3 32 -17 46 -31 33z"/>
                  <path d="M1217 1213 c-10 -10 -8 -81 2 -87 18 -11 32 22 25 58 -6 35 -14 43 -27 29z"/>
                  <path d="M1052 1082 c-9 -7 -12 -47 -10 -168 l3 -159 130 0 130 0 3 159 c2 121 -1 161 -10 168 -7 4 -62 8 -123 8 -60 0 -116 -4 -123 -8z"/>
                  <path d="M1130 692 c0 -35 4 -52 15 -56 12 -4 15 -29 15 -133 0 -70 -5 -144 -10 -164 -15 -54 -51 -101 -95 -126 -37 -21 -52 -23 -215 -23 -163 0 -178 2 -215 23 -26 14 -48 37 -62 67 -27 51 -30 115 -8 124 11 4 15 20 15 56 l0 50 -50 0 -50 0 0 -50 c0 -30 5 -52 13 -57 8 -4 17 -30 20 -57 13 -95 71 -163 160 -187 24 -6 106 -9 201 -7 173 3 211 13 263 70 51 54 63 103 63 258 0 134 2 147 21 163 15 13 19 27 17 55 -3 37 -4 37 -50 40 l-48 3 0 -49z"/>
                </g>
              </svg>
            </span>
            <span className="fleet-icon-wrapper" title="Adjustable Seats">
              <svg viewBox="20 10 232 252" width="16" height="16" fill="none">
                <g transform="translate(0.000000,272.000000) scale(0.100000,-0.100000)" fill="currentColor" stroke="none">
                  <path d="M1008 2614 c-33 -17 -49 -46 -77 -137 -24 -80 -20 -115 20 -153 22 -21 41 -28 84 -32 l55 -4 0 -78 0 -77 -102 -5 c-63 -4 -118 -12 -141 -22 -45 -20 -109 -76 -136 -119 -19 -31 -146 -448 -195 -640 -35 -135 -41 -231 -26 -412 l13 -156 41 -21 c23 -11 67 -40 99 -64 33 -24 69 -44 80 -44 12 0 90 13 172 30 207 40 307 51 471 52 183 0 307 -15 531 -62 51 -11 104 -20 117 -20 13 0 50 20 83 44 32 24 76 53 99 64 l41 21 13 156 c15 181 9 277 -26 412 -49 192 -176 609 -195 640 -27 43 -91 99 -136 119 -23 10 -78 18 -140 22 l-103 5 0 77 0 78 55 4 c64 5 109 39 119 89 5 29 -23 138 -50 191 -29 56 -42 58 -406 58 -275 -1 -338 -3 -360 -16z m532 -404 l0 -80 -170 0 -170 0 0 80 0 80 170 0 170 0 0 -80z m32 -390 c80 -25 156 -74 181 -118 26 -45 43 -114 66 -277 21 -146 51 -488 51 -581 l0 -54 -53 0 -53 0 -12 190 c-13 202 -44 469 -68 585 -17 80 -36 105 -105 134 -144 62 -411 39 -488 -43 -37 -39 -81 -330 -103 -676 l-12 -190 -54 0 -55 0 7 138 c12 242 49 564 78 681 25 101 64 148 163 192 116 52 324 60 457 19z"/>
                  <path d="M355 665 c-47 -17 -82 -57 -91 -103 -7 -36 11 -195 27 -248 5 -17 22 -42 37 -56 21 -21 277 -157 355 -190 16 -7 17 8 17 230 l0 238 -35 13 c-19 6 -53 28 -77 47 -83 70 -162 94 -233 69z"/>
                  <path d="M2290 671 c-46 -10 -87 -32 -139 -75 -23 -19 -57 -41 -76 -47 l-35 -13 0 -238 0 -238 28 12 c15 7 92 46 172 87 143 72 182 98 202 135 11 21 38 184 38 236 0 95 -89 161 -190 141z"/>
                  <path d="M1160 614 c-48 -6 -311 -53 -332 -60 -17 -5 -18 -26 -18 -250 l0 -244 560 0 560 0 0 244 c0 224 -1 245 -17 250 -10 3 -81 17 -158 32 -118 22 -172 27 -350 29 -115 2 -226 1 -245 -1z"/>
                </g>
              </svg>
            </span>
            <span className="fleet-icon-wrapper" title="Climate Control">
              <svg viewBox="15 25 170 160" width="16" height="16" fill="none">
                <g transform="translate(0.000000,200.000000) scale(0.100000,-0.100000)" fill="currentColor" stroke="none">
                  <path d="M1222 1673 c-46 -25 -86 -52 -89 -60 -6 -15 9 -114 28 -185 10 -40 25 -46 78 -31 22 5 23 9 17 54 -4 27 -4 49 0 49 20 0 110 -68 156 -119 63 -68 110 -153 132 -237 20 -78 20 -213 1 -289 -46 -176 -189 -328 -368 -390 -62 -21 -62 -22 -61 -59 2 -58 14 -63 91 -38 189 61 350 217 419 405 104 289 -7 619 -266 786 l-61 40 30 16 c17 8 31 22 31 31 0 24 -29 74 -43 74 -6 -1 -49 -21 -95 -47z"/>
                  <path d="M773 1626 c-136 -51 -271 -161 -342 -279 -185 -311 -93 -711 207 -905 l63 -41 -30 -16 c-17 -8 -31 -22 -31 -31 0 -21 29 -74 40 -74 20 0 182 93 187 108 6 14 -9 113 -28 185 -10 39 -25 45 -78 30 -22 -5 -23 -9 -17 -54 4 -27 4 -49 0 -49 -20 0 -110 68 -156 119 -63 68 -110 153 -132 237 -20 78 -20 213 -1 289 46 175 187 325 368 390 67 24 76 39 58 88 -13 33 -27 33 -108 3z"/>
                  <path d="M957 1424 c-4 -4 -7 -48 -7 -98 l0 -91 -38 -16 -37 -16 -67 65 c-63 61 -69 65 -93 54 -14 -6 -31 -23 -37 -37 -11 -24 -7 -30 54 -93 l65 -67 -16 -37 -16 -37 -95 -3 -95 -3 0 -45 0 -45 95 -3 95 -3 16 -37 16 -37 -65 -67 c-61 -63 -65 -69 -54 -93 6 -14 23 -31 37 -37 24 -11 30 -7 93 54 l67 65 37 -16 37 -16 3 -95 3 -95 45 0 45 0 3 95 3 95 37 16 37 16 67 -65 c63 -61 69 -65 93 -54 14 6 31 23 37 37 11 24 7 30 -54 93 l-65 67 16 37 16 37 95 3 95 3 0 45 0 45 -95 3 -95 3 -16 37 -16 37 65 67 c61 63 65 69 54 93 -6 14 -23 31 -37 37 -24 11 -30 7 -93 -54 l-67 -65 -37 16 -37 16 -3 95 -3 95 -40 3 c-23 2 -44 0 -48 -4z m100 -303 c96 -44 102 -190 11 -237 -76 -39 -160 -9 -192 69 -20 47 -20 47 0 95 15 38 28 51 64 70 53 27 63 27 117 3z"/>
                </g>
              </svg>
            </span>
          </div>

          <div className="trip-footer-actions">
            <div className="trip-seats-badge">
              <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" strokeWidth="2.2" strokeLinecap="round" strokeLinejoin="round" className="seats-svg">
                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" />
                <circle cx="9" cy="7" r="4" />
                <path d="M23 21v-2a4 4 0 0 0-3-3.87" />
                <path d="M16 3.13a4 4 0 0 1 0 7.75" />
              </svg>
              <span>Seats: <strong className="seats-number">{trip.availableSeats.length}</strong></span>
            </div>

            <div className="trip-action-section-mobile">
              <div className="trip-price-col mobile-price">
                <span className="trip-price-val">{formatPrice(trip.price)}</span>
                <span className="trip-price-sub">per seat</span>
              </div>

              <div className="trip-action-wrapper">
                {isSoldOut ? (
                  <span className="sold-out-badge">Sold out</span>
                ) : isInsufficient ? (
                  <span className="insufficient-seats-badge">Not enough seats</span>
                ) : (
                  <Button
                    variant="primary"
                    className="trip-select-button"
                  >
                    Continue ➔
                  </Button>
                )}
              </div>
            </div>
          </div>
        </div>
      </Card>
    );
  };

  return (
    <div className="search-page">
      {/* Search Filters Panel */}
      <div className="search-page-panel-wrapper">
        <SearchPanel />
      </div>

      {/* Results */}
      <div className="results-section">
        {/* Row showing Results Count on the Left, Sort Tabs on the Right */}
        <div className="search-results-header-row">
          <div className="results-count-container">
            {!loading && fromCity && toCity && date && (
              <h2 className="results-count-text">
                Found {trips.length} trip{trips.length !== 1 ? 's' : ''}
              </h2>
            )}
          </div>

          {!loading && trips.length > 0 && (
            <div className="sort-dropdown-container" ref={sortDropdownRef}>
              <span className="sort-label">Sort by:</span>
              <button
                type="button"
                className="sort-dropdown-trigger"
                onClick={() => setIsSortOpen(prev => !prev)}
              >
                <span>{sortBy === 'earliest' ? 'Earliest' : sortBy === 'cheapest' ? 'Cheapest' : 'Fastest'}</span>
                <svg
                  viewBox="0 0 24 24"
                  width="14"
                  height="14"
                  stroke="currentColor"
                  strokeWidth="2.5"
                  fill="none"
                  className={`chevron-icon ${isSortOpen ? 'open' : ''}`}
                >
                  <polyline points="6 9 12 15 18 9" />
                </svg>
              </button>

              {isSortOpen && (
                <div className="sort-dropdown-menu">
                  <button
                    type="button"
                    className={`sort-dropdown-option ${sortBy === 'earliest' ? 'active' : ''}`}
                    onClick={() => {
                      setSortBy('earliest');
                      setIsSortOpen(false);
                    }}
                  >
                    Earliest
                  </button>
                  <button
                    type="button"
                    className={`sort-dropdown-option ${sortBy === 'cheapest' ? 'active' : ''}`}
                    onClick={() => {
                      setSortBy('cheapest');
                      setIsSortOpen(false);
                    }}
                  >
                    Cheapest
                  </button>
                  <button
                    type="button"
                    className={`sort-dropdown-option ${sortBy === 'fastest' ? 'active' : ''}`}
                    onClick={() => {
                      setSortBy('fastest');
                      setIsSortOpen(false);
                    }}
                  >
                    Fastest
                  </button>
                </div>
              )}
            </div>
          )}
        </div>

        {loading && (
          <div className="loading-state">
            <div className="loading-spinner" />
            <p>Searching for trips...</p>
          </div>
        )}

        {error && !loading && (
          <div className="error-state">
            <p>{error}</p>
          </div>
        )}

        {!loading && trips.length > 0 && (() => {
          const sortedTrips = getSortedTrips(trips);
          const groupedTrips = groupTripsByDate(sortedTrips);

          return (
            <div className="trips-list-grouped">
              {Object.keys(groupedTrips).sort().map((dateKey) => {
                const dateTrips = groupedTrips[dateKey];
                return (
                  <div key={dateKey} className="date-group">
                    <div className="date-group-header">
                      <div className="date-group-header-content">
                        <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" strokeWidth="2.5" fill="none" strokeLinecap="round" strokeLinejoin="round" className="date-icon">
                          <rect x="3" y="4" width="18" height="18" rx="2" ry="2" />
                          <line x1="16" y1="2" x2="16" y2="6" />
                          <line x1="8" y1="2" x2="8" y2="6" />
                          <line x1="3" y1="10" x2="21" y2="10" />
                        </svg>
                        <span>{formatDateHeader(dateKey)}</span>
                      </div>
                    </div>
                    <div className="date-group-trips">
                      {dateTrips.map(trip => renderTripCard(trip))}
                    </div>
                  </div>
                );
              })}
            </div>
          );
        })()}
      </div>

      {isAuthModalOpen && (
        <div className="logout-modal-overlay" onClick={() => setIsAuthModalOpen(false)}>
          <div className="logout-modal-card" onClick={(e) => e.stopPropagation()}>
            <div className="modal-icon">
              <svg viewBox="0 0 24 24" width="28" height="28" stroke="var(--primary)" strokeWidth="2" fill="none">
                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" />
              </svg>
            </div>
            <h2>Login Required</h2>
            <p>In the current version of the application, booking is only available to registered users.</p>
            <div className="modal-buttons">
              <Button variant="ghost" onClick={() => setIsAuthModalOpen(false)}>
                Cancel
              </Button>
              <Button
                variant="primary"
                onClick={() => {
                  setIsAuthModalOpen(false);
                  navigate(`/login?redirectTo=${encodeURIComponent(`/search${location.search}`)}`);
                }}
              >
                Login
              </Button>
            </div>
          </div>
        </div>
      )}
      {showSoldOutModal && (
        <div className="logout-modal-overlay" onClick={() => setShowSoldOutModal(false)}>
          <div className="logout-modal-card" onClick={(e) => e.stopPropagation()}>
            <div className="modal-icon">
              <svg viewBox="0 0 24 24" width="28" height="28" stroke="var(--primary)" strokeWidth="2" fill="none">
                <circle cx="12" cy="12" r="10" />
                <line x1="12" y1="8" x2="12" y2="12" />
                <line x1="12" y1="16" x2="12.01" y2="16" />
              </svg>
            </div>
            <h2>Seats Taken</h2>
            <p>We are sorry, but the remaining seats on this trip have just been booked by another user. This trip is now sold out.</p>
            <div className="modal-buttons">
              <Button variant="primary" onClick={() => setShowSoldOutModal(false)}>
                Confirm
              </Button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
};

export default SearchPage;
