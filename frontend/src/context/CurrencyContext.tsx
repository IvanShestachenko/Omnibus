import React, { createContext, useContext, useState, useEffect, type ReactNode } from 'react';
import { useAuth } from './AuthContext';
import api from '../api/client';

export type CurrencyType = 'EUR' | 'CZK' | 'USD' | 'UAH' | 'GBP';

interface CurrencyContextType {
  currency: CurrencyType;
  changeCurrency: (newCurrency: CurrencyType) => Promise<void>;
  formatPrice: (amountInEUR: number) => string;
}

const CurrencyContext = createContext<CurrencyContextType | undefined>(undefined);

const conversionRates: Record<CurrencyType, number> = {
  EUR: 1.0,
  USD: 1.08,
  CZK: 25.0,
  UAH: 44.0,
  GBP: 0.85,
};

export const CurrencyProvider: React.FC<{ children: ReactNode }> = ({ children }) => {
  const { user, isAuthenticated, updateUser } = useAuth();
  
  const [currency, setCurrencyState] = useState<CurrencyType>(() => {
    const saved = localStorage.getItem('preferred_currency');
    return (saved as CurrencyType) || 'EUR';
  });

  useEffect(() => {
    if (user && user.preferredCurrency && user.preferredCurrency !== currency) {
      const preferred = user.preferredCurrency as CurrencyType;
      setTimeout(() => {
        setCurrencyState(preferred);
      }, 0);
      localStorage.setItem('preferred_currency', preferred);
    }
  }, [user, currency]);

  const changeCurrency = async (newCurrency: CurrencyType) => {
    setCurrencyState(newCurrency);
    localStorage.setItem('preferred_currency', newCurrency);

    if (isAuthenticated && user) {
      try {
        const updatedUser = {
          ...user,
          preferredCurrency: newCurrency,
        };
        
        // Background API call to save user preferred currency
        await api.put(`/users/${user.id}`, {
          firstName: user.firstName,
          lastName: user.lastName,
          phone: user.phone || null,
          preferredCurrency: newCurrency,
          country: user.country || null,
          avatarData: user.avatarData || null,
        });

        // Sync local auth context user object
        updateUser(updatedUser);
      } catch (err) {
        console.error('Failed to save preferred currency to database', err);
      }
    }
  };

  const formatPrice = (amountInEUR: number): string => {
    const rate = conversionRates[currency];
    const converted = amountInEUR * rate;

    if (currency === 'CZK') {
      return `${Math.round(converted)} Kč`;
    }
    if (currency === 'UAH') {
      return `₴${Math.round(converted)}`;
    }
    if (currency === 'USD') {
      return `$${converted.toFixed(2)}`;
    }
    if (currency === 'GBP') {
      return `£${converted.toFixed(2)}`;
    }
    // Default EUR
    return `€${converted.toFixed(2)}`;
  };

  return (
    <CurrencyContext.Provider value={{ currency, changeCurrency, formatPrice }}>
      {children}
    </CurrencyContext.Provider>
  );
};

// eslint-disable-next-line react-refresh/only-export-components
export const useCurrency = () => {
  const context = useContext(CurrencyContext);
  if (context === undefined) {
    throw new Error('useCurrency must be used within a CurrencyProvider');
  }
  return context;
};

export default CurrencyContext;
