import React, { createContext, useContext, useState, useEffect, type ReactNode } from 'react';
import { authApi, type AuthResponse } from '../api/auth';

interface User {
  id: number;
  email: string;
  firstName: string;
  lastName: string;
  role: string;
  phone?: string;
  preferredCurrency?: string;
  country?: string;
  avatarData?: string;
}

interface AuthContextType {
  user: User | null;
  token: string | null;
  isAuthenticated: boolean;
  isLoading: boolean;
  login: (email: string, password: string) => Promise<void>;
  register: (
    email: string,
    password: string,
    firstName: string,
    lastName: string,
    phone?: string,
    preferredCurrency?: string,
    country?: string,
    avatarData?: string
  ) => Promise<void>;
  logout: () => void;
  updateUser: (userData: User) => void;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

const isTokenExpired = (token: string): boolean => {
  try {
    const parts = token.split('.');
    if (parts.length !== 3) return true;
    const base64 = parts[1].replace(/-/g, '+').replace(/_/g, '/');
    const jsonPayload = decodeURIComponent(
      window.atob(base64)
        .split('')
        .map((c) => '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2))
        .join('')
    );
    const payload = JSON.parse(jsonPayload);
    return payload.exp ? payload.exp * 1000 < Date.now() : true;
  } catch {
    return true;
  }
};

export const AuthProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const [token, setToken] = useState<string | null>(() => {
    const storedToken = localStorage.getItem('token');
    if (storedToken) {
      if (isTokenExpired(storedToken)) {
        localStorage.removeItem('token');
        localStorage.removeItem('user');
        return null;
      }
      return storedToken;
    }
    return null;
  });

  const [user, setUser] = useState<User | null>(() => {
    const storedToken = localStorage.getItem('token');
    if (!storedToken) return null; // If token was cleared as expired

    const storedUser = localStorage.getItem('user');
    if (storedUser) {
      try {
        return JSON.parse(storedUser);
      } catch {
        localStorage.removeItem('token');
        localStorage.removeItem('user');
      }
    }
    return null;
  });
  const [isLoading] = useState(false);


  // Sync React state when Axios interceptor clears localStorage on 401
  useEffect(() => {
    const handleStorageChange = (e: StorageEvent) => {
      if (e.key === 'token' && e.newValue === null) {
        setToken(null);
        setUser(null);
      }
    };
    const handleUnauthorizedLogout = () => {
      setToken(null);
      setUser(null);
    };
    window.addEventListener('storage', handleStorageChange);
    window.addEventListener('unauthorized-logout', handleUnauthorizedLogout);
    return () => {
      window.removeEventListener('storage', handleStorageChange);
      window.removeEventListener('unauthorized-logout', handleUnauthorizedLogout);
    };
  }, []);

  const login = async (email: string, password: string) => {
    const response: AuthResponse = await authApi.login({ email, password });

    setToken(response.accessToken);
    setUser(response.user);

    localStorage.setItem('token', response.accessToken);
    localStorage.setItem('user', JSON.stringify(response.user));
  };

  const register = async (
    email: string,
    password: string,
    firstName: string,
    lastName: string,
    phone?: string,
    preferredCurrency?: string,
    country?: string,
    avatarData?: string
  ) => {
    const response: AuthResponse = await authApi.register({
      email,
      password,
      firstName,
      lastName,
      phone,
      preferredCurrency,
      country,
      avatarData,
    });

    setToken(response.accessToken);
    setUser(response.user);

    localStorage.setItem('token', response.accessToken);
    localStorage.setItem('user', JSON.stringify(response.user));
  };

  const logout = () => {
    setToken(null);
    setUser(null);
    localStorage.removeItem('token');
    localStorage.removeItem('user');
  };

  const updateUser = (userData: User) => {
    setUser(userData);
    localStorage.setItem('user', JSON.stringify(userData));
  };

  return (
    <AuthContext.Provider
      value={{
        user,
        token,
        isAuthenticated: !!token,
        isLoading,
        login,
        register,
        logout,
        updateUser,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
};

// eslint-disable-next-line react-refresh/only-export-components
export const useAuth = () => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};

export default AuthContext;
