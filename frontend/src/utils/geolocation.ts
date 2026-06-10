export const SUPPORTED_COUNTRIES = [
  'Austria',
  'Belgium',
  'Bulgaria',
  'Croatia',
  'Czech Republic',
  'Denmark',
  'Estonia',
  'Finland',
  'France',
  'Germany',
  'Hungary',
  'Italy',
  'Latvia',
  'Lithuania',
  'Netherlands',
  'Norway',
  'Poland',
  'Portugal',
  'Romania',
  'Slovakia',
  'Slovenia',
  'Spain',
  'Sweden',
  'Switzerland',
  'Ukraine',
  'United Kingdom'
];

export const detectCountryFromBrowser = (): Promise<string> => {
  return new Promise((resolve, reject) => {
    if (!navigator.geolocation) {
      reject(new Error('UNSUPPORTED'));
      return;
    }

    navigator.geolocation.getCurrentPosition(
      async (position) => {
        try {
          const { latitude, longitude } = position.coords;
          const url = `https://nominatim.openstreetmap.org/reverse?format=json&lat=${latitude}&lon=${longitude}&zoom=3`;
          
          const response = await fetch(url, {
            headers: {
              'Accept-Language': 'en', // Ask for English country names
              'User-Agent': 'OmnibusTravelApp/1.0 (contact: omnibus@example.com)'
            },
          });

          if (response.ok) {
            const data = await response.json();
            let country = data.address?.country || null;
            
            if (country) {
              // Normalize common country name variations
              if (country === 'Czechia') {
                country = 'Czech Republic';
              } else if (country.includes('United Kingdom')) {
                country = 'United Kingdom';
              }
              resolve(country);
            } else {
              reject(new Error('GEOLOCATION_FAILED'));
            }
          } else {
            reject(new Error('NOMINATIM_FAILED'));
          }
        } catch (err) {
          console.error('Reverse geocoding failed', err);
          reject(new Error('GEOLOCATION_FAILED'));
        }
      },
      (error) => {
        console.warn('Geolocation query failed or denied by user', error);
        if (error.code === error.TIMEOUT) {
          reject(new Error('TIMEOUT'));
        } else if (error.code === error.PERMISSION_DENIED) {
          reject(new Error('PERMISSION_DENIED'));
        } else {
          reject(new Error('GEOLOCATION_FAILED'));
        }
      },
      { 
        timeout: 10000,
        maximumAge: 60000,       // Allow cache up to 60s
        enableHighAccuracy: false // Fast & robust on desktop/laptop
      }
    );
  });
};
