import { create } from 'zustand'
import { apiFetch } from '@/lib/api'

interface FavoriteState {
  favoriteIds: string[]   // venue IDs
  loaded: boolean
  fetchFavorites: () => Promise<void>
  toggleFavorite: (venueId: string) => Promise<void>
  isFavorite: (venueId: string) => boolean
}

export const useFavoriteStore = create<FavoriteState>((set, get) => ({
  favoriteIds: [],
  loaded: false,
  fetchFavorites: async () => {
    try {
      const ids = await apiFetch<string[]>('/api/favorites')
      set({ favoriteIds: ids, loaded: true })
    } catch {
      set({ loaded: true })
    }
  },
  toggleFavorite: async (venueId) => {
    const { favoriteIds } = get()
    const isFav = favoriteIds.includes(venueId)
    // Optimistic update
    if (isFav) {
      set({ favoriteIds: favoriteIds.filter(id => id !== venueId) })
      try { await apiFetch(`/api/favorites/${venueId}`, { method: 'DELETE' }) } catch {
        set({ favoriteIds: [...get().favoriteIds, venueId] })
      }
    } else {
      set({ favoriteIds: [...favoriteIds, venueId] })
      try { await apiFetch(`/api/favorites/${venueId}`, { method: 'POST' }) } catch {
        set({ favoriteIds: get().favoriteIds.filter(id => id !== venueId) })
      }
    }
  },
  isFavorite: (venueId) => get().favoriteIds.includes(venueId),
}))
