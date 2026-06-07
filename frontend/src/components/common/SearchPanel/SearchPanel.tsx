import React, { useState, useEffect, useRef } from 'react';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { Button, Card } from '../index';
import { routesApi, type RouteResponse } from '../../../api/routes';
import { terminalsApi, type TerminalResponse } from '../../../api/terminals';
import './SearchPanel.css';

// Suggestion Icons
const PinIcon: React.FC = () => (
  <svg
    viewBox="0 0 24 24"
    width="16"
    height="16"
    stroke="currentColor"
    strokeWidth="1.25"
    fill="none"
    strokeLinecap="round"
    strokeLinejoin="round"
    style={{ flexShrink: 0, color: 'var(--secondary)' }}
  >
    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" />
    <circle cx="12" cy="10" r="3" />
  </svg>
);

const BusIcon: React.FC = () => (
  <svg
    viewBox="0 0 24 24"
    width="20"
    height="20"
    stroke="currentColor"
    strokeWidth="1.1"
    fill="none"
    strokeLinecap="round"
    strokeLinejoin="round"
    style={{ flexShrink: 0, color: 'var(--secondary)' }}
  >
    <rect x="4" y="3" width="16" height="15" rx="3" />
    <rect x="6" y="6" width="12" height="5" rx="1" />
    <circle cx="8" cy="15" r="1" />
    <circle cx="16" cy="15" r="1" />
    <path d="M6 18v3" />
    <path d="M18 21v-3" />
  </svg>
);

// Diacritic & Accent Normalization
const normalizeText = (text: string): string => {
  return text
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '');
};

// Word-boundary Prefix Search
const matchesSearch = (text: string, query: string): boolean => {
  const normalizedText = normalizeText(text);
  const normalizedQuery = normalizeText(query);
  if (!normalizedQuery) return true;
  
  const words = normalizedText.split(/[\s,.-]+/);
  return words.some(word => word.startsWith(normalizedQuery));
};

