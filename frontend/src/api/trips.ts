import api from './client';

export interface TripResponse {
  id: number;
  routeId: number;
  routeName: string;
  busRegistrationNumber: string;
  busName: string;
  seatLayout: string;
  originTerminalName: string;
  destinationTerminalName: string;
  departureDatetime: string;
  arrivalDatetime: string;
  price: number;
  status: string;
  driverName: string | null;
  availableSeats: string[];
  occupiedSeats: string[];
}

export interface SearchTripsParams {
  fromCity?: string;
  fromTerminalId?: number | null;
  toCity?: string;
  toTerminalId?: number | null;
  date: string; // YYYY-MM-DD format
  passengers: number;
}

export const tripsApi = {
  search: async (params: SearchTripsParams): Promise<TripResponse[]> => {
    const response = await api.get<TripResponse[]>('/trips/search', { params });
    return response.data;
  },

  getById: async (
    id: number,
    params?: {
      fromTerminalId?: number | null;
      fromCity?: string;
      toTerminalId?: number | null;
      toCity?: string;
    }
  ): Promise<TripResponse> => {
    const response = await api.get<TripResponse>(`/trips/${id}`, { params });
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
