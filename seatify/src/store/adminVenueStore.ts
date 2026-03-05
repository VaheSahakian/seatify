import { create } from 'zustand'
import type { Venue, AdminDashboard, AdminReservation } from '@/types'
import { adminFetch } from '@/lib/adminApi'

interface AdminVenueState {
  venue: Venue | null
  dashboard: AdminDashboard | null
  reservations: AdminReservation[]
  loading: boolean

  fetchVenue: () => Promise<void>
  updateVenue: (data: Partial<Venue>) => Promise<void>
  fetchDashboard: () => Promise<void>
  fetchReservations: (date?: string, status?: string) => Promise<void>
  updateReservationStatus: (id: string, status: string) => Promise<void>

  // Menu
  createMenuCategory: (data: any) => Promise<any>
  updateMenuCategory: (id: string, data: any) => Promise<any>
  deleteMenuCategory: (id: string) => Promise<void>
  createMenuItem: (data: any) => Promise<any>
  updateMenuItem: (id: string, data: any) => Promise<any>
  deleteMenuItem: (id: string) => Promise<void>

  // Floor
  createFloorZone: (data: any) => Promise<any>
  updateFloorZone: (id: string, data: any) => Promise<any>
  deleteFloorZone: (id: string) => Promise<void>
  createFloorTable: (data: any) => Promise<any>
  updateFloorTable: (id: string, data: any) => Promise<any>
  deleteFloorTable: (id: string) => Promise<void>

  // Hours
  replaceHours: (hours: any[]) => Promise<void>

  // Images
  addImage: (data: { url: string; sortOrder?: number }) => Promise<any>
  deleteImage: (id: number) => Promise<void>
}

export const useAdminVenueStore = create<AdminVenueState>((set, get) => ({
  venue: null,
  dashboard: null,
  reservations: [],
  loading: false,

  fetchVenue: async () => {
    set({ loading: true })
    try {
      const venue = await adminFetch<Venue>('/api/admin/venue')
      set({ venue, loading: false })
    } catch {
      set({ loading: false })
    }
  },

  updateVenue: async (data) => {
    const venue = await adminFetch<Venue>('/api/admin/venue', {
      method: 'PATCH',
      body: JSON.stringify(data),
    })
    set({ venue })
  },

  fetchDashboard: async () => {
    const dashboard = await adminFetch<AdminDashboard>('/api/admin/dashboard')
    set({ dashboard })
  },

  fetchReservations: async (date, status) => {
    const params = new URLSearchParams()
    if (date) params.set('date', date)
    if (status) params.set('status', status)
    const qs = params.toString()
    const reservations = await adminFetch<AdminReservation[]>(`/api/admin/reservations${qs ? `?${qs}` : ''}`)
    set({ reservations })
  },

  updateReservationStatus: async (id, status) => {
    await adminFetch(`/api/admin/reservations/${id}/status`, {
      method: 'PATCH',
      body: JSON.stringify({ status }),
    })
    await get().fetchReservations()
  },

  // Menu
  createMenuCategory: (data) =>
    adminFetch('/api/admin/venue/menu/categories', { method: 'POST', body: JSON.stringify(data) }),
  updateMenuCategory: (id, data) =>
    adminFetch(`/api/admin/venue/menu/categories/${id}`, { method: 'PUT', body: JSON.stringify(data) }),
  deleteMenuCategory: (id) =>
    adminFetch(`/api/admin/venue/menu/categories/${id}`, { method: 'DELETE' }),
  createMenuItem: (data) =>
    adminFetch('/api/admin/venue/menu/items', { method: 'POST', body: JSON.stringify(data) }),
  updateMenuItem: (id, data) =>
    adminFetch(`/api/admin/venue/menu/items/${id}`, { method: 'PUT', body: JSON.stringify(data) }),
  deleteMenuItem: (id) =>
    adminFetch(`/api/admin/venue/menu/items/${id}`, { method: 'DELETE' }),

  // Floor
  createFloorZone: (data) =>
    adminFetch('/api/admin/venue/floor/zones', { method: 'POST', body: JSON.stringify(data) }),
  updateFloorZone: (id, data) =>
    adminFetch(`/api/admin/venue/floor/zones/${id}`, { method: 'PUT', body: JSON.stringify(data) }),
  deleteFloorZone: (id) =>
    adminFetch(`/api/admin/venue/floor/zones/${id}`, { method: 'DELETE' }),
  createFloorTable: (data) =>
    adminFetch('/api/admin/venue/floor/tables', { method: 'POST', body: JSON.stringify(data) }),
  updateFloorTable: (id, data) =>
    adminFetch(`/api/admin/venue/floor/tables/${id}`, { method: 'PUT', body: JSON.stringify(data) }),
  deleteFloorTable: (id) =>
    adminFetch(`/api/admin/venue/floor/tables/${id}`, { method: 'DELETE' }),

  // Hours
  replaceHours: async (hours) => {
    await adminFetch('/api/admin/venue/hours', { method: 'PUT', body: JSON.stringify(hours) })
    await get().fetchVenue()
  },

  // Images
  addImage: (data) =>
    adminFetch('/api/admin/venue/images', { method: 'POST', body: JSON.stringify(data) }),
  deleteImage: async (id) => {
    await adminFetch(`/api/admin/venue/images/${id}`, { method: 'DELETE' })
  },
}))
