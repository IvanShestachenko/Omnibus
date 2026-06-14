import { BrowserRouter, Routes, Route, useLocation } from 'react-router-dom';
import { useEffect } from 'react';
import { AuthProvider } from './context/AuthContext';
import { CurrencyProvider } from './context/CurrencyContext';
import { Header, Footer } from './components/layout';
import { ProtectedRoute, OfflineAlert } from './components/common';
import {
  LoginPage,
  RegisterPage,
  HomePage,
  SearchPage,
  TripDetailsPage,
  ReservationsPage,
  ProfilePage,
  PaymentPage
} from './pages';
import { OmnibusOOP } from './utils/oopPatterns';
import './index.css';
import './App.css';

// Placeholder pages (to be implemented)


const AdminPage = () => (
  <div className="page">
    <h1>Admin Dashboard</h1>
    <p className="text-secondary">Coming soon...</p>
  </div>
);

const DriverPage = () => (
  <div className="page">
    <h1>Driver Dashboard</h1>
    <p className="text-secondary">Coming soon...</p>
  </div>
);

const NotFoundPage = () => (
  <div className="page not-found">
    <h1>404</h1>
    <p className="text-secondary">Page not found</p>
  </div>
);

const ScrollToTop = () => {
  const { pathname } = useLocation();

  useEffect(() => {
    window.scrollTo(0, 0);
  }, [pathname]);

  return null;
};

const ScrollToHash = () => {
  const { pathname, hash } = useLocation();

  useEffect(() => {
    if (hash) {
      const timer = setTimeout(() => {
        const id = hash.replace('#', '');
        const element = document.getElementById(id);
        if (element) {
          element.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
      }, 100);
      return () => clearTimeout(timer);
    }
  }, [pathname, hash]);

  return null;
};

function App() {
  useEffect(() => {
    // Prototypical inheritance demo initialization
    const testTicket = new OmnibusOOP.BusTicket("Prague - Brno", 350, "12A");
    console.log("--- OOP Prototypical Inheritance Demo ---");
    console.log("Summary:", testTicket.getSummary());
    console.log("Detailed Summary:", testTicket.getDetailedSummary());
    console.log("InstanceOf BusTicket:", testTicket instanceof OmnibusOOP.BusTicket);
    console.log("InstanceOf BaseTicket:", testTicket instanceof OmnibusOOP.BaseTicket);
    console.log("-----------------------------------------");
  }, []);

  return (
    <BrowserRouter>
      <AuthProvider>
        <CurrencyProvider>
          <div className="app">
            <OfflineAlert />
            <ScrollToTop />
            <ScrollToHash />
            <Header />
            <main className="main">
              <Routes>
                {/* Public routes */}
                <Route path="/" element={<HomePage />} />
                <Route path="/search" element={<SearchPage />} />
                <Route path="/trip/:id" element={<TripDetailsPage />} />
                <Route path="/login" element={<LoginPage />} />
                <Route path="/register" element={<RegisterPage />} />

                {/* Protected routes - User */}
                <Route
                  path="/reservations"
                  element={
                    <ProtectedRoute>
                      <ReservationsPage />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path="/profile"
                  element={
                    <ProtectedRoute>
                      <ProfilePage />
                    </ProtectedRoute>
                  }
                />
                <Route
                  path="/payment/:reservationId"
                  element={
                    <ProtectedRoute>
                      <PaymentPage />
                    </ProtectedRoute>
                  }
                />

                {/* Protected routes - Admin */}
                <Route
                  path="/admin/*"
                  element={
                    <ProtectedRoute allowedRoles={['admin']}>
                      <AdminPage />
                    </ProtectedRoute>
                  }
                />

                {/* Protected routes - Driver */}
                <Route
                  path="/driver/*"
                  element={
                    <ProtectedRoute allowedRoles={['driver']}>
                      <DriverPage />
                    </ProtectedRoute>
                  }
                />

                {/* 404 */}
                <Route path="*" element={<NotFoundPage />} />
              </Routes>
            </main>
            <Footer />
          </div>
        </CurrencyProvider>
      </AuthProvider>
    </BrowserRouter>
  );
}

export default App;
