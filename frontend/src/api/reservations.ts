import api from './client';

export interface PassengerSeatRequest {
  firstName: string;
  lastName: string;
  seatNumber: string;
  fromStopOrder: number;
  toStopOrder: number;
}

export interface CreateReservationRequest {
  tripId: number;
  passengers: PassengerSeatRequest[];
}

export interface ReservationResponse {
  id: number;
  bookingReference: string;
  status: string;
  totalAmount: number;
  createdAt: string;
  trip: {
    id: number;
    routeName: string;
    departure: string;
  };
  passengers: {
    firstName: string;
    lastName: string;
    segments: {
      seatNumber: string;
      fromStop: number;
      toStop: number;
    }[];
  }[];
}

export const reservationsApi = {
  create: async (data: CreateReservationRequest): Promise<ReservationResponse> => {
    const response = await api.post<ReservationResponse>('/reservations', data);
    return response.data;
  },

  getMyReservations: async (): Promise<ReservationResponse[]> => {
    const response = await api.get<ReservationResponse[]>('/reservations');
    return response.data;
  },

  getById: async (id: number): Promise<ReservationResponse> => {
    const response = await api.get<ReservationResponse>(`/reservations/${id}`);
    return response.data;
  },

  cancel: async (id: number): Promise<void> => {
    await api.delete(`/reservations/${id}`);
  },

  pay: async (id: number): Promise<void> => {
    await api.post(`/reservations/${id}/pay`);
  },
};

export default reservationsApi;
