import React, { useState, useEffect, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { Button, Card } from '../components/common';
import { routesApi, type RouteResponse } from '../api/routes';
import { terminalsApi, type TerminalResponse } from '../api/terminals';
import heroBannerImg from '../assets/hero_banner_4.png';
import './HomePage.css';

export const HomePage: React.FC = () => {
  const navigate = useNavigate();
  const [routes, setRoutes] = useState<RouteResponse[]>([]);
  const [terminals, setTerminals] = useState<TerminalResponse[]>([]);

  // Search state
  const [fromSearch, setFromSearch] = useState('');
  const [toSearch, setToSearch] = useState('');
  const [fromTerminal, setFromTerminal] = useState<TerminalResponse | null>(null);
  const [toTerminal, setToTerminal] = useState<TerminalResponse | null>(null);
  const [date, setDate] = useState(() => new Date().toISOString().split('T')[0] || '');
  const [passengers, setPassengers] = useState(1);

  // Suggestion visibility state
  const [showFromSuggestions, setShowFromSuggestions] = useState(false);
  const [showToSuggestions, setShowToSuggestions] = useState(false);

  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  const fromContainerRef = useRef<HTMLDivElement>(null);
  const toContainerRef = useRef<HTMLDivElement>(null);

  // Load routes on mount to link terminal cities with routeIds
  useEffect(() => {
    const fetchRoutes = async () => {
      try {
        const data = await routesApi.getAll();
        setRoutes(data);
      } catch (err) {
        console.error('Failed to load routes', err);
      }
    };
    fetchRoutes();
  }, []);

  // Caching Terminal retrieval in LocalStorage (24h TTL)
  useEffect(() => {
    const loadTerminals = async () => {
      const cached = localStorage.getItem('cached_terminals');
      const cacheTime = localStorage.getItem('cached_terminals_time');
      const now = new Date().getTime();
      const oneDay = 24 * 60 * 60 * 1000;

      // 1. Try to use valid cached data within TTL first
      if (cached && cacheTime && (now - parseInt(cacheTime)) < oneDay) {
        try {
          const parsed = JSON.parse(cached);
          if (Array.isArray(parsed) && parsed.length > 0) {
            setTerminals(parsed);
            return;
          }
        } catch (e) {
          console.warn('Failed to parse cached terminals', e);
        }
      }

      // 2. Fetch fresh data from API
      try {
        const data = await terminalsApi.getAll();
        setTerminals(data);
        localStorage.setItem('cached_terminals', JSON.stringify(data));
        localStorage.setItem('cached_terminals_time', now.toString());
      } catch (err) {
        console.error('Failed to load terminals from API, checking fallback in localStorage', err);
        // 3. Fallback to expired cache if API is offline
        if (cached) {
          try {
            const parsed = JSON.parse(cached);
            if (Array.isArray(parsed) && parsed.length > 0) {
              setTerminals(parsed);
              return;
            }
          } catch (e) {
            console.error('Failed to parse fallback cached terminals', e);
          }
        }
        setError('Failed to load locations');
      }
    };
    loadTerminals();
  }, []);

  // Click outside to close autocompletes
  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (fromContainerRef.current && !fromContainerRef.current.contains(event.target as Node)) {
        setShowFromSuggestions(false);
      }
      if (toContainerRef.current && !toContainerRef.current.contains(event.target as Node)) {
        setShowToSuggestions(false);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  // Filter suggestions from cached list
  const getFilteredSuggestions = (search: string, excludedTerminal: TerminalResponse | null) => {
    const cleanSearch = search.trim().toLowerCase();

    // If search is empty, suggest first 5 terminals as "Popular Destinations"
    if (cleanSearch === '') {
      return terminals
        .filter(t => t.id !== excludedTerminal?.id)
        .slice(0, 5);
    }

    return terminals.filter(t =>
      t.id !== excludedTerminal?.id && (
        t.name.toLowerCase().includes(cleanSearch) ||
        t.city.toLowerCase().includes(cleanSearch) ||
        t.country.toLowerCase().includes(cleanSearch)
      )
    );
  };

  const handleSelectFrom = (terminal: TerminalResponse) => {
    setFromTerminal(terminal);
    setFromSearch(`${terminal.city}, ${terminal.name}`);
    setShowFromSuggestions(false);
    setError('');
  };

  const handleSelectTo = (terminal: TerminalResponse) => {
    setToTerminal(terminal);
    setToSearch(`${terminal.city}, ${terminal.name}`);
    setShowToSuggestions(false);
    setError('');
  };

  const handleSwap = () => {
    const tempSearch = fromSearch;
    const tempTerminal = fromTerminal;

    setFromSearch(toSearch);
    setFromTerminal(toTerminal);

    setToSearch(tempSearch);
    setToTerminal(tempTerminal);
    setError('');
  };

  // Connect From and To city terminals to their matching routeId
  const findMatchingRouteId = (fromCity: string, toCity: string): number | null => {
    for (const route of routes) {
      if (route.stops.length < 2) continue;

      const sortedStops = [...route.stops].sort((a, b) => a.sequenceOrder - b.sequenceOrder);
      const originStop = sortedStops[0];
      const destStop = sortedStops[sortedStops.length - 1];

      if (
        originStop.city.toLowerCase() === fromCity.toLowerCase() &&
        destStop.city.toLowerCase() === toCity.toLowerCase()
      ) {
        return route.id;
      }
    }
    return null;
  };

  const handleSearchSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!fromTerminal) {
      setError('Please select an origin terminal from the suggestions.');
      return;
    }
    if (!toTerminal) {
      setError('Please select a destination terminal from the suggestions.');
      return;
    }
    if (!date) return;

    const matchingRouteId = findMatchingRouteId(fromTerminal.city, toTerminal.city);

    if (!matchingRouteId) {
      setError(`No direct routes found connecting ${fromTerminal.city} to ${toTerminal.city}.`);
      return;
    }

    setLoading(true);
    navigate(`/search?routeId=${matchingRouteId}&date=${date}&passengers=${passengers}`);
  };

  // Quick search popular route triggers
  const handleQuickSearch = (fromCity: string, toCity: string) => {
    const fromTerm = terminals.find(t => t.city.toLowerCase() === fromCity.toLowerCase());
    const toTerm = terminals.find(t => t.city.toLowerCase() === toCity.toLowerCase());

    if (fromTerm && toTerm) {
      setFromTerminal(fromTerm);
      setFromSearch(`${fromTerm.city}, ${fromTerm.name}`);
      setToTerminal(toTerm);
      setToSearch(`${toTerm.city}, ${toTerm.name}`);
      setError('');

      // Auto-scroll to search form smoothly
      window.scrollTo({ top: 320, behavior: 'smooth' });
    }
  };

  return (
    <div className="home-page">
      {/* Hero Section */}
      <section className="hero-section">
        <div className="hero-background-gradient" />

        <div className="hero-content">
          <div className="hero-banner-container">
            <img src={heroBannerImg} alt="Omnibus Widescreen Journey" className="hero-banner-image" />
            <div className="hero-text-overlay">
              <h1 className="hero-title">Travel by bus all across Europe</h1>
            </div>
          </div>

          {/* Floating Search Card */}
          <Card className="search-card">
            <form onSubmit={handleSearchSubmit} className="search-form">
              <div className="search-fields-grid">

                {/* Field 1: From Autocomplete */}
                <div className="search-field autocomplete-field" ref={fromContainerRef}>
                  <label>From</label>
                  <input
                    type="text"
                    placeholder="Departure city"
                    value={fromSearch}
                    onChange={(e) => {
                      setFromSearch(e.target.value);
                      if (fromTerminal) setFromTerminal(null);
                    }}
                    onFocus={() => setShowFromSuggestions(true)}
                    required
                    className="search-input"
                  />
                  {showFromSuggestions && (
                    <div className="autocomplete-suggestions">
                      <div className="suggestions-header">
                        {fromSearch.trim() === '' ? '📍 Popular Stations' : '📍 Matching Locations'}
                      </div>
                      {getFilteredSuggestions(fromSearch, toTerminal).length > 0 ? (
                        getFilteredSuggestions(fromSearch, toTerminal).map((term) => (
                          <div
                            key={term.id}
                            className="suggestion-item"
                            onClick={() => handleSelectFrom(term)}
                          >
                            <span className="suggestion-city">{term.city}</span>
                            <span className="suggestion-name">{term.name}, {term.country}</span>
                          </div>
                        ))
                      ) : (
                        <div className="suggestions-empty">No locations found</div>
                      )}
                    </div>
                  )}
                </div>

                {/* Swap Button */}
                <div className="swap-button-container">
                  <button
                    type="button"
                    onClick={handleSwap}
                    className="swap-button"
                    title="Swap locations"
                  >
                    ⇄
                  </button>
                </div>

                {/* Field 2: To Autocomplete */}
                <div className="search-field autocomplete-field" ref={toContainerRef}>
                  <label>To</label>
                  <input
                    type="text"
                    placeholder="Arrival city"
                    value={toSearch}
                    onChange={(e) => {
                      setToSearch(e.target.value);
                      if (toTerminal) setToTerminal(null);
                    }}
                    onFocus={() => setShowToSuggestions(true)}
                    required
                    className="search-input"
                  />
                  {showToSuggestions && (
                    <div className="autocomplete-suggestions">
                      <div className="suggestions-header">
                        {toSearch.trim() === '' ? '📍 Popular Stations' : '📍 Matching Locations'}
                      </div>
                      {getFilteredSuggestions(toSearch, fromTerminal).length > 0 ? (
                        getFilteredSuggestions(toSearch, fromTerminal).map((term) => (
                          <div
                            key={term.id}
                            className="suggestion-item"
                            onClick={() => handleSelectTo(term)}
                          >
                            <span className="suggestion-city">{term.city}</span>
                            <span className="suggestion-name">{term.name}, {term.country}</span>
                          </div>
                        ))
                      ) : (
                        <div className="suggestions-empty">No locations found</div>
                      )}
                    </div>
                  )}
                </div>

                {/* Field 3: Date Selector */}
                <div className="search-field date-field">
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

                {/* Field 4: Passenger Counter (Inline UX) */}
                <div className="search-field passenger-field">
                  <label>Passengers</label>
                  <div className="passenger-counter">
                    <button
                      type="button"
                      onClick={() => setPassengers(p => Math.max(1, p - 1))}
                      disabled={passengers <= 1}
                      className="passenger-btn"
                    >
                      −
                    </button>
                    <span className="passenger-count-display">{passengers}</span>
                    <button
                      type="button"
                      onClick={() => setPassengers(p => Math.min(9, p + 1))}
                      disabled={passengers >= 9}
                      className="passenger-btn"
                    >
                      +
                    </button>
                  </div>
                </div>

                {/* Submit Action Button */}
                <div className="search-action-container">
                  <Button
                    type="submit"
                    variant="primary"
                    loading={loading}
                    className="search-button-coral"
                  >
                    Search Tickets
                  </Button>
                </div>

              </div>

              {error && <p className="search-error">{error}</p>}
            </form>
          </Card>
        </div>
      </section>

      {/* Popular Routes Section */}
      <section className="popular-routes-section">
        <div className="section-container">
          <h2 className="section-title">Popular Routes</h2>
          <p className="section-subtitle">Quick access to the most popular destinations in Europe</p>

          <div className="routes-grid">
            <div className="route-shortcut-card" onClick={() => handleQuickSearch('Prague', 'Brno')}>
              <div className="route-shortcut-overlay" />
              <div className="route-shortcut-content">
                <h3>Prague ➔ Brno</h3>
                <span className="route-shortcut-price">from $19.99</span>
              </div>
            </div>

            <div className="route-shortcut-card" onClick={() => handleQuickSearch('Prague', 'Vienna')}>
              <div className="route-shortcut-overlay" />
              <div className="route-shortcut-content">
                <h3>Prague ➔ Vienna</h3>
                <span className="route-shortcut-price">from $29.99</span>
              </div>
            </div>

            <div className="route-shortcut-card" onClick={() => handleQuickSearch('Prague', 'Budapest')}>
              <div className="route-shortcut-overlay" />
              <div className="route-shortcut-content">
                <h3>Prague ➔ Budapest</h3>
                <span className="route-shortcut-price">from $34.99</span>
              </div>
            </div>

            <div className="route-shortcut-card" onClick={() => handleQuickSearch('Brno', 'Bratislava')}>
              <div className="route-shortcut-overlay" />
              <div className="route-shortcut-content">
                <h3>Brno ➔ Bratislava</h3>
                <span className="route-shortcut-price">from $14.99</span>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="features-section">
        <div className="features-container">
          <h2 className="section-title">Why Choose <span className="text-brand-navy">Omnibus</span></h2>

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
          <Button variant="primary" size="lg" onClick={() => navigate('/register')} className="cta-button-coral">
            Get Started — It's Free
          </Button>
        </div>
      </section>
    </div>
  );
};

export default HomePage;
