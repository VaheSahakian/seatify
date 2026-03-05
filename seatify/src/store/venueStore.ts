import { create } from 'zustand'
import type { Venue, SearchFilters } from '@/types'
import { apiFetch } from '@/lib/api'

interface VenueState {
  venues: Venue[]
  filteredVenues: Venue[]
  selectedVenue: Venue | null
  filters: SearchFilters
  viewMode: 'list' | 'map'
  loading: boolean
  fetchVenues: () => Promise<void>
  fetchVenueBySlug: (slug: string) => Promise<Venue | undefined>
  setFilters: (filters: Partial<SearchFilters>) => void
  resetFilters: () => void
  setViewMode: (mode: 'list' | 'map') => void
  selectVenue: (venue: Venue | null) => void
  getVenueBySlug: (slug: string) => Venue | undefined
  applyFilters: () => void
}

const defaultFilters: SearchFilters = {
  query: '',
  cuisine: [],
  priceRange: [],
  minRating: 0,
  sortBy: 'rating',
}

export const useVenueStore = create<VenueState>((set, get) => ({
  venues: [],
  filteredVenues: [],
  selectedVenue: null,
  filters: defaultFilters,
  viewMode: 'list',
  loading: false,

  fetchVenues: async () => {
    if (get().venues.length > 0) return
    set({ loading: true })
    try {
      const data = await apiFetch<Venue[]>('/api/venues')
      set({ venues: data, filteredVenues: data, loading: false })
      get().applyFilters()
    } catch {
      set({ loading: false })
    }
  },

  fetchVenueBySlug: async (slug: string) => {
    // Check local cache first
    const cached = get().venues.find((v) => v.slug === slug)
    if (cached?.floorPlan) return cached

    try {
      const venue = await apiFetch<Venue>(`/api/venues/${slug}`)
      // Update in cache
      set((state) => {
        const exists = state.venues.some((v) => v.id === venue.id)
        const venues = exists
          ? state.venues.map((v) => (v.id === venue.id ? venue : v))
          : [...state.venues, venue]
        return { venues, selectedVenue: venue }
      })
      get().applyFilters()
      return venue
    } catch {
      return undefined
    }
  },

  setFilters: (newFilters) => {
    set((state) => ({
      filters: { ...state.filters, ...newFilters },
    }))
    get().applyFilters()
  },
  resetFilters: () => {
    set({ filters: defaultFilters })
    get().applyFilters()
  },
  setViewMode: (mode) => set({ viewMode: mode }),
  selectVenue: (venue) => set({ selectedVenue: venue }),
  getVenueBySlug: (slug) => {
    return get().venues.find((v) => v.slug === slug)
  },
  applyFilters: () => {
    const { venues, filters } = get()
    let result = [...venues]

    if (filters.query) {
      const q = filters.query.toLowerCase()
      result = result.filter(
        (v) =>
          v.name.toLowerCase().includes(q) ||
          v.cuisine.some((c: string) => c.toLowerCase().includes(q)) ||
          v.address.toLowerCase().includes(q)
      )
    }

    if (filters.cuisine.length > 0) {
      result = result.filter((v) =>
        v.cuisine.some((c: string) => filters.cuisine.includes(c))
      )
    }

    if (filters.priceRange.length > 0) {
      result = result.filter((v) => filters.priceRange.includes(v.priceRange))
    }

    if (filters.minRating > 0) {
      result = result.filter((v) => v.rating >= filters.minRating)
    }

    switch (filters.sortBy) {
      case 'rating':
        result.sort((a, b) => b.rating - a.rating)
        break
      case 'price':
        result.sort((a, b) => a.priceRange - b.priceRange)
        break
      default:
        break
    }

    set({ filteredVenues: result })
  },
}))
