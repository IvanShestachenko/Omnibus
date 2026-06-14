import React, { useState } from 'react';
import { Link, useNavigate, useSearchParams } from 'react-router-dom';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { useAuth } from '../context/AuthContext';
import { Button, Input, Card } from '../components/common';
import { detectCountryFromBrowser, SUPPORTED_COUNTRIES } from '../utils/geolocation';
import './Auth.css';

const registerSchema = z.object({
  firstName: z.string().min(2, 'First name must be at least 2 characters'),
  lastName: z.string().min(2, 'Last name must be at least 2 characters'),
  email: z.string().min(1, 'Email is required').email('Invalid email address'),
  phone: z.string().optional().refine((val) => !val || /^\+?[1-9]\d{1,14}$/.test(val), {
    message: 'Invalid phone format (must be international, e.g. +1234567890)',
  }),
  password: z.string()
    .min(8, 'Password must be at least 8 characters')
    .regex(/[a-z]/, 'Password must contain at least one lowercase letter')
    .regex(/[A-Z]/, 'Password must contain at least one uppercase letter')
    .regex(/[0-9]/, 'Password must contain at least one number')
    .regex(/[^A-Za-z0-9]/, 'Password must contain at least one special character'),
  confirmPassword: z.string().min(1, 'Please confirm your password'),
  country: z.string().optional(),
  avatarData: z.string().optional(),
}).refine((data) => data.password === data.confirmPassword, {
  message: 'Passwords do not match',
  path: ['confirmPassword'],
});

type RegisterFields = z.infer<typeof registerSchema>;

