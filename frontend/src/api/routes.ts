import api from './client';

export interface RouteResponse {
  id: number;
  name: string;
  isActive: boolean;
  stops: RouteStopResponse[];
}

export interface RouteStopResponse {
  terminalName: string;
  city: string;
  sequenceOrder: number;
  arrivalOffsetMinutes: number;
  departureOffsetMinutes: number;
  distanceFromOrigin: number;
}

export interface TripInfo {
  from: string;
  to: string;
  price: number;
  fromCountry: string;
  toCountry: string;
}

export const routesApi = {
  getAll: async (): Promise<RouteResponse[]> => {
    const response = await api.get<RouteResponse[]>('/routes');
    return response.data;
  },

  getById: async (id: number): Promise<RouteResponse> => {
    const response = await api.get<RouteResponse>(`/routes/${id}`);
    return response.data;
  },

  getPopular: async (country?: string): Promise<TripInfo[]> => {
    const response = await api.get<TripInfo[]>('/routes/popular', {
      params: country ? { country } : undefined
    });
    return response.data;
  },
};

export default routesApi;
