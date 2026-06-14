import React, { useState, useEffect } from 'react';
import './OfflineAlert.css';

export const OfflineAlert: React.FC = () => {
  const [isOffline, setIsOffline] = useState<boolean>(!navigator.onLine);
  const [checking, setChecking] = useState<boolean>(false);

  useEffect(() => {
    const handleOnline = () => setIsOffline(false);
    const handleOffline = () => setIsOffline(true);

    window.addEventListener('online', handleOnline);
    window.addEventListener('offline', handleOffline);

    return () => {
      window.removeEventListener('online', handleOnline);
      window.removeEventListener('offline', handleOffline);
    };
  }, []);

  const handleRetry = () => {
    setChecking(true);
    setTimeout(() => {
      if (navigator.onLine) {
        setIsOffline(false);
      } else {
        // Still offline, visual pulse effect can show checking failed
      }
      setChecking(false);
    }, 600);
  };

  if (!isOffline) return null;

  return (
    <div className="offline-overlay">
      <div className="offline-modal">
        <div className="offline-icon-container">
          <svg
            className="offline-icon"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
          >
            <line x1="1" y1="1" x2="23" y2="23"></line>
            <path d="M16.72 11.06A10.94 10.94 0 0 1 19 12.5"></path>
            <path d="M5 12.5a10.94 10.94 0 0 1 5.17-2.39"></path>
            <path d="M10.71 5.05A16 16 0 0 1 22.5 8"></path>
            <path d="M1.5 8a15.82 15.82 0 0 1 7.15-2.73"></path>
            <path d="M8.53 16.11a6 6 0 0 1 6.95 0"></path>
            <line x1="12" y1="20" x2="12.01" y2="20"></line>
          </svg>
        </div>
        <h2 className="offline-title">Connection Lost</h2>
        <p className="offline-message">
          You are currently offline. Please check your internet connection to continue using Omnibus.
        </p>
        <button
          className={`offline-btn ${checking ? 'checking' : ''}`}
          onClick={handleRetry}
          disabled={checking}
        >
          {checking ? 'Checking Connection...' : 'Retry Connection'}
        </button>
      </div>
    </div>
  );
};