export const RegisterPage: React.FC = () => {
  const [searchParams] = useSearchParams();
  const redirectTo = searchParams.get('redirectTo');
  const [globalError, setGlobalError] = useState<string | null>(null);
  const [avatarError, setAvatarError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);
  const [avatarPreview, setAvatarPreview] = useState<string | null>(null);
  const [isDragActive, setIsDragActive] = useState(false);

  // Geolocation detection states
  const [isDetectingCountry, setIsDetectingCountry] = useState(false);
  const [detectedCountryName, setDetectedCountryName] = useState<string | null>(null);
  const [geoError, setGeoError] = useState<string | null>(null);

  const { register: registerUser } = useAuth();
  const navigate = useNavigate();

  const {
    register: registerField,
    handleSubmit,
    setValue,
    watch,
    setError,
    formState: { errors },
  } = useForm<RegisterFields>({
    resolver: zodResolver(registerSchema),
    defaultValues: {
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      password: '',
      confirmPassword: '',
      country: '',
      avatarData: '',
    },
  });

  const passwordVal = watch('password') || '';

  // Determine which conditions are met for the dynamic strength meter
  const checklist = {
    length: passwordVal.length >= 8,
    uppercase: /[A-Z]/.test(passwordVal),
    lowercase: /[a-z]/.test(passwordVal),
    number: /[0-9]/.test(passwordVal),
    special: /[^A-Za-z0-9]/.test(passwordVal),
  };

  const score = Object.values(checklist).filter(Boolean).length;

  const scrollToErrorBanner = () => {
    setTimeout(() => {
      const banner = document.querySelector('.auth-error-banner');
      if (banner) {
        banner.scrollIntoView({ behavior: 'smooth', block: 'center' });
      }
    }, 50);
  };

  const handleDetectCountry = async () => {
    setIsDetectingCountry(true);
    setDetectedCountryName(null);
    setGeoError(null);
    try {
      const country = await detectCountryFromBrowser();
      setDetectedCountryName(country);
      if (SUPPORTED_COUNTRIES.includes(country)) {
        setValue('country', country);
      } else {
        setValue('country', 'not_in_list');
      }
    } catch (err) {
      const error = err as Error;
      if (error.message === 'TIMEOUT') {
        setGeoError('Location request timed out. Please try again.');
      } else if (error.message === 'PERMISSION_DENIED') {
        setGeoError('Location access denied. Please enable location permissions in browser settings.');
      } else {
        setGeoError('Could not detect location. Please select manually.');
      }
    } finally {
      setIsDetectingCountry(false);
    }
  };

  const processFile = (file: File) => {
    setAvatarError(null);
    if (!file.type.startsWith('image/')) {
      setAvatarError('Please select an image file.');
      return;
    }

    const reader = new FileReader();
    reader.onload = (event) => {
      const img = new Image();
      img.onload = () => {
        const canvas = document.createElement('canvas');
        let width = img.width;
        let height = img.height;

        // Downscale to max 200x200
        const MAX_SIZE = 200;
        if (width > height) {
          if (width > MAX_SIZE) {
            height = Math.round((height * MAX_SIZE) / width);
            width = MAX_SIZE;
          }
        } else {
          if (height > MAX_SIZE) {
            width = Math.round((width * MAX_SIZE) / height);
            height = MAX_SIZE;
          }
        }

        canvas.width = width;
        canvas.height = height;

        const ctx = canvas.getContext('2d');
        if (ctx) {
          ctx.drawImage(img, 0, 0, width, height);
          const base64 = canvas.toDataURL('image/jpeg', 0.85);
          setValue('avatarData', base64);
          setAvatarPreview(base64);
        }
      };
      img.src = event.target?.result as string;
    };
    reader.readAsDataURL(file);
  };

  const handleDrag = (e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    if (e.type === 'dragenter' || e.type === 'dragover') {
      setIsDragActive(true);
    } else if (e.type === 'dragleave') {
      setIsDragActive(false);
    }
  };

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    e.stopPropagation();
    setIsDragActive(false);

    if (e.dataTransfer.files && e.dataTransfer.files[0]) {
      processFile(e.dataTransfer.files[0]);
    }
  };

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      processFile(e.target.files[0]);
    }
  };

  const removeAvatar = (e: React.MouseEvent) => {
    e.preventDefault();
    e.stopPropagation();
    setValue('avatarData', '');
    setAvatarPreview(null);
    setAvatarError(null);
  };

  const onSubmit = async (data: RegisterFields) => {
    setGlobalError(null);
    setLoading(true);

    try {
      // Map currency automatically based on country selection
      let preferredCurrency = 'EUR';
      if (data.country === 'Ukraine') {
        preferredCurrency = 'UAH';
      } else if (data.country === 'Czech Republic') {
        preferredCurrency = 'CZK';
      } else if (data.country === 'United Kingdom') {
        preferredCurrency = 'GBP';
      }

      await registerUser(
        data.email,
        data.password,
        data.firstName,
        data.lastName,
        data.phone || undefined,
        preferredCurrency,
        data.country || undefined,
        data.avatarData || undefined
      );
      // Mark login history
      localStorage.setItem('has_previously_logged_in', 'true');
      navigate(redirectTo || '/');
    } catch (err: unknown) {
      const axiosError = err as {
        response?: {
          data?: {
            message?: string;
            fieldErrors?: Record<string, string>;
          };
        };
        message?: string;
      };

      let errorMessage = 'Registration failed. Please try again.';
      if (axiosError.response?.data?.fieldErrors) {
        const fieldErrors = axiosError.response.data.fieldErrors;
        Object.entries(fieldErrors).forEach(([key, value]) => {
          setError(key as keyof RegisterFields, {
            type: 'server',
            message: value as string,
          });
        });
        errorMessage = 'Please fix the errors below.';
      } else {
        errorMessage = axiosError.response?.data?.message || axiosError.message || 'Registration failed. Please try again.';
        if (errorMessage.toLowerCase().includes('email')) {
          setError('email', {
            type: 'server',
            message: errorMessage,
          });
        }
      }
      setGlobalError(errorMessage);
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
            <h1 className="auth-title">Create account</h1>
            <p className="auth-subtitle">Start your journey with us</p>
          </div>

          <form onSubmit={handleSubmit(onSubmit, onError)} className="auth-form" noValidate>
            {globalError && (
              <div className="auth-error-banner">
                <span className="auth-error-message-text">{globalError}</span>
                <button
                  type="button"
                  className="auth-error-close"
                  onClick={() => setGlobalError(null)}
                  aria-label="Close error message"
                >
                  <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" strokeWidth="2.5" fill="none">
                    <line x1="18" y1="6" x2="6" y2="18" />
                    <line x1="6" y1="6" x2="18" y2="18" />
                  </svg>
                </button>
              </div>
            )}

            {/* Drag & Drop Avatar Zone */}
            <div className="avatar-uploader-container">
              <div
                className={`avatar-dropzone-rect ${isDragActive ? 'drag-active' : ''}`}
                onDragEnter={handleDrag}
                onDragOver={handleDrag}
                onDragLeave={handleDrag}
                onDrop={handleDrop}
                onClick={() => document.getElementById('avatar-input')?.click()}
              >
                {avatarPreview ? (
                  <div className="avatar-preview-rect-container">
                    <img src={avatarPreview} alt="Avatar Preview" className="avatar-preview-rect-img" />
                    <button type="button" className="avatar-remove-btn" onClick={removeAvatar}>
                      <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" strokeWidth="2.5" fill="none">
                        <line x1="18" y1="6" x2="6" y2="18" />
                        <line x1="6" y1="6" x2="18" y2="18" />
                      </svg>
                    </button>
                  </div>
                ) : (
                  <div className="avatar-dropzone-rect-inner">
                    <svg viewBox="0 0 24 24" width="26" height="26" stroke="currentColor" strokeWidth="2" fill="none" className="upload-icon">
                      <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4" />
                      <polyline points="17 8 12 3 7 8" />
                      <line x1="12" y1="3" x2="12" y2="15" />
                    </svg>
                    <span>Drag & drop avatar or click to upload</span>
                  </div>
                )}
              </div>
              <input
                id="avatar-input"
                type="file"
                accept="image/*"
                onChange={handleFileChange}
                style={{ display: 'none' }}
              />
              <span className="field-optional-sublabel" style={{ display: 'block', fontSize: 'var(--text-xs)', color: 'var(--text-muted)', marginTop: '8px', textAlign: 'center' }}>
                Optional – you can skip this step.
              </span>
              {avatarError && <span className="input-error-message">{avatarError}</span>}
            </div>

            <div className="auth-row">
              <Input
                id="firstName"
                label="First Name"
                placeholder="John"
                autoComplete="given-name"
                autoFocus
                error={errors.firstName?.message}
                {...registerField('firstName')}
              />
              <Input
                id="lastName"
                label="Last Name"
                placeholder="Doe"
                autoComplete="family-name"
                error={errors.lastName?.message}
                {...registerField('lastName')}
              />
            </div>

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
              id="phone"
              label="Phone Number"
              placeholder="e.g. +420123456789"
              autoComplete="tel"
              error={errors.phone?.message}
              {...registerField('phone')}
            />
            <span className="field-optional-sublabel" style={{ display: 'block', fontSize: 'var(--text-xs)', color: 'var(--text-muted)', marginTop: '-8px', marginBottom: '16px' }}>
              Optional – will be used as a backup contact method for notifications.
            </span>

            {/* Country Dropdown with Geolocation Detection */}
            <div className="input-wrapper">
              <label htmlFor="country-select" className="input-label">
                From which country will you be using our services?
              </label>
              <div className="country-select-container" style={{ display: 'flex', gap: '10px' }}>
                <select
                  id="country-select"
                  className="input"
                  style={{ flex: 1 }}
                  autoComplete="country-name"
                  {...registerField('country')}
                >
                  <option value="">Not specified</option>
                  {SUPPORTED_COUNTRIES.map((c) => (
                    <option key={c} value={c}>
                      {c}
                    </option>
                  ))}
                  <option value="not_in_list">Country is not in the list</option>
                </select>
                <Button
                  type="button"
                  variant="ghost"
                  onClick={handleDetectCountry}
                  loading={isDetectingCountry}
                  style={{ display: 'flex', alignItems: 'center', gap: '5px', padding: '0 15px', border: '1px solid var(--border-default)', borderRadius: 'var(--radius-md)', height: '44px' }}
                >
                  <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" strokeWidth="2.5" fill="none">
                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" />
                    <circle cx="12" cy="10" r="3" />
                  </svg>
                  Detect
                </Button>
              </div>
              <span className="field-optional-sublabel" style={{ display: 'block', fontSize: 'var(--text-xs)', color: 'var(--text-muted)', marginTop: '4px' }}>
                Optional – helps us suggest the best travel offers near you and sets default currency.
              </span>
              {detectedCountryName && !SUPPORTED_COUNTRIES.includes(detectedCountryName) && (
                <span className="detected-country-warning" style={{ display: 'block', fontSize: 'var(--text-xs)', color: 'var(--accent)', marginTop: '4px', fontWeight: 'bold' }}>
                  Detected location: {detectedCountryName} (outside our route coverage area)
                </span>
              )}
              {geoError && (
                <span className="geo-detection-error" style={{ display: 'block', fontSize: 'var(--text-xs)', color: 'var(--error)', marginTop: '4px' }}>
                  {geoError}
                </span>
              )}
            </div>

            <div>
              <Input
                id="password"
                label="Password"
                type="password"
                placeholder="••••••••"
                autoComplete="new-password"
                error={errors.password?.message}
                {...registerField('password')}
              />

              {/* Password Requirements Checklist */}
              {passwordVal && (
                <div className="password-checklist">
                  <div className="checklist-title">Password requirements:</div>
                  <div className={`checklist-item ${checklist.length ? 'valid' : ''}`}>
                    <span className="checklist-icon">
                      {checklist.length ? (
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3">
                          <polyline points="20 6 9 17 4 12" />
                        </svg>
                      ) : (
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3">
                          <circle cx="12" cy="12" r="10" />
                        </svg>
                      )}
                    </span>
                    <span>At least 8 characters</span>
                  </div>
                  <div className={`checklist-item ${checklist.uppercase ? 'valid' : ''}`}>
                    <span className="checklist-icon">
                      {checklist.uppercase ? (
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3">
                          <polyline points="20 6 9 17 4 12" />
                        </svg>
                      ) : (
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3">
                          <circle cx="12" cy="12" r="10" />
                        </svg>
                      )}
                    </span>
                    <span>At least one uppercase letter (A-Z)</span>
                  </div>
                  <div className={`checklist-item ${checklist.lowercase ? 'valid' : ''}`}>
                    <span className="checklist-icon">
                      {checklist.lowercase ? (
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3">
                          <polyline points="20 6 9 17 4 12" />
                        </svg>
                      ) : (
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3">
                          <circle cx="12" cy="12" r="10" />
                        </svg>
                      )}
                    </span>
                    <span>At least one lowercase letter (a-z)</span>
                  </div>
                  <div className={`checklist-item ${checklist.number ? 'valid' : ''}`}>
                    <span className="checklist-icon">
                      {checklist.number ? (
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3">
                          <polyline points="20 6 9 17 4 12" />
                        </svg>
                      ) : (
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3">
                          <circle cx="12" cy="12" r="10" />
                        </svg>
                      )}
                    </span>
                    <span>At least one number (0-9)</span>
                  </div>
                  <div className={`checklist-item ${checklist.special ? 'valid' : ''}`}>
                    <span className="checklist-icon">
                      {checklist.special ? (
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3">
                          <polyline points="20 6 9 17 4 12" />
                        </svg>
                      ) : (
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3">
                          <circle cx="12" cy="12" r="10" />
                        </svg>
                      )}
                    </span>
                    <span>At least one special character (e.g. !@#$)</span>
                  </div>
                </div>
              )}

              {/* Password Strength Visualizer */}
              {passwordVal && (
                <div className="password-strength-container">
                  <div className="password-strength-bar-wrapper">
                    <div className={`password-strength-bar-fill strength-fill-${score}`} />
                  </div>
                  <div className="password-strength-info">
                    <span className="password-strength-score-text">Complexity score: {score}/5</span>
                    <span className={`password-strength-label ${
                      score === 5 ? 'strength-strong-text' :
                      score >= 3 ? 'strength-medium-text' : 'strength-weak-text'
                    }`}>
                      {score === 5 ? 'Strong Password' :
                       score >= 3 ? 'Medium Complexity' : 'Weak Password'}
                    </span>
                  </div>
                </div>
              )}
            </div>

            <Input
              id="confirmPassword"
              label="Confirm Password"
              type="password"
              placeholder="••••••••"
              autoComplete="new-password"
              error={errors.confirmPassword?.message}
              {...registerField('confirmPassword')}
            />

            <Button
              type="submit"
              variant="primary"
              size="lg"
              fullWidth
              loading={loading}
            >
              Create Account
            </Button>
          </form>

          <div className="auth-footer">
            <p>
              Already have an account?{' '}
              <Link to={redirectTo ? `/login?redirectTo=${encodeURIComponent(redirectTo)}` : '/login'} className="auth-link">Sign in</Link>
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

export default RegisterPage;
