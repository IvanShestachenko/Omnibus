import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { Button, SearchPanel } from '../components/common';
import { routesApi, type RouteResponse } from '../api/routes';
import layer1Img from '../assets/layer_1_cut.png';
import layer2Img from '../assets/layer_2_cut.png';
import layer3Img from '../assets/layer_3_cut.png';
import layer4Img from '../assets/layer_4_cut.png';
import { ParallaxBanner } from '../components/common/ParallaxBanner/ParallaxBanner';
import './HomePage.css';

export const HomePage: React.FC = () => {
  const navigate = useNavigate();
  const [routes, setRoutes] = useState<RouteResponse[]>([]);

  // Load routes to navigate directly for Popular Routes quick search
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

  // Quick search popular route triggers (Navigates directly for premium instant UX!)
  const handleQuickSearch = (fromCity: string, toCity: string) => {
    const matchingRouteId = findMatchingRouteId(fromCity, toCity);
    if (matchingRouteId) {
      const todayStr = new Date().toISOString().split('T')[0];
      navigate(`/search?routeId=${matchingRouteId}&date=${todayStr}&passengers=1`);
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
          <SearchPanel />
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
