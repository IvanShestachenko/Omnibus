import React from 'react';
import './Footer.css';

export const Footer: React.FC = () => {
  const handleHashLinkClick = (e: React.MouseEvent<HTMLAnchorElement>, targetId: string) => {
    if (window.location.pathname === '/') {
      e.preventDefault();
      const element = document.getElementById(targetId);
      if (element) {
        element.scrollIntoView({ behavior: 'smooth', block: 'center' });
        window.history.pushState(null, '', `/#${targetId}`);
      }
    }
  };

  return (
    <footer className="footer">
      <div className="footer-container">
        <div className="footer-brand">
          <span className="footer-logo">Omnibus</span>
          <p className="footer-tagline">Travel by bus all across Europe</p>
        </div>

        <nav className="footer-links" aria-label="Footer Navigation">
          <section className="footer-section">
            <h4>Travel</h4>
            <a href="/#search-panel" onClick={(e) => handleHashLinkClick(e, 'search-panel')}>Find Trips</a>
            <a href="/#popular-routes" onClick={(e) => handleHashLinkClick(e, 'popular-routes')}>Popular Routes</a>
          </section>

          <section className="footer-section">
            <h4>Support</h4>
            <a href="/help">Help Center</a>
            <a href="/contact">Contact Us</a>
          </section>

          <section className="footer-section">
            <h4>Legal</h4>
            <a href="/terms">Terms of Service</a>
            <a href="/privacy">Privacy Policy</a>
          </section>
        </nav>

        <div className="footer-bottom">
          <p>© 2026 Omnibus. All rights reserved.</p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
