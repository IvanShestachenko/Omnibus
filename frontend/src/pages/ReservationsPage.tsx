import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { Card, Button } from '../components/common';
import { reservationsApi, type ReservationResponse } from '../api/reservations';
import './ReservationsPage.css';

export const ReservationsPage: React.FC = () => {
  const navigate = useNavigate();
  const [reservations, setReservations] = useState<ReservationResponse[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');
  const [cancellingId, setCancellingId] = useState<number | null>(null);

  useEffect(() => {
    fetchReservations();
  }, []);

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

  const handleCancel = async (id: number) => {
    if (!confirm('Are you sure you want to cancel this reservation?')) return;

    setCancellingId(id);
    try {
      await reservationsApi.cancel(id);
      setReservations(reservations.filter(r => r.id !== id));
    } catch {
      alert('Failed to cancel reservation');
    } finally {
      setCancellingId(null);
    }
  };

  const handlePay = async (id: number) => {
    try {
      await reservationsApi.pay(id);
      fetchReservations(); // Refresh to show updated status
    } catch {
      alert('Payment failed. Please try again.');
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

  const getStatusClass = (status: string) => {
    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'paid':
        return 'status-success';
      case 'pending':
        return 'status-warning';
      case 'cancelled':
        return 'status-error';
      default:
        return '';
    }
  };

  if (loading) {
    return (
      <div className="reservations-page">
        <div className="loading-state">
          <div className="loading-spinner" />
          <p>Loading your reservations...</p>
        </div>
      </div>
    );
  }

  return (
    <div className="reservations-page">
      <div className="page-header">
        <h1>My Reservations</h1>
        <Button variant="primary" onClick={() => navigate('/search')}>
          Book New Trip
        </Button>
      </div>

      {error && (
        <div className="error-message">{error}</div>
      )}

      {reservations.length === 0 ? (
        <Card className="empty-state">
          <div className="empty-icon">🎫</div>
          <h3>No reservations yet</h3>
          <p>Start exploring amazing destinations and book your first trip!</p>
          <Button variant="primary" onClick={() => navigate('/search')}>
            Find Trips
          </Button>
        </Card>
      ) : (
        <div className="reservations-list">
          {reservations.map((reservation) => (
            <Card key={reservation.id} className="reservation-card">
              <div className="reservation-header">
                <div className="booking-ref">
                  <span className="ref-label">Booking Reference</span>
                  <span className="ref-value">{reservation.bookingReference}</span>
                </div>
                <span className={`status-badge ${getStatusClass(reservation.status)}`}>
                  {reservation.status}
                </span>
              </div>

              <div className="reservation-content">
                <div className="trip-info">
                  <h3>{reservation.trip.routeName}</h3>
                  <div className="trip-datetime">
                    <span className="date">{formatDate(reservation.trip.departure)}</span>
                    <span className="time">{formatTime(reservation.trip.departure)}</span>
                  </div>
                </div>

                <div className="passengers-info">
                  <span className="passengers-label">Passengers</span>
                  <div className="passengers-list">
                    {reservation.passengers.map((p, i) => (
                      <span key={i} className="passenger-name">
                        {p.firstName} {p.lastName}
                      </span>
                    ))}
                  </div>
                </div>

                <div className="price-info">
                  <span className="price-label">Total</span>
                  <span className="price-amount">${reservation.totalAmount.toFixed(2)}</span>
                </div>
              </div>

              <div className="reservation-actions">
                {reservation.status.toLowerCase() === 'pending' && (
                  <>
                    <Button
                      variant="primary"
                      onClick={() => handlePay(reservation.id)}
                    >
                      Pay Now
                    </Button>
                    <Button
                      variant="ghost"
                      onClick={() => handleCancel(reservation.id)}
                      loading={cancellingId === reservation.id}
                    >
                      Cancel
                    </Button>
                  </>
                )}
                {reservation.status.toLowerCase() === 'confirmed' && (
                  <Button
                    variant="outline"
                    onClick={() => handleCancel(reservation.id)}
                    loading={cancellingId === reservation.id}
                  >
                    Cancel Reservation
                  </Button>
                )}
              </div>
            </Card>
          ))}
        </div>
      )}
    </div>
  );
};

export default ReservationsPage;
