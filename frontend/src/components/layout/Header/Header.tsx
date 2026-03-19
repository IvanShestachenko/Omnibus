import React from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '../../../context/AuthContext';
import { Button } from '../../common';
import './Header.css';

export const Header: React.FC = () => {
  const { user, isAuthenticated, logout } = useAuth();
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    navigate('/');
  };

  return (
    <header className="header">
      <div className="header-container">
        <Link to="/" className="header-logo">
          <span className="logo-icon">🚌</span>
          <span className="logo-text">bus2holiday</span>
        </Link>

        <nav className="header-nav">
          <Link to="/" className="nav-link">Home</Link>
          <Link to="/search" className="nav-link">Search Trips</Link>
        </nav>

        <div className="header-actions">
          {isAuthenticated ? (
            <>
              {user?.role === 'admin' && (
                <Link to="/admin" className="nav-link">Admin</Link>
              )}
              {user?.role === 'driver' && (
                <Link to="/driver" className="nav-link">My Trips</Link>
              )}
              <Link to="/reservations" className="nav-link">My Reservations</Link>
              <div className="user-menu">
                <span className="user-name">{user?.firstName}</span>
                <Button variant="ghost" size="sm" onClick={handleLogout}>
                  Logout
                </Button>
              </div>
            </>
          ) : (
            <>
              <Link to="/login">
                <Button variant="ghost" size="sm">Login</Button>
              </Link>
              <Link to="/register">
                <Button variant="primary" size="sm">Sign Up</Button>
              </Link>
            </>
          )}
        </div>
      </div>
    </header>
  );
};

export default Header;
