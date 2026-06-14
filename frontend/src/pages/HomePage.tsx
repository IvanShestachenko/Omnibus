import React, { useState, useEffect } from 'react';
import { SearchPanel } from '../components/common';
import { useCurrency } from '../context/CurrencyContext';
import { useAuth } from '../context/AuthContext';
import { routesApi, type TripInfo } from '../api/routes';
import layer1Img from '../assets/layer_1_cut.webp';
import layer2Img from '../assets/layer_2_cut.webp';
import layer3Img from '../assets/layer_3_cut.webp';
import layer4Img from '../assets/layer_4_cut.webp';
import fleetVideo from '../assets/2020_Setra_S515_HD_Walkaround.mp4';
import videoPoster from '../assets/video_poster.webp';
import { ParallaxBanner } from '../components/common/ParallaxBanner/ParallaxBanner';
import './HomePage.css';

const backupTrips: TripInfo[] = [
  { from: 'Prague', to: 'Brno', price: 8.36, fromCountry: 'Czech Republic', toCountry: 'Czech Republic' },
  { from: 'Berlin', to: 'Munich', price: 23.41, fromCountry: 'Germany', toCountry: 'Germany' },
  { from: 'Paris', to: 'Marseille', price: 29.93, fromCountry: 'France', toCountry: 'France' },
  { from: 'Warsaw', to: 'Kraków', price: 11.30, fromCountry: 'Poland', toCountry: 'Poland' }
];

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
        const selected = await routesApi.getPopular(user?.country);
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
            {user?.country ? `Trending Routes: ${user.country}` : 'Popular Trips'}
          </h2>
          <p className="section-subtitle">
            {user?.country 
              ? `Top domestic connections and international routes starting from ${user.country}` 
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
                  poster={videoPoster}
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
                    <svg viewBox="18 16 131 133" width="20" height="20" fill="none">
                      <g transform="translate(0.000000,165.000000) scale(0.100000,-0.100000)" fill="currentColor" stroke="none">
                        <path d="M280 1410 c-19 -19 -20 -33 -20 -434 l0 -415 26 -20 c25 -20 39 -21 238 -21 200 0 214 1 234 20 22 21 22 22 22 435 0 402 -1 416 -20 435 -19 19 -33 20 -240 20 -207 0 -221 -1 -240 -20z m290 -40 c0 -5 -22 -10 -50 -10 -27 0 -50 5 -50 10 0 6 23 10 50 10 28 0 50 -4 50 -10z m180 -380 l0 -330 -230 0 -230 0 0 330 0 330 230 0 230 0 0 -330z m-206 -376 c9 -8 16 -19 16 -24 0 -11 -29 -40 -40 -40 -5 0 -16 10 -24 22 -14 20 -14 24 1 40 20 22 27 22 47 2z"/>
                        <path d="M492 1082 c-39 -59 -72 -110 -72 -114 0 -5 18 -8 41 -8 34 0 39 -3 35 -17 -16 -54 -28 -113 -24 -124 4 -12 148 183 148 201 0 5 -18 10 -40 10 -46 0 -46 0 -24 82 8 33 14 64 12 69 -2 4 -36 -40 -76 -99z"/>
                        <path d="M986 1334 c-24 -23 -24 -385 0 -408 8 -9 20 -16 25 -16 12 0 12 23 -1 36 -7 7 -9 77 -8 190 l3 179 170 0 170 0 3 -179 c1 -113 -1 -183 -8 -190 -13 -13 -13 -36 -1 -36 5 0 17 7 25 16 24 23 24 385 0 408 -13 13 -45 16 -189 16 -144 0 -176 -3 -189 -16z"/>
                        <path d="M1107 1214 c-13 -13 -7 -71 8 -84 19 -16 28 4 23 51 -3 32 -17 46 -31 33z"/>
                        <path d="M1217 1213 c-10 -10 -8 -81 2 -87 18 -11 32 22 25 58 -6 35 -14 43 -27 29z"/>
                        <path d="M1052 1082 c-9 -7 -12 -47 -10 -168 l3 -159 130 0 130 0 3 159 c2 121 -1 161 -10 168 -7 4 -62 8 -123 8 -60 0 -116 -4 -123 -8z"/>
                        <path d="M1130 692 c0 -35 4 -52 15 -56 12 -4 15 -29 15 -133 0 -70 -5 -144 -10 -164 -15 -54 -51 -101 -95 -126 -37 -21 -52 -23 -215 -23 -163 0 -178 2 -215 23 -26 14 -48 37 -62 67 -27 51 -30 115 -8 124 11 4 15 20 15 56 l0 50 -50 0 -50 0 0 -50 c0 -30 5 -52 13 -57 8 -4 17 -30 20 -57 13 -95 71 -163 160 -187 24 -6 106 -9 201 -7 173 3 211 13 263 70 51 54 63 103 63 258 0 134 2 147 21 163 15 13 19 27 17 55 -3 37 -4 37 -50 40 l-48 3 0 -49z"/>
                      </g>
                    </svg>
                  </div>
                  <div className="fleet-feature-text">
                    <h4>USB & Power Outlets</h4>
                    <p>Keep all your devices fully charged throughout the ride.</p>
                  </div>
                </div>

                <div className="fleet-feature-item">
                  <div className="fleet-feature-icon">
                    <svg viewBox="20 10 232 252" width="20" height="20" fill="none">
                      <g transform="translate(0.000000,272.000000) scale(0.100000,-0.100000)" fill="currentColor" stroke="none">
                        <path d="M1008 2614 c-33 -17 -49 -46 -77 -137 -24 -80 -20 -115 20 -153 22 -21 41 -28 84 -32 l55 -4 0 -78 0 -77 -102 -5 c-63 -4 -118 -12 -141 -22 -45 -20 -109 -76 -136 -119 -19 -31 -146 -448 -195 -640 -35 -135 -41 -231 -26 -412 l13 -156 41 -21 c23 -11 67 -40 99 -64 33 -24 69 -44 80 -44 12 0 90 13 172 30 207 40 307 51 471 52 183 0 307 -15 531 -62 51 -11 104 -20 117 -20 13 0 50 20 83 44 32 24 76 53 99 64 l41 21 13 156 c15 181 9 277 -26 412 -49 192 -176 609 -195 640 -27 43 -91 99 -136 119 -23 10 -78 18 -140 22 l-103 5 0 77 0 78 55 4 c64 5 109 39 119 89 5 29 -23 138 -50 191 -29 56 -42 58 -406 58 -275 -1 -338 -3 -360 -16z m532 -404 l0 -80 -170 0 -170 0 0 80 0 80 170 0 170 0 0 -80z m32 -390 c80 -25 156 -74 181 -118 26 -45 43 -114 66 -277 21 -146 51 -488 51 -581 l0 -54 -53 0 -53 0 -12 190 c-13 202 -44 469 -68 585 -17 80 -36 105 -105 134 -144 62 -411 39 -488 -43 -37 -39 -81 -330 -103 -676 l-12 -190 -54 0 -55 0 7 138 c12 242 49 564 78 681 25 101 64 148 163 192 116 52 324 60 457 19z"/>
                        <path d="M355 665 c-47 -17 -82 -57 -91 -103 -7 -36 11 -195 27 -248 5 -17 22 -42 37 -56 21 -21 277 -157 355 -190 16 -7 17 8 17 230 l0 238 -35 13 c-19 6 -53 28 -77 47 -83 70 -162 94 -233 69z"/>
                        <path d="M2290 671 c-46 -10 -87 -32 -139 -75 -23 -19 -57 -41 -76 -47 l-35 -13 0 -238 0 -238 28 12 c15 7 92 46 172 87 143 72 182 98 202 135 11 21 38 184 38 236 0 95 -89 161 -190 141z"/>
                        <path d="M1160 614 c-48 -6 -311 -53 -332 -60 -17 -5 -18 -26 -18 -250 l0 -244 560 0 560 0 0 244 c0 224 -1 245 -17 250 -10 3 -81 17 -158 32 -118 22 -172 27 -350 29 -115 2 -226 1 -245 -1z"/>
                      </g>
                    </svg>
                  </div>
                  <div className="fleet-feature-text">
                    <h4>Adjustable Seats</h4>
                    <p>Spacious seating with extra legroom for maximum comfort.</p>
                  </div>
                </div>

                <div className="fleet-feature-item">
                  <div className="fleet-feature-icon">
                    <svg viewBox="15 25 170 160" width="20" height="20" fill="none">
                      <g transform="translate(0.000000,200.000000) scale(0.100000,-0.100000)" fill="currentColor" stroke="none">
                        <path d="M1222 1673 c-46 -25 -86 -52 -89 -60 -6 -15 9 -114 28 -185 10 -40 25 -46 78 -31 22 5 23 9 17 54 -4 27 -4 49 0 49 20 0 110 -68 156 -119 63 -68 110 -153 132 -237 20 -78 20 -213 1 -289 -46 -176 -189 -328 -368 -390 -62 -21 -62 -22 -61 -59 2 -58 14 -63 91 -38 189 61 350 217 419 405 104 289 -7 619 -266 786 l-61 40 30 16 c17 8 31 22 31 31 0 24 -29 74 -43 74 -6 -1 -49 -21 -95 -47z"/>
                        <path d="M773 1626 c-136 -51 -271 -161 -342 -279 -185 -311 -93 -711 207 -905 l63 -41 -30 -16 c-17 -8 -31 -22 -31 -31 0 -21 29 -74 40 -74 20 0 182 93 187 108 6 14 -9 113 -28 185 -10 39 -25 45 -78 30 -22 -5 -23 -9 -17 -54 4 -27 4 -49 0 -49 -20 0 -110 68 -156 119 -63 68 -110 153 -132 237 -20 78 -20 213 -1 289 46 175 187 325 368 390 67 24 76 39 58 88 -13 33 -27 33 -108 3z"/>
                        <path d="M957 1424 c-4 -4 -7 -48 -7 -98 l0 -91 -38 -16 -37 -16 -67 65 c-63 61 -69 65 -93 54 -14 -6 -31 -23 -37 -37 -11 -24 -7 -30 54 -93 l65 -67 -16 -37 -16 -37 -95 -3 -95 -3 0 -45 0 -45 95 -3 95 -3 16 -37 16 -37 -65 -67 c-61 -63 -65 -69 -54 -93 6 -14 23 -31 37 -37 24 -11 30 -7 93 54 l67 65 37 -16 37 -16 3 -95 3 -95 45 0 45 0 3 95 3 95 37 16 37 16 67 -65 c63 -61 69 -65 93 -54 14 6 31 23 37 37 11 24 7 30 -54 93 l-65 67 16 37 16 37 95 3 95 3 0 45 0 45 -95 3 -95 3 -16 37 -16 37 65 67 c61 63 65 69 54 93 -6 14 -23 31 -37 37 -24 11 -30 7 -93 -54 l-67 -65 -37 16 -37 16 -3 95 -3 95 -40 3 c-23 2 -44 0 -48 -4z m100 -303 c96 -44 102 -190 11 -237 -76 -39 -160 -9 -192 69 -20 47 -20 47 0 95 15 38 28 51 64 70 53 27 63 27 117 3z"/>
                      </g>
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
