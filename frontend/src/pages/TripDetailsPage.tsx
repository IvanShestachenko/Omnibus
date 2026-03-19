import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { Card, Button } from '../components/common';
import { tripsApi, type TripResponse } from '../api/trips';
import { routesApi, type RouteResponse } from '../api/routes';
import { useAuth } from '../context/AuthContext';
import './TripDetailsPage.css';

export const TripDetailsPage: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { isAuthenticated } = useAuth();

  const [trip, setTrip] = useState<TripResponse | null>(null);
  const [route, setRoute] = useState<RouteResponse | null>(null);
  const [availableSeats, setAvailableSeats] = useState<number>(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  // Booking state
  const [passengers, setPassengers] = useState([
    { firstName: '', lastName: '', seatNumber: '' }
  ]);

  useEffect(() => {
    const fetchTripDetails = async () => {
      if (!id) return;

      setLoading(true);
      try {
        const tripData = await tripsApi.getById(Number(id));
        setTrip(tripData);

        const seats = await tripsApi.getAvailableSeats(Number(id));
        setAvailableSeats(seats);

        const routeData = await routesApi.getById(tripData.routeId);
        setRoute(routeData);
      } catch {
        setError('Failed to load trip details');
      } finally {
        setLoading(false);
      }
    };

    fetchTripDetails();
  }, [id]);

  const formatDateTime = (datetime: string) => {
    const date = new Date(datetime);
    return {
      date: date.toLocaleDateString('en-US', {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric'
      }),
      time: date.toLocaleTimeString('en-US', {
        hour: '2-digit',
        minute: '2-digit',
        hour12: false
      })
    };
  };

  const formatDuration = (departure: string, arrival: string) => {
    const start = new Date(departure);
    const end = new Date(arrival);
    const diff = (end.getTime() - start.getTime()) / (1000 * 60);
    const hours = Math.floor(diff / 60);
    const mins = Math.round(diff % 60);
    return `${hours}h ${mins}m`;
  };

  const addPassenger = () => {
    if (passengers.length < availableSeats) {
      setPassengers([...passengers, { firstName: '', lastName: '', seatNumber: '' }]);
    }
  };

  const removePassenger = (index: number) => {
    if (passengers.length > 1) {
      setPassengers(passengers.filter((_, i) => i !== index));
    }
  };

  const updatePassenger = (index: number, field: string, value: string) => {
    const updated = [...passengers];
    updated[index] = { ...updated[index], [field]: value };
    setPassengers(updated);
  };

  const handleBooking = () => {
    if (!isAuthenticated) {
      navigate('/login', { state: { from: `/trip/${id}` } });
      return;
    }

    // Navigate to booking confirmation with passenger data
    navigate(`/booking/${id}`, {
      state: { passengers, trip }
    });
  };

  const totalPrice = trip ? trip.price * passengers.length : 0;

  if (loading) {
    return (
      <div className="trip-details-page">
        <div className="loading-state">
          <div className="loading-spinner" />
          <p>Loading trip details...</p>
        </div>
      </div>
    );
  }

  if (error || !trip) {
    return (
      <div className="trip-details-page">
        <div className="error-state">
          <h2>Trip not found</h2>
          <p>{error}</p>
          <Button onClick={() => navigate('/search')}>Back to Search</Button>
        </div>
      </div>
    );
  }

  const departure = formatDateTime(trip.departureDatetime);
  const arrival = formatDateTime(trip.arrivalDatetime);

  return (
    <div className="trip-details-page">
      <div className="trip-details-grid">
        {/* Main Content */}
        <div className="trip-main">
          <Card className="trip-header-card">
            <div className="trip-header">
              <h1>{trip.routeName}</h1>
              <span className={`status-badge status-${trip.status.toLowerCase()}`}>
                {trip.status}
              </span>
            </div>

            <div className="trip-journey">
              <div className="journey-point">
                <div className="point-time">{departure.time}</div>
                <div className="point-date">{departure.date}</div>
                <div className="point-label">Departure</div>
              </div>

              <div className="journey-line">
                <div className="journey-duration">
                  {formatDuration(trip.departureDatetime, trip.arrivalDatetime)}
                </div>
              </div>

              <div className="journey-point">
                <div className="point-time">{arrival.time}</div>
                <div className="point-date">{arrival.date}</div>
                <div className="point-label">Arrival</div>
              </div>
            </div>
          </Card>

          {/* Route Stops */}
          {route && route.stops && route.stops.length > 0 && (
            <Card className="stops-card">
              <h3>Route Stops</h3>
              <div className="stops-list">
                {route.stops.sort((a, b) => a.stopOrder - b.stopOrder).map((stop, index) => (
                  <div key={stop.id} className="stop-item">
                    <div className="stop-marker">
                      {index === 0 ? '🚍' : index === route.stops.length - 1 ? '🏁' : '📍'}
                    </div>
                    <div className="stop-info">
                      <span className="stop-name">{stop.terminalName}</span>
                      <span className="stop-distance">{stop.distanceFromStart} km from start</span>
                    </div>
                  </div>
                ))}
              </div>
            </Card>
          )}

          {/* Trip Info */}
          <Card className="info-card">
            <h3>Trip Information</h3>
            <div className="info-grid">
              <div className="info-item">
                <span className="info-label">Bus</span>
                <span className="info-value">{trip.busRegistrationNumber}</span>
              </div>
              {trip.driverName && (
                <div className="info-item">
                  <span className="info-label">Driver</span>
                  <span className="info-value">{trip.driverName}</span>
                </div>
              )}
              <div className="info-item">
                <span className="info-label">Available Seats</span>
                <span className="info-value seats">{availableSeats}</span>
              </div>
            </div>
          </Card>
        </div>

        {/* Booking Sidebar */}
        <div className="booking-sidebar">
          <Card className="booking-card">
            <h3>Book This Trip</h3>

            <div className="passengers-section">
              <div className="passengers-header">
                <span>Passengers</span>
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={addPassenger}
                  disabled={passengers.length >= availableSeats}
                >
                  + Add
                </Button>
              </div>

              {passengers.map((passenger, index) => (
                <div key={index} className="passenger-form">
                  <div className="passenger-header">
                    <span>Passenger {index + 1}</span>
                    {passengers.length > 1 && (
                      <button
                        className="remove-btn"
                        onClick={() => removePassenger(index)}
                      >
                        ✕
                      </button>
                    )}
                  </div>
                  <input
                    placeholder="First Name"
                    value={passenger.firstName}
                    onChange={(e) => updatePassenger(index, 'firstName', e.target.value)}
                    className="passenger-input"
                    required
                  />
                  <input
                    placeholder="Last Name"
                    value={passenger.lastName}
                    onChange={(e) => updatePassenger(index, 'lastName', e.target.value)}
                    className="passenger-input"
                    required
                  />
                </div>
              ))}
            </div>

            <div className="price-summary">
              <div className="price-row">
                <span>{passengers.length}x Passenger</span>
                <span>${trip.price.toFixed(2)} each</span>
              </div>
              <div className="price-total">
                <span>Total</span>
                <span className="total-amount">${totalPrice.toFixed(2)}</span>
              </div>
            </div>

            <Button
              variant="primary"
              size="lg"
              fullWidth
              onClick={handleBooking}
              disabled={availableSeats === 0 || passengers.some(p => !p.firstName || !p.lastName)}
            >
              {isAuthenticated ? 'Continue to Payment' : 'Login to Book'}
            </Button>

            {availableSeats === 0 && (
              <p className="sold-out-msg">This trip is sold out</p>
            )}
          </Card>
        </div>
      </div>
    </div>
  );
};

export default TripDetailsPage;
