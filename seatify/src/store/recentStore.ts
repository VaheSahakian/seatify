import { create } from 'zustand'

interface RecentItem {
  id: string
  slug: string
  name: string
  image: string
  cuisine: string[]
  rating: number
  viewedAt: number
}

interface RecentState {
  items: RecentItem[]
  addView: (item: Omit<RecentItem, 'viewedAt'>) => void
}

export const useRecentStore = create<RecentState>((set, get) => ({
  items: JSON.parse(localStorage.getItem('recentlyViewed') || '[]'),
  addView: (item) => {
    const existing = get().items.filter((i) => i.id !== item.id)
    const updated = [{ ...item, viewedAt: Date.now() }, ...existing].slice(0, 10)
    localStorage.setItem('recentlyViewed', JSON.stringify(updated))
    set({ items: updated })
  },
}))
