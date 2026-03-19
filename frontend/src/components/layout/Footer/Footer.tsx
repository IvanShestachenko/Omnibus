import React from 'react';
import './Footer.css';

export const Footer: React.FC = () => {
  return (
    <footer className="footer">
      <div className="footer-container">
        <div className="footer-brand">
          <span className="footer-logo">🚌 bus2holiday</span>
          <p className="footer-tagline">Your journey starts here</p>
        </div>

        <div className="footer-links">
          <div className="footer-section">
            <h4>Travel</h4>
            <a href="/search">Find Trips</a>
            <a href="/routes">Popular Routes</a>
          </div>

          <div className="footer-section">
            <h4>Support</h4>
            <a href="/help">Help Center</a>
            <a href="/contact">Contact Us</a>
          </div>

          <div className="footer-section">
            <h4>Legal</h4>
            <a href="/terms">Terms of Service</a>
            <a href="/privacy">Privacy Policy</a>
          </div>
        </div>

        <div className="footer-bottom">
          <p>© 2026 Bus2Holiday. All rights reserved.</p>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
