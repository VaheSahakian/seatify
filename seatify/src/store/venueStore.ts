import { create } from 'zustand'
import type { Venue, SearchFilters } from '@/types'
import { apiFetch } from '@/lib/api'
import { getDistance } from '@/lib/geo'

interface VenueState {
  venues: Venue[]
  filteredVenues: Venue[]
  selectedVenue: Venue | null
  filters: SearchFilters
  viewMode: 'list' | 'map'
  loading: boolean
  userLocation: { lat: number; lng: number } | null
  dishSearchResults: Venue[]
  dishSearchLoading: boolean
  fetchVenues: () => Promise<void>
  fetchVenueBySlug: (slug: string) => Promise<Venue | undefined>
  setFilters: (filters: Partial<SearchFilters>) => void
  resetFilters: () => void
  setViewMode: (mode: 'list' | 'map') => void
  selectVenue: (venue: Venue | null) => void
  getVenueBySlug: (slug: string) => Venue | undefined
  setUserLocation: (loc: { lat: number; lng: number } | null) => void
  searchByDish: (query: string) => Promise<void>
  clearDishSearch: () => void
  applyFilters: () => void
}

const defaultFilters: SearchFilters = {
  query: '',
  cuisine: [],
  priceRange: [],
  minRating: 0,
  sortBy: 'rating',
  openNow: false,
  dietaryTags: [],
}

const DAY_NAMES = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']

function isVenueOpenNow(venue: Venue): boolean {
  const now = new Date()
  const currentDay = DAY_NAMES[now.getDay()]
  const currentMinutes = now.getHours() * 60 + now.getMinutes()

  for (const h of venue.hours) {
    if (!matchesDay(h.day, currentDay)) continue

    const openMin = parseTime(h.open)
    const closeMin = parseTime(h.close)
    if (openMin === null || closeMin === null) continue

    // Handle overnight hours (e.g. open 18:00, close 02:00)
    if (closeMin <= openMin) {
      if (currentMinutes >= openMin || currentMinutes < closeMin) return true
    } else {
      if (currentMinutes >= openMin && currentMinutes < closeMin) return true
    }
  }
  return false
}

function matchesDay(dayField: string, currentDay: string): boolean {
  // Handle formats: "Mon-Sun", "Mon-Fri", "Sat-Sun", "Mon", etc.
  const parts = dayField.split(',').map((s) => s.trim())
  for (const part of parts) {
    if (part.includes('-')) {
      const [startDay, endDay] = part.split('-').map((s) => s.trim())
      const startIdx = DAY_NAMES.indexOf(startDay)
      const endIdx = DAY_NAMES.indexOf(endDay)
      const currentIdx = DAY_NAMES.indexOf(currentDay)
      if (startIdx === -1 || endIdx === -1 || currentIdx === -1) continue
      if (startIdx <= endIdx) {
        if (currentIdx >= startIdx && currentIdx <= endIdx) return true
      } else {
        // Wraps around (e.g. Fri-Mon)
        if (currentIdx >= startIdx || currentIdx <= endIdx) return true
      }
    } else {
      if (part === currentDay) return true
    }
  }
  return false
}

function parseTime(time: string): number | null {
  const match = time.match(/^(\d{1,2}):(\d{2})$/)
  if (!match) return null
  return parseInt(match[1]) * 60 + parseInt(match[2])
}

export const useVenueStore = create<VenueState>((set, get) => ({
  venues: [],
  filteredVenues: [],
  selectedVenue: null,
  filters: defaultFilters,
  viewMode: 'list',
  loading: false,
  userLocation: null,
  dishSearchResults: [],
  dishSearchLoading: false,

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
    set({ filters: defaultFilters, dishSearchResults: [] })
    get().applyFilters()
  },
  setViewMode: (mode) => set({ viewMode: mode }),
  selectVenue: (venue) => set({ selectedVenue: venue }),
  getVenueBySlug: (slug) => {
    return get().venues.find((v) => v.slug === slug)
  },

  setUserLocation: (loc) => {
    set({ userLocation: loc })
    get().applyFilters()
  },

  searchByDish: async (query: string) => {
    if (!query || query.length < 2) {
      set({ dishSearchResults: [] })
      return
    }
    set({ dishSearchLoading: true })
    try {
      const results = await apiFetch<Venue[]>(`/api/venues/search?dish=${encodeURIComponent(query)}`)
      set({ dishSearchResults: results, dishSearchLoading: false })
    } catch {
      set({ dishSearchResults: [], dishSearchLoading: false })
    }
  },

  clearDishSearch: () => set({ dishSearchResults: [] }),

  applyFilters: () => {
    const { venues, filters, userLocation } = get()
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

    if (filters.openNow) {
      result = result.filter(isVenueOpenNow)
    }

    if (filters.dietaryTags.length > 0) {
      result = result.filter((v) =>
        v.cuisine.some((c) =>
          filters.dietaryTags.some((tag) =>
            c.toLowerCase().includes(tag.toLowerCase())
          )
        )
      )
    }

    switch (filters.sortBy) {
      case 'rating':
        result.sort((a, b) => b.rating - a.rating)
        break
      case 'price':
        result.sort((a, b) => a.priceRange - b.priceRange)
        break
      case 'distance':
        if (userLocation) {
          result.sort((a, b) => {
            const distA = getDistance(userLocation.lat, userLocation.lng, a.coordinates.lat, a.coordinates.lng)
            const distB = getDistance(userLocation.lat, userLocation.lng, b.coordinates.lat, b.coordinates.lng)
            return distA - distB
          })
        }
        break
      default:
        break
    }

    set({ filteredVenues: result })
  },
}))
