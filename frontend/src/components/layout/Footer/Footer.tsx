import React from 'react';
import './Footer.css';

export const Footer: React.FC = () => {
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
            <a href="/#search-panel">Find Trips</a>
            <a href="/#popular-routes">Popular Routes</a>
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
