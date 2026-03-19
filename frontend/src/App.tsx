import { BrowserRouter, Routes, Route } from 'react-router-dom';
import { AuthProvider } from './context/AuthContext';
import { Header, Footer } from './components/layout';
import { ProtectedRoute } from './components/common';
import {
  LoginPage,
  RegisterPage,
  HomePage,
  SearchPage,
  TripDetailsPage,
  ReservationsPage
} from './pages';
import './index.css';
import './App.css';

// Placeholder pages (to be implemented)
const ProfilePage = () => (
  <div className="page">
    <h1>Profile</h1>
    <p className="text-secondary">Coming soon...</p>
  </div>
);

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

function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <div className="app">
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
      </AuthProvider>
    </BrowserRouter>
  );
}

export default App;
