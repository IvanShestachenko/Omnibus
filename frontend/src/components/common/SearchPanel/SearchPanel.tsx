import React, { useState, useEffect, useRef } from 'react';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { Button, Card } from '../index';
import { routesApi, type RouteResponse } from '../../../api/routes';
import { terminalsApi, type TerminalResponse } from '../../../api/terminals';
import './SearchPanel.css';

export const SearchPanel: React.FC = () => {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();

  // Load initial params from URL if present (useful for SearchPage pre-filling)
  const urlRouteId = searchParams.get('routeId');
  const urlDate = searchParams.get('date');
  const urlPassengers = searchParams.get('passengers');

  const [routes, setRoutes] = useState<RouteResponse[]>([]);
  const [terminals, setTerminals] = useState<TerminalResponse[]>([]);

  // Search states
  const [fromSearch, setFromSearch] = useState('');
  const [toSearch, setToSearch] = useState('');
  const [fromTerminal, setFromTerminal] = useState<TerminalResponse | null>(null);
  const [toTerminal, setToTerminal] = useState<TerminalResponse | null>(null);
  const [date, setDate] = useState(() => urlDate || new Date().toISOString().split('T')[0] || '');
  const [passengers, setPassengers] = useState(() => Number(urlPassengers) || 1);

  // Suggestions visibility
  const [showFromSuggestions, setShowFromSuggestions] = useState(false);
  const [showToSuggestions, setShowToSuggestions] = useState(false);

  // Color & Rotation swapped state
  const [isSwapped, setIsSwapped] = useState(false);

  const [loading, setLoading] = useState(false);

  const fromContainerRef = useRef<HTMLDivElement>(null);
  const toContainerRef = useRef<HTMLDivElement>(null);

  // Pre-fill locations from URL routeId stops
  const prefillFromUrl = (termList: TerminalResponse[]) => {
    const matchingRoute = routes.find(r => r.id === Number(urlRouteId));
    if (!matchingRoute || matchingRoute.stops.length < 2) return;

    const sortedStops = [...matchingRoute.stops].sort((a, b) => a.sequenceOrder - b.sequenceOrder);
    const originStop = sortedStops[0];
    const destStop = sortedStops[sortedStops.length - 1];

    const fromTerm = termList.find(t => t.city.toLowerCase() === originStop.city.toLowerCase());
    const toTerm = termList.find(t => t.city.toLowerCase() === destStop.city.toLowerCase());

    if (fromTerm) {
      setFromTerminal(fromTerm);
      setFromSearch(`${fromTerm.city}, ${fromTerm.name}`);
    }
    if (toTerm) {
      setToTerminal(toTerm);
      setToSearch(`${toTerm.city}, ${toTerm.name}`);
    }
  };

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

      let freshTerminals: TerminalResponse[] = [];

      // 1. Try valid cache first
      if (cached && cacheTime && (now - parseInt(cacheTime)) < oneDay) {
        try {
          const parsed = JSON.parse(cached);
          if (Array.isArray(parsed) && parsed.length > 0) {
            setTerminals(parsed);
            freshTerminals = parsed;
          }
        } catch (e) {
          console.warn('Failed to parse cached terminals', e);
        }
      }

      // 2. Fetch fresh if no valid cache
      if (freshTerminals.length === 0) {
        try {
          const data = await terminalsApi.getAll();
          setTerminals(data);
          freshTerminals = data;
          localStorage.setItem('cached_terminals', JSON.stringify(data));
          localStorage.setItem('cached_terminals_time', now.toString());
        } catch (err) {
          console.error('Failed to load terminals from API', err);
          // Fallback to expired cache if API is offline
          if (cached) {
            try {
              const parsed = JSON.parse(cached);
              if (Array.isArray(parsed) && parsed.length > 0) {
                setTerminals(parsed);
                freshTerminals = parsed;
              }
            } catch (e) {
              console.error('Failed to parse fallback cached terminals', e);
            }
          }
        }
      }

      // 3. Pre-fill states once terminals and URL params are available
      if (freshTerminals.length > 0 && urlRouteId && routes.length > 0) {
        prefillFromUrl(freshTerminals);
      }
    };

    loadTerminals();
  }, [urlRouteId, routes.length]);

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

    // If search is empty, suggest first 5 terminals
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
  };

  const handleSelectTo = (terminal: TerminalResponse) => {
    setToTerminal(terminal);
    setToSearch(`${terminal.city}, ${terminal.name}`);
    setShowToSuggestions(false);
  };

  const handleSwap = () => {
    const tempSearch = fromSearch;
    const tempTerminal = fromTerminal;

    setFromSearch(toSearch);
    setFromTerminal(toTerminal);

    setToSearch(tempSearch);
    setToTerminal(tempTerminal);

    setIsSwapped(prev => !prev); // Toggle visual swapped state
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
    if (!fromTerminal || !toTerminal || !date) return;

    const matchingRouteId = findMatchingRouteId(fromTerminal.city, toTerminal.city);
    // If no direct route exists, pass -1 to let the search page handle the empty state
    const searchRouteId = matchingRouteId !== null ? matchingRouteId : -1;

    setLoading(true);
    navigate(`/search?routeId=${searchRouteId}&date=${date}&passengers=${passengers}`);
    setLoading(false);
  };

  return (
    <Card className="search-card">
      <form onSubmit={handleSearchSubmit} className="search-form">
        <div className="search-fields-grid">

          {/* Field 1: From Autocomplete with Integrated Inline Swap */}
          <div className="search-field autocomplete-field" ref={fromContainerRef}>
            <label>From</label>
            <div className="input-with-swap-container">
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
              <button
                type="button"
                onClick={handleSwap}
                className={`swap-button-inline ${isSwapped ? 'swapped' : ''}`}
                title="Swap locations"
              >
                <svg
                  viewBox="0 0 24 24"
                  width="18"
                  height="18"
                  stroke="currentColor"
                  strokeWidth="2.2"
                  fill="none"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                >
                  <path d="M4 8h16M16 4l4 4-4 4" />
                  <path d="M20 16H4M8 12l-4 4 4 4" />
                </svg>
              </button>
            </div>
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
      </form>
    </Card>
  );
};
