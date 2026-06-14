import React, { useState } from 'react';
import { Link, useNavigate, useSearchParams } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { useAuth } from '../context/AuthContext';
import { Button, Input, Card } from '../components/common';
import './Auth.css';

const loginSchema = z.object({
  email: z.string().min(1, 'Email is required').email('Invalid email address'),
  password: z.string().min(1, 'Password is required'),
});

type LoginFields = z.infer<typeof loginSchema>;

export const LoginPage: React.FC = () => {
  const [searchParams] = useSearchParams();
  const redirectTo = searchParams.get('redirectTo');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const { login } = useAuth();
  const navigate = useNavigate();

  const {
    register: registerField,
    handleSubmit,
    formState: { errors },
  } = useForm<LoginFields>({
    resolver: zodResolver(loginSchema),
    defaultValues: {
      email: '',
      password: '',
    },
  });

  const scrollToErrorBanner = () => {
    setTimeout(() => {
      const banner = document.querySelector('.auth-error-banner');
      if (banner) {
        banner.scrollIntoView({ behavior: 'smooth', block: 'center' });
      }
    }, 50);
  };

  const onSubmit = async (data: LoginFields) => {
    setError('');
    setLoading(true);

    try {
      await login(data.email, data.password);
      navigate(redirectTo || '/');
    } catch (err: unknown) {
      const axiosError = err as {
        response?: {
          data?: {
            message?: string;
          };
        };
        message?: string;
      };
      const serverMessage = axiosError.response?.data?.message || axiosError.message || 'Login failed. Please check your credentials.';
      setError(serverMessage);
      scrollToErrorBanner();
    } finally {
      setLoading(false);
    }
  };

  const onError = (formErrors: Record<string, unknown>) => {
    const errorKeys = Object.keys(formErrors);
    if (errorKeys.length > 0) {
      const firstKey = errorKeys[0];
      const element = document.getElementsByName(firstKey)[0] || document.getElementById(firstKey) || document.querySelector(`[name="${firstKey}"]`);
      if (element) {
        const wrapper = element.closest('.input-wrapper') || element;
        wrapper.scrollIntoView({ behavior: 'smooth', block: 'center' });
        (element as HTMLElement).focus?.();
      }
    }
  };

  return (
    <div className="auth-page">
      <div className="auth-container">
        <Card className="auth-card">
          <div className="auth-header">
            <h1 className="auth-title">Welcome back</h1>
            <p className="auth-subtitle">Sign in to continue your journey</p>
          </div>

          <form onSubmit={handleSubmit(onSubmit, onError)} className="auth-form" noValidate>
            {error && (
              <div className="auth-error-banner">
                <span className="auth-error-message-text">{error}</span>
                <button
                  type="button"
                  className="auth-error-close"
                  onClick={() => setError('')}
                  aria-label="Close error message"
                >
                  <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" strokeWidth="2.5" fill="none">
                    <line x1="18" y1="6" x2="6" y2="18" />
                    <line x1="6" y1="6" x2="18" y2="18" />
                  </svg>
                </button>
              </div>
            )}

            <Input
              id="email"
              label="Email"
              type="email"
              placeholder="your@email.com"
              autoComplete="email"
              error={errors.email?.message}
              {...registerField('email')}
            />

            <Input
              id="password"
              label="Password"
              type="password"
              placeholder="••••••••"
              autoComplete="current-password"
              error={errors.password?.message}
              {...registerField('password')}
            />

            <Button
              type="submit"
              variant="primary"
              size="lg"
              fullWidth
              loading={loading}
            >
              Sign In
            </Button>
          </form>

          <div className="auth-footer">
            <p>
              Don't have an account?{' '}
              <Link to={redirectTo ? `/register?redirectTo=${encodeURIComponent(redirectTo)}` : '/register'} className="auth-link">Sign up</Link>
            </p>
          </div>
        </Card>

        <div className="auth-decoration">
          <div className="decoration-circle decoration-circle-1" />
          <div className="decoration-circle decoration-circle-2" />
          <div className="decoration-circle decoration-circle-3" />
        </div>
      </div>
    </div>
  );
};

export default LoginPage;
