import api from './client';

export interface TripResponse {
  id: number;
  routeId: number;
  routeName: string;
  busRegistrationNumber: string;
  departureDatetime: string;
  arrivalDatetime: string;
  price: number;
  status: string;
  driverName: string | null;
}

export interface SearchTripsParams {
  routeId: number;
  date: string; // YYYY-MM-DD format
}

export const tripsApi = {
  search: async (params: SearchTripsParams): Promise<TripResponse[]> => {
    const response = await api.get<TripResponse[]>('/trips/search', { params });
    return response.data;
  },

  getById: async (id: number): Promise<TripResponse> => {
    const response = await api.get<TripResponse>(`/trips/${id}`);
    return response.data;
  },

  getAvailableSeats: async (id: number): Promise<number> => {
    const response = await api.get<number>(`/trips/${id}/available-seats`);
    return response.data;
  },

  getAll: async (): Promise<TripResponse[]> => {
    const response = await api.get<TripResponse[]>('/trips');
    return response.data;
  },
};

export default tripsApi;
