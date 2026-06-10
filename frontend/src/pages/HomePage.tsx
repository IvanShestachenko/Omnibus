import React, { useState, useEffect } from 'react';
import { SearchPanel } from '../components/common';
import { useCurrency } from '../context/CurrencyContext';
import { useAuth } from '../context/AuthContext';
import { routesApi } from '../api/routes';
import { terminalsApi } from '../api/terminals';
import layer1Img from '../assets/layer_1_cut.webp';
import layer2Img from '../assets/layer_2_cut.webp';
import layer3Img from '../assets/layer_3_cut.webp';
import layer4Img from '../assets/layer_4_cut.webp';
import fleetVideo from '../assets/2020_Setra_S515_HD_Walkaround.mp4';
import { ParallaxBanner } from '../components/common/ParallaxBanner/ParallaxBanner';
import './HomePage.css';

interface TripInfo {
  from: string;
  to: string;
  price: number;
  fromCountry: string;
  toCountry: string;
}

const backupTrips: TripInfo[] = [
  { from: 'Prague', to: 'Brno', price: 9.27, fromCountry: 'Czech Republic', toCountry: 'Czech Republic' },
  { from: 'Berlin', to: 'Munich', price: 23.41, fromCountry: 'Germany', toCountry: 'Germany' },
  { from: 'Paris', to: 'Marseille', price: 29.93, fromCountry: 'France', toCountry: 'France' },
  { from: 'Warsaw', to: 'Kraków', price: 11.30, fromCountry: 'Poland', toCountry: 'Poland' }
];

const getUnloggedInTrips = (trips: TripInfo[]): TripInfo[] => {
  const targetPairs = [
    { from: 'Prague', to: 'Brno' },
    { from: 'Berlin', to: 'Munich' },
    { from: 'Paris', to: 'Marseille' },
    { from: 'Warsaw', to: 'Kraków' }
  ];
  
  // Try to find exact matches for target pairs first
  const selected = targetPairs
    .map(pair => trips.find(t => t.from.toLowerCase() === pair.from.toLowerCase() && t.to.toLowerCase() === pair.to.toLowerCase()))
    .filter((t): t is TripInfo => !!t);
    
  // If we don't have 4, find any trip starting in each country to fill it up
  if (selected.length < 4) {
    const countries = ['Czech Republic', 'Germany', 'France', 'Poland'];
    countries.forEach(country => {
      if (selected.length >= 4) return;
      if (selected.some(s => s.fromCountry.toLowerCase() === country.toLowerCase())) return;
      
      const fallbackTrip = trips.find(t => 
        t.fromCountry.toLowerCase() === country.toLowerCase() && 
        !selected.some(s => s.from.toLowerCase() === t.from.toLowerCase() && s.to.toLowerCase() === t.to.toLowerCase())
      );
      if (fallbackTrip) {
        selected.push(fallbackTrip);
      }
    });
  }
  
  // If we still don't have 4, fill up with any available trips
  let idx = 0;
  while (selected.length < 4 && idx < trips.length) {
    const trip = trips[idx++];
    if (!selected.some(s => s.from.toLowerCase() === trip.from.toLowerCase() && s.to.toLowerCase() === trip.to.toLowerCase())) {
      selected.push(trip);
    }
  }
  
  return selected.slice(0, 4);
};

