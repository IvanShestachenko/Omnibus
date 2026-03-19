import api from './client';

export interface RouteResponse {
  id: number;
  name: string;
  description: string;
  stops: RouteStopResponse[];
}

export interface RouteStopResponse {
  id: number;
  terminalId: number;
  terminalName: string;
  stopOrder: number;
  distanceFromStart: number;
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
};

export default routesApi;