// Clean terminal name by stripping the city name prefix
const getCleanTerminalName = (cityName: string, terminalName: string): string => {
  const cityLower = cityName.toLowerCase();
  const nameLower = terminalName.toLowerCase();
  
  if (nameLower.startsWith(cityLower)) {
    return terminalName.substring(cityName.length).replace(/^[\s,.-]+/, '');
  }
  return terminalName;
};

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

  // Listen for popular route selections from the home page
  useEffect(() => {
    const handlePopularRouteSelect = (e: Event) => {
      const customEvent = e as CustomEvent<{ fromCity: string; toCity: string }>;
      const { fromCity, toCity } = customEvent.detail;

      if (terminals.length > 0) {
        const fromSample = terminals.find(t => t.city.toLowerCase() === fromCity.toLowerCase());
        const toSample = terminals.find(t => t.city.toLowerCase() === toCity.toLowerCase());

        if (fromSample) {
          const fromIndex = terminals.findIndex(t => t.city.toLowerCase() === fromCity.toLowerCase());
          const virtualFrom: TerminalResponse = {
            id: -1000 - fromIndex,
            name: 'All stations',
            city: fromSample.city,
            country: fromSample.country
          };
          setFromTerminal(virtualFrom);
          setFromSearch(`${virtualFrom.city}, ${virtualFrom.country}`);
        }
        if (toSample) {
          const toIndex = terminals.findIndex(t => t.city.toLowerCase() === toCity.toLowerCase());
          const virtualTo: TerminalResponse = {
            id: -1000 - toIndex,
            name: 'All stations',
            city: toSample.city,
            country: toSample.country
          };
          setToTerminal(virtualTo);
          setToSearch(`${virtualTo.city}, ${virtualTo.country}`);
        }
        setIsSwapped(false); // Reset visual swap flip state
      }
    };

    window.addEventListener('popular-route-select', handlePopularRouteSelect);
    return () => {
      window.removeEventListener('popular-route-select', handlePopularRouteSelect);
    };
  }, [terminals]);

  // Caching Terminal retrieval in LocalStorage (24h TTL)
  useEffect(() => {
    const loadTerminals = async () => {
      const cachedStr = localStorage.getItem('cached_terminals');
      const now = new Date().getTime();
      const oneDay = 24 * 60 * 60 * 1000;

      let freshTerminals: TerminalResponse[] = [];

      // 1. Try valid cache first
      if (cachedStr) {
        try {
          const parsed = JSON.parse(cachedStr);
          if (parsed && Array.isArray(parsed.data) && typeof parsed.expiry === 'number') {
            if (now < parsed.expiry) {
              setTerminals(parsed.data);
              freshTerminals = parsed.data;
            }
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
          
          const cacheWrapper = {
            data,
            expiry: now + oneDay
          };
          localStorage.setItem('cached_terminals', JSON.stringify(cacheWrapper));
        } catch (err) {
          console.error('Failed to load terminals from API', err);
          // Fallback to expired cache if API is offline
          if (cachedStr) {
            try {
              const parsed = JSON.parse(cachedStr);
              if (parsed) {
                const fallbackData = Array.isArray(parsed) ? parsed : parsed.data;
                if (Array.isArray(fallbackData) && fallbackData.length > 0) {
                  setTerminals(fallbackData);
                  freshTerminals = fallbackData;
                }
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

    // Show popular destinations when less than 2 characters are entered
    if (cleanSearch.length < 2) {
      const popularCityNames = ['Prague', 'Brno', 'Bratislava', 'Budapest', 'Wrocław'];
      const suggested: TerminalResponse[] = [];

      popularCityNames.forEach(cityName => {
        const cityLower = cityName.toLowerCase();
        if (excludedTerminal && excludedTerminal.city.toLowerCase() === cityLower) {
          return;
        }

        const sampleTerm = terminals.find(t => t.city.toLowerCase() === cityLower);
        const country = sampleTerm ? sampleTerm.country : (
          cityName === 'Prague' || cityName === 'Brno' ? 'Czech Republic' :
          cityName === 'Bratislava' ? 'Slovakia' :
          cityName === 'Budapest' ? 'Hungary' :
          'Poland'
        );

        const termIndex = terminals.findIndex(term => term.city.toLowerCase() === cityLower);
        const id = termIndex !== -1 ? -1000 - termIndex : -2000 - popularCityNames.indexOf(cityName);

        suggested.push({
          id,
          name: 'All stations',
          city: cityName,
          country
        });
      });

      return suggested;
    }

    // Helper to determine if a terminal belongs to the excluded selection (same terminal OR same city)
    const isExcluded = (t: TerminalResponse) => {
      if (!excludedTerminal) return false;
      return t.id === excludedTerminal.id || t.city.toLowerCase() === excludedTerminal.city.toLowerCase();
    };

    // Filter terminals matching prefix word-boundaries
    const matches = terminals.filter(t =>
      !isExcluded(t) && (
        matchesSearch(t.city, cleanSearch) ||
        matchesSearch(t.name, cleanSearch) ||
        matchesSearch(t.country, cleanSearch)
      )
    );

    // Group matches into: City matches vs other matches (only terminal/country matched)
    const matchedCities = Array.from(new Set(matches.map(t => t.city)));
    
    // Split into priority cities (where city name itself matches query) and secondary cities
    const priorityCities = matchedCities.filter(cityName => matchesSearch(cityName, cleanSearch));
    const secondaryCities = matchedCities.filter(cityName => !matchesSearch(cityName, cleanSearch));

    const suggested: TerminalResponse[] = [];
    const addedCities = new Set<string>();

    // 1. Process priority cities first: add city header and ALL of its terminals
    priorityCities.forEach(cityName => {
      const cityLower = cityName.toLowerCase();
      if (addedCities.has(cityLower)) return;
      addedCities.add(cityLower);

      // Find first real terminal to get the country name
      const sampleTerm = terminals.find(t => t.city.toLowerCase() === cityLower);
      if (!sampleTerm) return;

      // Add the city header (virtual terminal)
      suggested.push({
        id: -1000 - terminals.findIndex(term => term.city.toLowerCase() === cityLower),
        name: 'All stations',
        city: cityName,
        country: sampleTerm.country
      });

      // Add ALL terminals of this city in the database (except excluded ones)
      const cityTerminals = terminals.filter(t => t.city.toLowerCase() === cityLower && !isExcluded(t));
      suggested.push(...cityTerminals);
    });

    // 2. Process secondary cities next: add city header and ONLY the terminals that matched
    secondaryCities.forEach(cityName => {
      const cityLower = cityName.toLowerCase();
      if (addedCities.has(cityLower)) return;
      addedCities.add(cityLower);

      // Find first real terminal to get the country name
      const sampleTerm = terminals.find(t => t.city.toLowerCase() === cityLower);
      if (!sampleTerm) return;

      // Add the city header (virtual terminal)
      suggested.push({
        id: -1000 - terminals.findIndex(term => term.city.toLowerCase() === cityLower),
        name: 'All stations',
        city: cityName,
        country: sampleTerm.country
      });

      // Add ONLY the matching terminals of this city
      const cityMatchingTerminals = matches.filter(t => t.city.toLowerCase() === cityLower);
      suggested.push(...cityMatchingTerminals);
    });

    return suggested;
  };

  const handleSelectFrom = (terminal: TerminalResponse) => {
    setFromTerminal(terminal);
    const cleanName = getCleanTerminalName(terminal.city, terminal.name);
    const displayText = terminal.name === 'All stations' 
      ? `${terminal.city}, ${terminal.country}` 
      : `${terminal.city} – ${cleanName}`;
    setFromSearch(displayText);
    setShowFromSuggestions(false);
  };

  const handleSelectTo = (terminal: TerminalResponse) => {
    setToTerminal(terminal);
    const cleanName = getCleanTerminalName(terminal.city, terminal.name);
    const displayText = terminal.name === 'All stations' 
      ? `${terminal.city}, ${terminal.country}` 
      : `${terminal.city} – ${cleanName}`;
    setToSearch(displayText);
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
                  width="20" /* TO ADJUST SVG SIZE: Change width and height here to match the swap button container size (e.g., 20 is even to prevent subpixel layout jerks) */
                  height="20"
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
                  {fromSearch.trim().length < 2 ? 'Popular Destinations' : 'Matching Locations'}
                </div>
                {getFilteredSuggestions(fromSearch, toTerminal).length > 0 ? (
                  getFilteredSuggestions(fromSearch, toTerminal).map((term) => {
                    const cleanName = getCleanTerminalName(term.city, term.name);
                    return (
                      <div
                        key={term.id}
                        className="suggestion-item"
                        style={term.name !== 'All stations' ? { paddingLeft: '44px' } : undefined}
                        onClick={() => handleSelectFrom(term)}
                      >
                        <div className="suggestion-icon-wrapper">
                          {term.name === 'All stations' ? <PinIcon /> : <BusIcon />}
                        </div>
                        <div className="suggestion-details">
                          {term.name === 'All stations' ? (
                            <span className="suggestion-city">
                              {term.city}<span className="suggestion-separator">, {term.country}</span>
                            </span>
                          ) : (
                            <span className="suggestion-city">
                              {term.city}
                              <span className="suggestion-separator"> – </span>
                              <span className="suggestion-terminal">{cleanName}</span>
                            </span>
                          )}
                        </div>
                      </div>
                    );
                  })
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
                  {toSearch.trim().length < 2 ? 'Popular Destinations' : 'Matching Locations'}
                </div>
                {getFilteredSuggestions(toSearch, fromTerminal).length > 0 ? (
                  getFilteredSuggestions(toSearch, fromTerminal).map((term) => {
                    const cleanName = getCleanTerminalName(term.city, term.name);
                    return (
                      <div
                        key={term.id}
                        className="suggestion-item"
                        style={term.name !== 'All stations' ? { paddingLeft: '44px' } : undefined}
                        onClick={() => handleSelectTo(term)}
                      >
                        <div className="suggestion-icon-wrapper">
                          {term.name === 'All stations' ? <PinIcon /> : <BusIcon />}
                        </div>
                        <div className="suggestion-details">
                          {term.name === 'All stations' ? (
                            <span className="suggestion-city">
                              {term.city}<span className="suggestion-separator">, {term.country}</span>
                            </span>
                          ) : (
                            <span className="suggestion-city">
                              {term.city}
                              <span className="suggestion-separator"> – </span>
                              <span className="suggestion-terminal">{cleanName}</span>
                            </span>
                          )}
                        </div>
                      </div>
                    );
                  })
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
              onClick={(e) => {
                try {
                  const target = e.currentTarget as HTMLInputElement & { showPicker?: () => void };
                  if (typeof target.showPicker === 'function') {
                    target.showPicker();
                  }
                } catch {
                  // Empty catch to avoid unused variable warnings
                }
              }}
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
                aria-label="Decrease passenger count"
              >
                <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" strokeWidth="3" strokeLinecap="round">
                  <line x1="5" y1="12" x2="19" y2="12" />
                </svg>
              </button>
              <span className="passenger-count-display">{passengers}</span>
              <button
                type="button"
                onClick={() => setPassengers(p => Math.min(9, p + 1))}
                disabled={passengers >= 9}
                className="passenger-btn"
                aria-label="Increase passenger count"
              >
                <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" strokeWidth="3" strokeLinecap="round">
                  <line x1="5" y1="12" x2="19" y2="12" />
                  <line x1="12" y1="5" x2="12" y2="19" />
                </svg>
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
