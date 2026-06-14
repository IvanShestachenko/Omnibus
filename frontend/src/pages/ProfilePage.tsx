import React, { useState, useEffect, useRef } from 'react';
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';
import { useAuth } from '../context/AuthContext';
import { usersApi } from '../api/users';
import { Button, Input } from '../components/common';
import { detectCountryFromBrowser, SUPPORTED_COUNTRIES } from '../utils/geolocation';
import './ProfilePage.css';

const profileSchema = z.object({
  firstName: z.string().min(2, 'First name must be at least 2 characters'),
  lastName: z.string().min(2, 'Last name must be at least 2 characters'),
  phone: z.string().nullable().optional().refine((val) => !val || /^\+?[1-9]\d{1,14}$/.test(val), {
    message: 'Invalid phone format (must be international, e.g. +1234567890)',
  }),
  country: z.string().nullable().optional(),
  avatarData: z.string().nullable().optional(),
});

type ProfileFields = z.infer<typeof profileSchema>;

// Common search aliases for supported countries to improve autocomplete/search experience
const COUNTRY_ALIASES: Record<string, string[]> = {
  'United Kingdom': ['Great Britain', 'UK', 'GB', 'England', 'Britain'],
  'Germany': ['Deutschland', 'DE'],
  'Czech Republic': ['Czechia', 'CZ', 'Czech'],
};

const matchesQuery = (country: string, query: string): boolean => {
  const q = query.toLowerCase();
  const cName = country.toLowerCase();
  if (cName.includes(q)) return true;
  
  const aliases = COUNTRY_ALIASES[country];
  if (aliases) {
    return aliases.some(alias => alias.toLowerCase().startsWith(q));
  }
  return false;
};

const startsWithQuery = (country: string, query: string): boolean => {
  const q = query.toLowerCase();
  const cName = country.toLowerCase();
  if (cName.startsWith(q)) return true;
  
  const aliases = COUNTRY_ALIASES[country];
  if (aliases) {
    return aliases.some(alias => alias.toLowerCase().startsWith(q));
  }
  return false;
};

