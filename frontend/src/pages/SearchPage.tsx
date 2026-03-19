import React, { useState, useEffect } from 'react';
import { useSearchParams, useNavigate } from 'react-router-dom';
import { Card, Button } from '../components/common';
import { tripsApi, type TripResponse } from '../api/trips';
import { routesApi, type RouteResponse } from '../api/routes';
import './SearchPage.css';

export const SearchPage: React.FC = () => {
  const [searchParams] = useSearchParams();
  const navigate = useNavigate();

  const routeId = searchParams.get('routeId');
  const date = searchParams.get('date');

  const [trips, setTrips] = useState<TripResponse[]>([]);
  const [routes, setRoutes] = useState<RouteResponse[]>([]);
  const [selectedRoute, setSelectedRoute] = useState<string>(routeId || '');
  const [selectedDate, setSelectedDate] = useState<string>(date || '');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  // Load routes for filter dropdown
  useEffect(() => {
    const fetchRoutes = async () => {
      try {
        const data = await routesApi.getAll();
        setRoutes(data);
      } catch {
        console.error('Failed to load routes');
      }
    };
    fetchRoutes();
  }, []);

  // Search trips when params change
  useEffect(() => {
    if (routeId && date) {
      searchTrips(Number(routeId), date);
    }
  }, [routeId, date]);

  const searchTrips = async (routeIdNum: number, dateStr: string) => {
    setLoading(true);
    setError('');
    try {
      const data = await tripsApi.search({ routeId: routeIdNum, date: dateStr });
      setTrips(data);
      if (data.length === 0) {
        setError('No trips found for this route and date. Try a different date.');
      }
    } catch {
      setError('Failed to search trips. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (selectedRoute && selectedDate) {
      navigate(`/search?routeId=${selectedRoute}&date=${selectedDate}`);
    }
  };

  const formatTime = (datetime: string) => {
    return new Date(datetime).toLocaleTimeString('en-US', {
      hour: '2-digit',
      minute: '2-digit',
      hour12: false
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

  return (
    <div className="search-page">
      {/* Search Filters */}
      <Card className="filters-card">
        <form onSubmit={handleSearch} className="filters-form">
          <div className="filters-row">
            <div className="filter-field">
              <label>Route</label>
              <select
                value={selectedRoute}
                onChange={(e) => setSelectedRoute(e.target.value)}
                className="filter-select"
              >
                <option value="">All routes</option>
                {routes.map((route) => (
                  <option key={route.id} value={route.id}>
                    {route.name}
                  </option>
                ))}
              </select>
            </div>

            <div className="filter-field">
              <label>Date</label>
              <input
                type="date"
                value={selectedDate}
                onChange={(e) => setSelectedDate(e.target.value)}
                min={new Date().toISOString().split('T')[0]}
                className="filter-input"
              />
            </div>

            <Button type="submit" variant="primary">
              Update Search
            </Button>
          </div>
        </form>
      </Card>

      {/* Results */}
      <div className="results-section">
        <h2 className="results-title">
          {routeId && date ? (
            <>Found {trips.length} trip{trips.length !== 1 ? 's' : ''}</>
          ) : (
            <>Select a route and date to search</>
          )}
        </h2>

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

        {!loading && trips.length > 0 && (
          <div className="trips-list">
            {trips.map((trip) => (
              <Card key={trip.id} className="trip-card" hoverable>
                <div className="trip-content">
                  <div className="trip-route">
                    <span className="route-name">{trip.routeName}</span>
                    {trip.driverName && (
                      <span className="driver-name">Driver: {trip.driverName}</span>
                    )}
                  </div>

                  <div className="trip-times">
                    <div className="time-block">
                      <span className="time">{formatTime(trip.departureDatetime)}</span>
                      <span className="label">Departure</span>
                    </div>
                    <div className="duration">
                      <div className="duration-line" />
                      <span>{formatDuration(trip.departureDatetime, trip.arrivalDatetime)}</span>
                    </div>
                    <div className="time-block">
                      <span className="time">{formatTime(trip.arrivalDatetime)}</span>
                      <span className="label">Arrival</span>
                    </div>
                  </div>

                  <div className="trip-price">
                    <span className="price">${trip.price.toFixed(2)}</span>
                    <span className="per-person">per person</span>
                  </div>

                  <div className="trip-actions">
                    <Button
                      variant="primary"
                      onClick={() => navigate(`/trip/${trip.id}`)}
                    >
                      Select
                    </Button>
                  </div>
                </div>
              </Card>
            ))}
          </div>
        )}
      </div>
    </div>
  );
};

export default SearchPage;
