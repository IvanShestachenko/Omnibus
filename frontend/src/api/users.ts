import api from './client';

export interface UpdateUserRequest {
  firstName: string;
  lastName: string;
  phone?: string | null;
  preferredCurrency?: string;
  country?: string | null;
  avatarData?: string | null;
}

export interface UserResponse {
  id: number;
  email: string;
  firstName: string;
  lastName: string;
  phone?: string;
  preferredCurrency: string;
  country?: string;
  avatarData?: string;
  role: string;
}

export const usersApi = {
  getCurrentUser: async (): Promise<UserResponse> => {
    const response = await api.get<UserResponse>('/users/me');
    return response.data;
  },

  updateUser: async (id: number, data: UpdateUserRequest): Promise<UserResponse> => {
    const response = await api.put<UserResponse>(`/users/${id}`, data);
    return response.data;
  },
};

export default usersApi;
