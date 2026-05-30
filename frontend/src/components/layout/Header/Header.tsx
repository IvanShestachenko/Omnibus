import React from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from '../../../context/AuthContext';
import { Button } from '../../common';
import logoImg from '../../../assets/logo_3.png';
import './Header.css';

export const Header: React.FC = () => {
  const { user, isAuthenticated, logout } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();

  const handleLogout = () => {
    logout();
    navigate('/');
  };

  const isHomepage = location.pathname === '/';

  return (
    <header className={`header ${isHomepage ? 'header-transparent' : 'header-solid'}`}>
      <div className="header-container">
        <Link to="/" className="header-logo">
          <img src={logoImg} alt="Omnibus" className="logo-image" />
        </Link>


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
                <Button variant="ghost" size="md">Login</Button>
              </Link>
              <Link to="/register">
                <Button variant="primary" size="md">Sign Up</Button>
              </Link>
            </>
          )}
        </div>
      </div>
    </header>
  );
};

export default Header;
