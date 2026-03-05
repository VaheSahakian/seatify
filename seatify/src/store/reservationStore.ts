import { create } from 'zustand'
import type { Reservation, CartItem } from '@/types'
import { apiFetch } from '@/lib/api'

interface ReservationState {
  reservations: Reservation[]
  loading: boolean
  currentReservation: {
    venueId: string
    venueName: string
    venueImage: string
    date: string
    time: string
    partySize: number
    tableId: string
    tableLabel: string
    preOrder: CartItem[]
  } | null
  setCurrentReservation: (data: Partial<ReservationState['currentReservation']>) => void
  clearCurrentReservation: () => void
  confirmReservation: (paymentMethod: string) => Promise<Reservation>
  fetchReservations: () => Promise<void>
  cancelReservation: (id: string) => Promise<void>
  getReservationById: (id: string) => Reservation | undefined
}

export const useReservationStore = create<ReservationState>((set, get) => ({
  reservations: [],
  loading: false,
  currentReservation: null,

  setCurrentReservation: (data) => {
    set((state) => ({
      currentReservation: state.currentReservation
        ? { ...state.currentReservation, ...data }
        : {
            venueId: '',
            venueName: '',
            venueImage: '',
            date: '',
            time: '',
            partySize: 2,
            tableId: '',
            tableLabel: '',
            preOrder: [],
            ...data,
          },
    }))
  },

  clearCurrentReservation: () => set({ currentReservation: null }),

  confirmReservation: async (paymentMethod: string) => {
    const { currentReservation } = get()
    if (!currentReservation) throw new Error('No reservation to confirm')

    const body = {
      venueId: currentReservation.venueId,
      tableId: currentReservation.tableId,
      date: currentReservation.date,
      time: currentReservation.time,
      partySize: currentReservation.partySize,
      paymentMethod,
      preOrder: currentReservation.preOrder.map((item) => ({
        menuItemId: item.menuItem.id,
        quantity: item.quantity,
      })),
    }

    const reservation = await apiFetch<Reservation>('/api/reservations', {
      method: 'POST',
      body: JSON.stringify(body),
    })

    set((state) => ({
      reservations: [reservation, ...state.reservations],
      currentReservation: null,
    }))

    return reservation
  },

  fetchReservations: async () => {
    set({ loading: true })
    try {
      const data = await apiFetch<Reservation[]>('/api/reservations')
      set({ reservations: data, loading: false })
    } catch {
      set({ loading: false })
    }
  },

  cancelReservation: async (id: string) => {
    const updated = await apiFetch<Reservation>(`/api/reservations/${id}`, {
      method: 'PATCH',
    })
    set((state) => ({
      reservations: state.reservations.map((r) =>
        r.id === id ? updated : r
      ),
    }))
  },

  getReservationById: (id) => {
    return get().reservations.find((r) => r.id === id)
  },
}))