export const HomePage: React.FC = () => {
  const { user } = useAuth();
  const [isVideoPlaying, setIsVideoPlaying] = useState(false);
  const [videoSrc, setVideoSrc] = useState<string>('');
  const { formatPrice } = useCurrency();
  const [popularTrips, setPopularTrips] = useState<TripInfo[]>(backupTrips);
  const videoRef = React.useRef<HTMLVideoElement>(null);

  const handleVideoClick = () => {
    if (!videoRef.current) return;
    if (videoRef.current.paused) {
      videoRef.current.play();
    } else {
      videoRef.current.pause();
    }
  };

  useEffect(() => {
    const fetchPopularTrips = async () => {
      try {
        const [routesData, terminalsData] = await Promise.all([
          routesApi.getAll(),
          terminalsApi.getAll()
        ]);

        // Build city to country mapping
        const cityToCountry: Record<string, string> = {};
        terminalsData.forEach(t => {
          if (t.city && t.country) {
            cityToCountry[t.city.toLowerCase()] = t.country;
          }
        });

        // Collect all unique connections from active routes in both directions
        const allTrips: TripInfo[] = [];
        const seenPairs = new Set<string>();

        routesData.forEach(route => {
          if (!route.isActive || !route.stops || route.stops.length < 2) return;
          
          const sortedStops = [...route.stops].sort((a, b) => a.sequenceOrder - b.sequenceOrder);
          for (let i = 0; i < sortedStops.length; i++) {
            for (let j = i + 1; j < sortedStops.length; j++) {
              const stopA = sortedStops[i];
              const stopB = sortedStops[j];
              
              if (!stopA.city || !stopB.city) continue;
              if (stopA.city.toLowerCase() === stopB.city.toLowerCase()) continue;
              
              const distance = Math.abs(stopB.distanceFromOrigin - stopA.distanceFromOrigin);
              const price = Math.round(distance * 0.045 * 100) / 100;
              if (price <= 0) continue;

              const countryA = cityToCountry[stopA.city.toLowerCase()] || '';
              const countryB = cityToCountry[stopB.city.toLowerCase()] || '';
              if (!countryA || !countryB) continue;

              // 1. Forward connection (stopA -> stopB)
              const keyForward = `${stopA.city.toLowerCase()}->${stopB.city.toLowerCase()}`;
              if (!seenPairs.has(keyForward)) {
                seenPairs.add(keyForward);
                allTrips.push({
                  from: stopA.city,
                  to: stopB.city,
                  price,
                  fromCountry: countryA,
                  toCountry: countryB
                });
              }

              // 2. Backward connection (stopB -> stopA)
              const keyBackward = `${stopB.city.toLowerCase()}->${stopA.city.toLowerCase()}`;
              if (!seenPairs.has(keyBackward)) {
                seenPairs.add(keyBackward);
                allTrips.push({
                  from: stopB.city,
                  to: stopA.city,
                  price,
                  fromCountry: countryB,
                  toCountry: countryA
                });
              }
            }
          }
        });

        // Determine popular trips to display
        const activeCountry = user?.country;
        const selected: TripInfo[] = [];

        if (activeCountry) {
          // Logged-in user with a country selected
          const domestic = allTrips.filter(t => 
            t.fromCountry.toLowerCase() === activeCountry.toLowerCase() && 
            t.toCountry.toLowerCase() === activeCountry.toLowerCase()
          );
          const international = allTrips.filter(t => 
            t.fromCountry.toLowerCase() === activeCountry.toLowerCase() && 
            t.toCountry.toLowerCase() !== activeCountry.toLowerCase()
          );

          // Take 2 domestic and 2 international
          selected.push(...domestic.slice(0, 2));
          selected.push(...international.slice(0, 2));

          // Fallback: if we don't have enough, fill up with any trips starting in this country
          if (selected.length < 4) {
            const remainingFromCountry = [
              ...domestic.filter(t => !selected.includes(t)),
              ...international.filter(t => !selected.includes(t))
            ];
            selected.push(...remainingFromCountry.slice(0, 4 - selected.length));
          }
        }

        // Fallback or unlogged-in: load defaults
        if (selected.length < 4) {
          const defaults = getUnloggedInTrips(allTrips);
          for (const def of defaults) {
            if (selected.length >= 4) break;
            if (!selected.some(s => s.from.toLowerCase() === def.from.toLowerCase() && s.to.toLowerCase() === def.to.toLowerCase())) {
              selected.push(def);
            }
          }
        }

        // Double check we have 4, otherwise use backups
        if (selected.length < 4) {
          for (const backup of backupTrips) {
            if (selected.length >= 4) break;
            if (!selected.some(s => s.from.toLowerCase() === backup.from.toLowerCase() && s.to.toLowerCase() === backup.to.toLowerCase())) {
              selected.push(backup);
            }
          }
        }

        setPopularTrips(selected);
      } catch (err) {
        console.error('Failed to calculate popular trips, using backups', err);
        setPopularTrips(backupTrips);
      }
    };

    fetchPopularTrips();
  }, [user]);

  // Defer video loading until the main page is fully loaded
  useEffect(() => {
    const loadVideo = () => {
      setVideoSrc(fleetVideo);
    };

    if (document.readyState === 'complete') {
      loadVideo();
    } else {
      window.addEventListener('load', loadVideo);
      return () => window.removeEventListener('load', loadVideo);
    }
  }, []);

  // Populates the Search Panel inputs with the selected popular route cities
  const handleQuickSearch = (fromCity: string, toCity: string) => {
    const event = new CustomEvent('popular-route-select', {
      detail: { fromCity, toCity }
    });
    window.dispatchEvent(event);

    const element = document.getElementById('search-panel');
    if (element) {
      element.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }
  };

  return (
    <div className="home-page">
      {/* Hero Section */}
      <section className="hero-section">
        <div className="hero-background-gradient" />

        <div className="hero-content">
          <div className="hero-banner-container">
            <ParallaxBanner
              layer1Src={layer1Img}
              layer2Src={layer2Img}
              layer3Src={layer3Img}
              layer4Src={layer4Img}
              altText="Omnibus Widescreen Journey"
            />
            <div className="hero-text-overlay">
              <h1 className="hero-title">Travel by bus all across Europe</h1>
            </div>
          </div>

          {/* Floating Search Panel */}
          <div id="search-panel">
            <SearchPanel />
          </div>
        </div>
      </section>

      {/* Popular Trips Section */}
      <section className="popular-routes-section" id="popular-routes">
        <div className="section-container">
          <h2 className="section-title">
            {user?.country ? `Popular Trips in & from ${user.country}` : 'Popular Trips'}
          </h2>
          <p className="section-subtitle">
            {user?.country 
              ? `Quick access to the most popular journeys in and from ${user.country}` 
              : 'Quick access to the most popular destinations in Europe'}
          </p>

          <div className="routes-grid">
            {popularTrips.map((route, idx) => (
              <div key={idx} className="route-shortcut-card" onClick={() => handleQuickSearch(route.from, route.to)}>
                <div className="route-shortcut-overlay" />
                <div className="route-shortcut-content">
                  <h3>{route.from} ➔ {route.to}</h3>
                  <span className="route-shortcut-price">from {formatPrice(route.price)}</span>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>



      {/* Deals Section */}
      <section className="deals-section">
        <div className="section-container">
          <div className="deals-column">
            {/* Capital Explorer Deal Card */}
            <div className="deal-card">
              <div className="voucher-glow-shape voucher-shape-2" />
              <div className="voucher-glow-shape voucher-shape-3" />
              <div className="voucher-glow-shape voucher-shape-4" />
              <div className="deal-card-header">
                <h2 className="deal-card-section-title"><span className="text-brand-navy">Omnibus</span> offers</h2>
              </div>
              <div className="deal-card-body">
                <div className="deal-info">
                  <h3>Capital Explorer Challenge</h3>
                  <p className="deal-tagline">Collect capitals, earn a free journey!</p>
                  <p className="deal-description">
                    Embark on an Omnibus adventure across Europe. Travel to <strong>3 different capital cities</strong> within 3 months, collect your journey stamps, and we will give you a ticket for the <strong>4th trip absolutely free</strong>.
                  </p>
                </div>
                <div className="deal-voucher-container">
                  <div className="deal-voucher">
                    <div className="voucher-badge">Travel Reward</div>
                    <div className="voucher-amount">100% FREE</div>
                    <div className="voucher-label">4th trip voucher</div>
                    <button className="voucher-btn" type="button" onClick={() => handleQuickSearch('Prague', 'Budapest')}>
                      Start Your Challenge
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Statistics Section */}
      <section className="stats-section">
        <div className="section-container">
          <div className="stats-grid">
            <div className="stat-item">
              <div className="stat-number">100+</div>
              <div className="stat-label">European Cities</div>
            </div>
            <div className="stat-item">
              <div className="stat-number">53</div>
              <div className="stat-label">Active Routes</div>
            </div>
            <div className="stat-item">
              <div className="stat-number">19M+</div>
              <div className="stat-label">Happy Travelers</div>
            </div>
            <div className="stat-item">
              <div className="stat-number">250+</div>
              <div className="stat-label">Daily Connections</div>
            </div>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="features-section">
        <div className="features-container">
          <h2 className="section-title">Why Choose <span className="text-brand-navy">Omnibus</span></h2>
          <p className="section-subtitle">Discover what makes us the preferred choice for millions of travelers</p>

          <div className="features-grid">
            <div className="feature-card">
              <div className="feature-icon">
                <svg viewBox="0 0 24 24" width="44" height="44" stroke="currentColor" strokeWidth="2" fill="none" strokeLinecap="round" strokeLinejoin="round">
                  <rect x="2" y="2" width="20" height="20" rx="5" />
                  <path d="M12 6v12M15 9H11.5a2.5 2.5 0 0 0 0 5h2a2.5 2.5 0 0 1 0 5H9" />
                </svg>
              </div>
              <h3>Best Prices</h3>
              <p>Competitive prices with no hidden fees. Save money on every trip.</p>
            </div>

            <div className="feature-card">
              <div className="feature-icon">
                <svg viewBox="11 12 78 78" width="44" height="44" fill="currentColor">
                  {/* Headrest Left Segment */}
                  <path d="M 40,13 H 42.5 V 25 H 40 C 38.9,25 38,24.1 38,23 V 15 C 38,13.9 38.9,13 40,13 Z" />
                  {/* Headrest Middle Segment */}
                  <rect x="45.5" y="13" width="9" height="12" rx="1.5" />
                  {/* Headrest Right Segment */}
                  <path d="M 57.5,13 H 60 C 61.1,13 62,13.9 62,15 V 23 C 62,24.1 61.1,25 60,25 H 57.5 V 13 Z" />

                  {/* Backrest Wings */}
                  <path d="M 34,27 C 35.5,27 36.5,28 37,29 C 35.8,35 35,45 35,79 H 28.2 C 28.2,70 28.5,50 31,38 C 32,33 33,29 34,27 Z" />
                  <path d="M 66,27 C 64.5,27 63.5,28 63,29 C 64.2,35 65,45 65,79 H 71.8 C 71.8,70 71.5,50 69,38 C 68,33 67,29 66,27 Z" />

                  {/* Backrest Center Section */}
                  {/* Top block with slot */}
                  <path fillRule="evenodd" d="M 40,27 H 60 C 60.5,29 60.8,32 61,39 H 39 C 39.2,32 39.5,29 40,27 Z M 56,33 H 44 C 43.2,33 42.5,33.7 42.5,34.5 C 42.5,35.3 43.2,36 44,36 H 56 C 56.8,36 57.5,35.3 57.5,34.5 C 57.5,33.7 56.8,33 56,33 Z" />
                  {/* Second block */}
                  <path d="M 38.8,41 H 61.2 V 51 H 38.8 Z" />
                  {/* Third block */}
                  <path d="M 38.3,53 H 61.7 V 63 H 38.3 Z" />
                  {/* Fourth block */}
                  <path d="M 38,65 H 62 V 79 H 38 Z" />

                  {/* Bottom Cradle */}
                  <path d="M 30,71 A 3,3 0 0 0 24,71 V 81 C 24,85.4 27.6,89 32,89 H 68 C 72.4,89 76,85.4 76,81 V 71 A 3,3 0 0 0 70,71 V 77 C 70,79.8 67.8,82 65,82 H 35 C 32.2,82 30,79.8 30,77 Z" />
                </svg>
              </div>
              <h3>Comfort First</h3>
              <p>Modern buses with spacious seats, WiFi, and power outlets.</p>
            </div>

            <div className="feature-card">
              <div className="feature-icon">
                <svg viewBox="0 0 24 24" width="44" height="44" stroke="currentColor" strokeWidth="2" fill="none" strokeLinecap="round" strokeLinejoin="round">
                  <path d="M21.5 2v6h-6" />
                  <path d="M21.34 15.57a10 10 0 1 1-.57-8.38l.73-.73" />
                  <polyline points="12 6 12 12 16 14" />
                </svg>
              </div>
              <h3>On Time</h3>
              <p>Reliable schedules with real-time tracking of your bus.</p>
            </div>

            <div className="feature-card">
              <div className="feature-icon">
                <svg viewBox="15 15 72 72" width="44" height="44" fill="currentColor">
                  {/* Connectors */}
                  <line x1="36" y1="56" x2="70" y2="62" stroke="currentColor" strokeWidth="4.5" strokeLinecap="round" />
                  <line x1="70" y1="62" x2="45" y2="78" stroke="currentColor" strokeWidth="4.5" strokeLinecap="round" />

                  {/* Top-left Crescent */}
                  <path d="M 20,52 C 18,55 22,61 30,61 C 38,61 42,55 40,52 C 39,50.5 37.5,50.5 36.5,52 C 35,54 33,55 30,55 C 27,55 25,54 23.5,52 C 22.5,50.5 21,50.5 20,52 Z" />

                  {/* Right Ellipse */}
                  <ellipse cx="70" cy="62" rx="13" ry="7" />

                  {/* Bottom Ellipse */}
                  <ellipse cx="45" cy="78" rx="14" ry="8" />

                  {/* Map Pin */}
                  <path fillRule="evenodd" d="M 30,50 C 26,42 19,37 19,28 C 19,21.9 23.9,17 30,17 C 36.1,17 41,21.9 41,28 C 41,37 34,42 30,50 Z M 30,23.5 C 27.5,23.5 25.5,25.5 25.5,28 C 25.5,30.5 27.5,32.5 30,32.5 C 32.5,32.5 34.5,30.5 34.5,28 C 34.5,25.5 32.5,23.5 30,23.5 Z" />
                </svg>
              </div>
              <h3>Wide Network</h3>
              <p>Travel to hundreds of destinations across Europe.</p>
            </div>
          </div>
        </div>
      </section>


      {/* Video Section */}
      <section className="fleet-section">
        <div className="fleet-container">
          <div className="fleet-header">
            <h2 className="section-title">Our Fleet</h2>
            <p className="section-subtitle">Take a look inside our modern and fully-equipped long-distance buses</p>
          </div>

          <div className="fleet-content-grid">
            <div className="fleet-video-column">
              <div className="fleet-video-glow" />
              <div className="fleet-video-wrapper">
                <video
                  ref={videoRef}
                  src={videoSrc || undefined}
                  preload="metadata"
                  controls
                  onPlay={() => setIsVideoPlaying(true)}
                  onPause={() => setIsVideoPlaying(false)}
                  onEnded={() => setIsVideoPlaying(false)}
                  className="fleet-video"
                />
                <div 
                  className="fleet-video-click-overlay" 
                  onClick={handleVideoClick}
                >
                  <div className={`fleet-video-title ${isVideoPlaying ? 'fade-out' : ''}`}>
                    2020 Setra S515 HD Walkaround
                  </div>
                </div>
              </div>
            </div>

            <div className="fleet-text-column">
              <h3>Setra S515 HD: The Comfort Standard</h3>
              <p className="fleet-description">
                Experience a new level of travel comfort on our long-distance European routes.
                The Setra S515 HD combines first-class engineering with premium amenities to ensure your journey is as relaxing as it is safe.
              </p>

              <div className="fleet-features-list">
                <div className="fleet-feature-item">
                  <div className="fleet-feature-icon">
                    <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" strokeWidth="2.5" fill="none" strokeLinecap="round" strokeLinejoin="round">
                      <path d="M5 12.55a11 11 0 0 1 14.08 0" />
                      <path d="M1.42 9a16 16 0 0 1 21.16 0" />
                      <path d="M8.53 16.11a6 6 0 0 1 6.95 0" />
                      <line x1="12" y1="20" x2="12.01" y2="20" />
                    </svg>
                  </div>
                  <div className="fleet-feature-text">
                    <h4>High-speed Wi-Fi</h4>
                    <p>Stay connected, work, or stream content seamlessly.</p>
                  </div>
                </div>

                <div className="fleet-feature-item">
                  <div className="fleet-feature-icon">
                    <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" strokeWidth="2" fill="none" strokeLinecap="round" strokeLinejoin="round">
                      <rect x="6" y="2" width="12" height="20" rx="2" />
                      <line x1="11" y1="5" x2="13" y2="5" />
                      <path d="M13 8.5 L9.5 13 h5 L11 17.5" />
                      <circle cx="12" cy="20" r="0.5" fill="currentColor" stroke="none" />
                    </svg>
                  </div>
                  <div className="fleet-feature-text">
                    <h4>USB & Power Outlets</h4>
                    <p>Keep all your devices fully charged throughout the ride.</p>
                  </div>
                </div>

                <div className="fleet-feature-item">
                  <div className="fleet-feature-icon">
                    <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" strokeWidth="2" fill="none" strokeLinecap="round" strokeLinejoin="round">
                      <rect x="9.5" y="2.5" width="5" height="3.5" rx="1.2" />
                      <path d="M11 6 v1.5 M13 6 v1.5" />
                      <rect x="6.5" y="7.5" width="11" height="9.5" rx="2" />
                      <rect x="5" y="17" width="14" height="3.5" rx="1.2" />
                      <path d="M9 21 h6" />
                    </svg>
                  </div>
                  <div className="fleet-feature-text">
                    <h4>Adjustable Seats</h4>
                    <p>Spacious seating with extra legroom for maximum comfort.</p>
                  </div>
                </div>

                <div className="fleet-feature-item">
                  <div className="fleet-feature-icon">
                    <svg viewBox="0 0 24 24" width="20" height="20" stroke="currentColor" strokeWidth="2" fill="none" strokeLinecap="round" strokeLinejoin="round">
                      <line x1="2" y1="12" x2="22" y2="12" />
                      <line x1="12" y1="2" x2="12" y2="22" />
                      <path d="m20 16-4-4 4-4" />
                      <path d="m4 8 4 4-4 4" />
                      <path d="m16 4-4 4-4-4" />
                      <path d="m8 20 4-4 4 4" />
                      <line x1="19" y1="5" x2="5" y2="19" />
                      <line x1="19" y1="19" x2="5" y2="5" />
                    </svg>
                  </div>
                  <div className="fleet-feature-text">
                    <h4>Climate Control</h4>
                    <p>Individually controlled ventilation and temperature settings.</p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>


    </div>
  );
};

export default HomePage;
