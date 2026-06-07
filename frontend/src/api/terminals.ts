import api from './client';

export interface TerminalResponse {
  id: number;
  name: string;
  city: string;
  country: string;
}

export const terminalsApi = {
  getAll: async (): Promise<TerminalResponse[]> => {
    const response = await api.get<TerminalResponse[]>('/terminals');
    return response.data;
  }
};

export default terminalsApi;

