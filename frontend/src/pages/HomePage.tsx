import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { Button, Card } from '../components/common';
import { routesApi, type RouteResponse } from '../api/routes';
import './HomePage.css';

export const HomePage: React.FC = () => {
  const navigate = useNavigate();
  const [routes, setRoutes] = useState<RouteResponse[]>([]);
  const [selectedRoute, setSelectedRoute] = useState<string>('');
  const [date, setDate] = useState<string>('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    const fetchRoutes = async () => {
      try {
        const data = await routesApi.getAll();
        setRoutes(data);
      } catch  {
        setError('Failed to load routes');
      }
    };
    fetchRoutes();
  }, []);

  // Set default date to today
  useEffect(() => {
    const today = new Date().toISOString().split('T')[0];
    setDate(today);
  }, []);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedRoute || !date) return;

    setLoading(true);
    navigate(`/search?routeId=${selectedRoute}&date=${date}`);
  };

  return (
    <div className="home-page">
      {/* Hero Section */}
      <section className="hero-section">
        <div className="hero-background">
          <div className="hero-overlay" />
          <div className="hero-particles">
            {[...Array(20)].map((_, i) => (
              <div key={i} className="particle" style={{
                left: `${Math.random() * 100}%`,
                animationDelay: `${Math.random() * 5}s`,
                animationDuration: `${10 + Math.random() * 20}s`
              }} />
            ))}
          </div>
        </div>

        <div className="hero-content">
          <h1 className="hero-title">
            Your Adventure <span className="text-gradient">Starts Here</span>
          </h1>
          <p className="hero-subtitle">
            Discover amazing destinations across Europe. Book comfortable bus trips at the best prices.
          </p>

          {/* Search Card */}
          <Card className="search-card">
            <form onSubmit={handleSearch} className="search-form">
              <div className="search-fields">
                <div className="search-field">
                  <label>Route</label>
                  <select
                    value={selectedRoute}
                    onChange={(e) => setSelectedRoute(e.target.value)}
                    required
                    className="search-select"
                  >
                    <option value="">Select a route</option>
                    {routes.map((route) => (
                      <option key={route.id} value={route.id}>
                        {route.name}
                      </option>
                    ))}
                  </select>
                </div>

                <div className="search-field">
                  <label>Date</label>
                  <input
                    type="date"
                    value={date}
                    onChange={(e) => setDate(e.target.value)}
                    min={new Date().toISOString().split('T')[0]}
                    required
                    className="search-input"
                  />
                </div>

                <Button
                  type="submit"
                  variant="primary"
                  size="lg"
                  loading={loading}
                  className="search-button"
                >
                  🔍 Search Trips
                </Button>
              </div>

              {error && <p className="search-error">{error}</p>}
            </form>
          </Card>
        </div>
      </section>

      {/* Features Section */}
      <section className="features-section">
        <div className="features-container">
          <h2 className="section-title">Why Choose <span className="text-gradient">bus2holiday</span></h2>

          <div className="features-grid">
            <div className="feature-card">
              <div className="feature-icon">💰</div>
              <h3>Best Prices</h3>
              <p>Competitive prices with no hidden fees. Save money on every trip.</p>
            </div>

            <div className="feature-card">
              <div className="feature-icon">🛋️</div>
              <h3>Comfort First</h3>
              <p>Modern buses with spacious seats, WiFi, and power outlets.</p>
            </div>

            <div className="feature-card">
              <div className="feature-icon">🕐</div>
              <h3>On Time</h3>
              <p>Reliable schedules with real-time tracking of your bus.</p>
            </div>

            <div className="feature-card">
              <div className="feature-icon">🌍</div>
              <h3>Wide Network</h3>
              <p>Travel to hundreds of destinations across Europe.</p>
            </div>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="cta-section">
        <div className="cta-content">
          <h2>Ready to explore?</h2>
          <p>Join thousands of travelers who trust us for their journeys.</p>
          <Button variant="primary" size="lg" onClick={() => navigate('/register')}>
            Get Started — It's Free
          </Button>
        </div>
      </section>
    </div>
  );
};

export default HomePage;