export const ProfilePage: React.FC = () => {
  const { user, updateUser } = useAuth();
  const [isEditMode, setIsEditMode] = useState(false);
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');
  const [showToast, setShowToast] = useState(false);
  const [loading, setLoading] = useState(false);
  const [avatarPreview, setAvatarPreview] = useState<string | null>(null);

  // Country dropdown state
  const [isCountryDropdownOpen, setIsCountryDropdownOpen] = useState(false);
  const [countrySearch, setCountrySearch] = useState('');
  const countryDropdownRef = useRef<HTMLDivElement>(null);

  // Geolocation detection states
  const [isDetectingCountry, setIsDetectingCountry] = useState(false);
  const [detectedCountryName, setDetectedCountryName] = useState<string | null>(null);
  const [geoError, setGeoError] = useState<string | null>(null);

  const {
    register,
    handleSubmit,
    setValue,
    watch,
    reset,
    formState: { errors },
  } = useForm<ProfileFields>({
    resolver: zodResolver(profileSchema),
  });

  // Handle success toast timeout (visible for 4 seconds, then slides out)
  useEffect(() => {
    if (showToast) {
      const timer = setTimeout(() => {
        setShowToast(false);
      }, 4000);
      return () => clearTimeout(timer);
    }
  }, [showToast]);

  const selectedCountry = watch('country');

  const handleDetectCountry = async () => {
    setIsDetectingCountry(true);
    setDetectedCountryName(null);
    setGeoError(null);
    try {
      const country = await detectCountryFromBrowser();
      setDetectedCountryName(country);
      if (SUPPORTED_COUNTRIES.includes(country)) {
        setValue('country', country, { shouldDirty: true });
      } else {
        setValue('country', 'not_in_list', { shouldDirty: true });
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

  // Load user data on mount/mode toggle
  useEffect(() => {
    if (user) {
      reset({
        firstName: user.firstName,
        lastName: user.lastName,
        phone: user.phone || '',
        country: user.country || '',
        avatarData: user.avatarData || '',
      });
      setAvatarPreview(user.avatarData || null);
    }
  }, [user, isEditMode, reset]);

  // Click outside for country dropdown
  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (countryDropdownRef.current && !countryDropdownRef.current.contains(e.target as Node)) {
        setIsCountryDropdownOpen(false);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  // Reset search term when dropdown is closed
  useEffect(() => {
    if (!isCountryDropdownOpen) {
      setCountrySearch('');
    }
  }, [isCountryDropdownOpen]);

  const processFile = (file: File) => {
    if (!file.type.startsWith('image/')) {
      setError('Please select an image file.');
      return;
    }

    const reader = new FileReader();
    reader.onload = (event) => {
      const img = new Image();
      img.onload = () => {
        const canvas = document.createElement('canvas');
        let width = img.width;
        let height = img.height;

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
          setValue('avatarData', base64, { shouldDirty: true });
          setAvatarPreview(base64);
        }
      };
      img.src = event.target?.result as string;
    };
    reader.readAsDataURL(file);
  };

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files[0]) {
      processFile(e.target.files[0]);
    }
  };

  const deleteAvatar = () => {
    setValue('avatarData', '', { shouldDirty: true });
    setAvatarPreview(null);
  };

  const handleCountrySelect = (country: string) => {
    setValue('country', country, { shouldDirty: true });
    setIsCountryDropdownOpen(false);
    setCountrySearch('');
  };

  const onSubmit = async (data: ProfileFields) => {
    if (!user) return;
    setError('');
    setSuccess('');

    const finalCountry = (data.country === 'not_in_list' || !data.country) ? null : data.country;
    const originalCountry = user.country || null;
    const finalPhone = data.phone || null;
    const originalPhone = user.phone || null;
    const finalAvatar = data.avatarData || null;
    const originalAvatar = user.avatarData || null;

    const hasChanges =
      data.firstName !== user.firstName ||
      data.lastName !== user.lastName ||
      finalPhone !== originalPhone ||
      finalCountry !== originalCountry ||
      finalAvatar !== originalAvatar;

    // If no actual changes were made, simply close edit mode and do not update or show toast
    if (!hasChanges) {
      setIsEditMode(false);
      return;
    }

    setLoading(true);

    try {
      let preferredCurrency = user.preferredCurrency || 'EUR';
      if (finalCountry === 'Ukraine') {
        preferredCurrency = 'UAH';
      } else if (finalCountry === 'Czech Republic') {
        preferredCurrency = 'CZK';
      } else if (finalCountry === 'United Kingdom') {
        preferredCurrency = 'GBP';
      } else if (finalCountry) {
        preferredCurrency = 'EUR';
      }

      const updatedUser = await usersApi.updateUser(user.id, {
        firstName: data.firstName,
        lastName: data.lastName,
        phone: finalPhone,
        preferredCurrency,
        country: finalCountry,
        avatarData: finalAvatar,
      });

      updateUser({
        ...user,
        firstName: updatedUser.firstName,
        lastName: updatedUser.lastName,
        phone: updatedUser.phone || undefined,
        preferredCurrency: updatedUser.preferredCurrency,
        country: updatedUser.country || undefined,
        avatarData: updatedUser.avatarData || undefined,
      });

      setSuccess('Profile updated successfully!');
      setShowToast(true);
      setIsEditMode(false);
    } catch (err: unknown) {
      if (err instanceof Error) {
        setError(err.message || 'Failed to update profile.');
      } else {
        setError('Failed to update profile.');
      }
    } finally {
      setLoading(false);
    }
  };

  const getUserInitials = () => {
    if (!user) return '?';
    const first = user.firstName ? user.firstName[0] : '';
    const last = user.lastName ? user.lastName[0] : '';
    return (first + last).toUpperCase() || user.email[0].toUpperCase();
  };

  const filteredCountries = SUPPORTED_COUNTRIES.filter(c =>
    matchesQuery(c, countrySearch)
  ).sort((a, b) => {
    const aStarts = startsWithQuery(a, countrySearch);
    const bStarts = startsWithQuery(b, countrySearch);
    
    if (aStarts && !bStarts) return -1;
    if (!aStarts && bStarts) return 1;
    
    // Fallback to alphabetical order
    return a.localeCompare(b);
  });

  return (
    <div className="dashboard-page">
      <div className="profile-container">
        <div className="profile-neobrutalist-card">
          <div className="profile-card-header">
            <div className="profile-header-title-row">
              <span className="profile-sheet-title">MY PROFILE</span>
              
              <div className="profile-header-actions">
                {!isEditMode ? (
                  <button
                    type="button"
                    className="profile-edit-header-btn"
                    onClick={() => {
                      setIsEditMode(true);
                      setShowToast(false);
                    }}
                    title="Edit Profile"
                  >
                    <svg viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" strokeWidth="2.5" fill="none" strokeLinecap="round" strokeLinejoin="round">
                      <path d="M12 20h9" />
                      <path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z" />
                    </svg>
                    <span>Edit</span>
                  </button>
                ) : (
                  <div className="profile-header-edit-actions">
                    <button
                      type="button"
                      className="profile-header-cancel-btn"
                      onClick={() => setIsEditMode(false)}
                      disabled={loading}
                    >
                      Cancel
                    </button>
                    <button
                      type="submit"
                      form="profile-edit-form"
                      className="profile-header-save-btn"
                      disabled={loading}
                    >
                      {loading ? 'Saving...' : 'Save'}
                    </button>
                  </div>
                )}
              </div>
            </div>
            <div className="profile-divider-line" />
          </div>

          <div className="profile-body-layout">
            <div className="profile-left-column">
              <div className="profile-avatar-wrapper">
                <div className="profile-avatar-circle">
                  {avatarPreview ? (
                    <img src={avatarPreview} alt="Avatar" className="profile-avatar-img" />
                  ) : (
                    <span className="profile-avatar-initials">{getUserInitials()}</span>
                  )}
                </div>

                {isEditMode && (
                  <div className="profile-avatar-actions">
                    <button
                      type="button"
                      className="avatar-action-btn upload"
                      onClick={() => document.getElementById('profile-avatar-input')?.click()}
                    >
                      Change
                    </button>
                    {avatarPreview && (
                      <button
                        type="button"
                        className="avatar-action-btn delete"
                        onClick={deleteAvatar}
                      >
                        Delete
                      </button>
                    )}
                    <input
                      id="profile-avatar-input"
                      type="file"
                      accept="image/*"
                      onChange={handleFileChange}
                      style={{ display: 'none' }}
                    />
                  </div>
                )}
              </div>

              <div className="profile-title-details">
                <h2>{user?.firstName} {user?.lastName}</h2>
                <p className="profile-email-sub">{user?.email}</p>
                <span className="profile-role-badge">
                  {user?.role?.toLowerCase() === 'user' ? 'passenger' : user?.role}
                </span>
              </div>
            </div>

            <div className="profile-right-column">
              {error && <div className="profile-error">{error}</div>}

              <form id="profile-edit-form" onSubmit={handleSubmit(onSubmit)} className="profile-form" noValidate>
                <div className="profile-grid">
                  <div className="form-group">
                    <Input
                      id="profile-first-name"
                      label="First Name"
                      autoComplete="given-name"
                      disabled={!isEditMode}
                      error={errors.firstName?.message}
                      {...register('firstName')}
                    />
                  </div>

                  <div className="form-group">
                    <Input
                      id="profile-last-name"
                      label="Last Name"
                      autoComplete="family-name"
                      disabled={!isEditMode}
                      error={errors.lastName?.message}
                      {...register('lastName')}
                    />
                  </div>

                  <div className="form-group">
                    <Input
                      id="profile-email"
                      label="Email Address"
                      type="email"
                      autoComplete="email"
                      value={user?.email || ''}
                      disabled
                    />
                    <span className="field-hint">Email cannot be changed.</span>
                  </div>

                  <div className="form-group">
                    <label htmlFor="profile-phone" className="input-label">Phone Number</label>
                    {!isEditMode ? (
                      <div className="phone-read-only-box">
                        {user?.phone || 'Not specified'}
                      </div>
                    ) : (
                      <>
                        <Input
                          id="profile-phone"
                          autoComplete="tel"
                          placeholder="e.g. +420 123 456 789"
                          error={errors.phone?.message}
                          {...register('phone')}
                        />
                        <span className="field-hint" style={{ marginTop: '2px' }}>
                          Optional – will be used as a backup contact method for notifications.
                        </span>
                      </>
                    )}
                  </div>

                  <div className="form-group" ref={countryDropdownRef}>
                    <label className="input-label">Country</label>
                    {isEditMode ? (
                      <div className="country-select-wrapper-with-detect" style={{ display: 'flex', gap: '10px' }}>
                        <div className="country-dropdown-wrapper" style={{ flex: 1 }}>
                          <button
                            type="button"
                            className="country-select-trigger"
                            onClick={() => setIsCountryDropdownOpen(prev => !prev)}
                          >
                            <span>
                              {selectedCountry === 'not_in_list'
                                ? 'Country is not in the list'
                                : (selectedCountry || 'Not specified')}
                            </span>
                            <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" strokeWidth="2.5" fill="none">
                              <polyline points="6 9 12 15 18 9" />
                            </svg>
                          </button>

                          {isCountryDropdownOpen && (
                            <div className="country-select-dropdown">
                              <div className="country-search-box">
                                <input
                                  id="country-search-input"
                                  name="countrySearch"
                                  type="text"
                                  placeholder="Search country..."
                                  autoComplete="off"
                                  value={countrySearch}
                                  onChange={(e) => setCountrySearch(e.target.value)}
                                  onClick={(e) => e.stopPropagation()}
                                  className="country-search-input"
                                  aria-label="Search country"
                                />
                              </div>
                              <div className="country-options-list">
                                <button
                                  type="button"
                                  className={`country-option-item ${!selectedCountry ? 'selected' : ''}`}
                                  onClick={() => handleCountrySelect('')}
                                >
                                  Not specified
                                </button>
                                {filteredCountries.length > 0 ? (
                                  filteredCountries.map((c) => (
                                    <button
                                      key={c}
                                      type="button"
                                      className={`country-option-item ${c === selectedCountry ? 'selected' : ''}`}
                                      onClick={() => handleCountrySelect(c)}
                                    >
                                      {c}
                                    </button>
                                  ))
                                ) : (
                                  <span className="no-countries-found">No countries found</span>
                                )}
                                <button
                                  type="button"
                                  className={`country-option-item ${selectedCountry === 'not_in_list' ? 'selected' : ''}`}
                                  onClick={() => handleCountrySelect('not_in_list')}
                                  style={{ borderTop: '1px solid var(--border-default)', marginTop: '4px', paddingTop: '8px' }}
                                >
                                  Country is not in the list
                                </button>
                              </div>
                            </div>
                          )}
                        </div>

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
                    ) : (
                      <div className="country-read-only-box">
                        {(!user?.country || user.country === 'not_in_list') ? 'Not specified' : user.country}
                      </div>
                    )}
                    {isEditMode && (
                      <>
                        <span className="field-hint" style={{ marginTop: '2px' }}>
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
                      </>
                    )}
                  </div>
                </div>

                  {/* Footer actions removed since they are moved to the card header */}
              </form>
            </div>
          </div>
        </div>
      </div>

      {/* Success Toast Notification */}
      <div 
        className={`toast-notification ${showToast ? 'show' : ''}`}
        onClick={() => setShowToast(false)}
      >
        <div className="toast-icon">
          <svg viewBox="0 0 24 24" width="22" height="22" stroke="var(--success)" strokeWidth="2.5" fill="none" strokeLinecap="round" strokeLinejoin="round">
            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" />
            <polyline points="22 4 12 14.01 9 11.01" />
          </svg>
        </div>
        <span className="toast-message">{success}</span>
      </div>
    </div>
  );
};

export default ProfilePage;
