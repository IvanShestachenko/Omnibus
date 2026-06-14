import React, { useState, useEffect, useCallback } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import reservationsApi from '../api/reservations';
import './PaymentPage.css';

export const PaymentPage: React.FC = () => {
  const { reservationId } = useParams<{ reservationId: string }>();
  const navigate = useNavigate();
  const [countdown, setCountdown] = useState(15);
  const [processing, setProcessing] = useState(false);
  const [checkingStatus, setCheckingStatus] = useState(true);
  const [tripId, setTripId] = useState<number | null>(null);
  const [error, setError] = useState('');

  const handleCompletePayment = useCallback(async () => {
    if (processing) return;
    setProcessing(true);
    setError('');
    try {
      if (reservationId) {
        await reservationsApi.pay(Number(reservationId));
      }
      if (tripId) {
        sessionStorage.removeItem(`booking_form_${tripId}`);
      }
      // Delay navigation slightly so the user can see the green checkmark animation
      setTimeout(() => {
        navigate('/reservations', { replace: true });
      }, 1600);
    } catch {
      setError('An error occurred while confirming payment. Please check your reservations.');
      setProcessing(false);
    }
  }, [processing, reservationId, tripId, navigate]);

  // Check reservation status on mount
  useEffect(() => {
    const checkReservationStatus = async () => {
      if (!reservationId) return;
      try {
        const res = await reservationsApi.getById(Number(reservationId));
        setTripId(res.trip.id);
        const status = res.status.toLowerCase();
        if (status === 'confirmed' || status === 'paid') {
          // Already paid, clear sessionStorage and redirect immediately
          sessionStorage.removeItem(`booking_form_${res.trip.id}`);
          navigate('/reservations', { replace: true });
          return;
        }
        setCheckingStatus(false);
      } catch {
        setError('Failed to verify reservation status. Please check your reservations.');
        setCheckingStatus(false);
      }
    };

    checkReservationStatus();
  }, [reservationId, navigate]);

  useEffect(() => {
    if (checkingStatus) return;

    if (countdown <= 0) {
      setTimeout(() => {
        handleCompletePayment();
      }, 0);
      return;
    }

    const timer = setTimeout(() => {
      setCountdown((prev) => prev - 1);
    }, 1000);

    return () => clearTimeout(timer);
  }, [countdown, checkingStatus, handleCompletePayment]);

  if (checkingStatus) {
    return (
      <div className="payment-page">
        <div className="payment-container">
          <div className="payment-content-wrapper">
            <h1 className="payment-title">Checking Status</h1>
            <p className="payment-info-text">Please wait while we check your reservation status...</p>
          </div>
        </div>
      </div>
    );
  }

  const radius = 54;
  const circumference = 2 * Math.PI * radius;
  // Keep the progress ring full (offset = 0) when countdown reaches 0 to frame the checkmark beautifully
  const strokeDashoffset = countdown > 0
    ? circumference - (countdown / 15) * circumference
    : 0;

  return (
    <div className="payment-page">
      <div className="payment-container">
        <div className="payment-content-wrapper">
          <div className="payment-timer-wrapper">
            <div className="payment-timer-container">
              <svg className="timer-svg" viewBox="0 0 128 128">
                <circle
                  className="timer-track"
                  cx="64"
                  cy="64"
                  r={radius}
                />
                <circle
                  className="timer-progress"
                  cx="64"
                  cy="64"
                  r={radius}
                  strokeDasharray={circumference}
                  strokeDashoffset={strokeDashoffset}
                />
              </svg>
              <div className="timer-content">
                {countdown > 0 ? (
                  <span className="timer-number">{countdown}</span>
                ) : (
                  <svg className="checkmark-svg" viewBox="0 0 52 52">
                    <circle className="checkmark-circle" cx="26" cy="26" r="25" fill="none" />
                    <path className="checkmark-check" fill="none" d="M14.1 27.2l7.1 7.2 16.7-16.8" />
                  </svg>
                )}
              </div>
            </div>

            {countdown > 0 && (
              <button
                type="button"
                className="payment-skip-btn"
                onClick={() => setCountdown(0)}
                title="Skip countdown"
              >
                Skip countdown
              </button>
            )}
          </div>

          <h1 className="payment-title">Booking Confirmation</h1>

          <p className="payment-info-text">
            In this demonstration version of the application, no payment gateway is connected.
            Therefore, all payments are considered successful.{' '}
            {processing ? 'Confirming reservation...' : 'Redirecting to My Reservations page.'}
          </p>

          {error && <div className="payment-error">{error}</div>}
        </div>
      </div>
    </div>
  );
};

export default PaymentPage;







