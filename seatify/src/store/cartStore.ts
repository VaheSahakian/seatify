import { create } from 'zustand'
import type { CartItem, MenuItem } from '@/types'

interface CartState {
  items: CartItem[]
  venueId: string | null
  addItem: (item: MenuItem, venueId: string) => void
  removeItem: (itemId: string) => void
  updateQuantity: (itemId: string, quantity: number) => void
  clearCart: () => void
  getTotal: () => number
  getItemCount: () => number
}

export const useCartStore = create<CartState>((set, get) => ({
  items: [],
  venueId: null,
  addItem: (menuItem, venueId) => {
    set((state) => {
      if (state.venueId && state.venueId !== venueId) {
        return { items: [{ menuItem, quantity: 1, venueId }], venueId }
      }
      const existing = state.items.find((i) => i.menuItem.id === menuItem.id)
      if (existing) {
        return {
          items: state.items.map((i) =>
            i.menuItem.id === menuItem.id
              ? { ...i, quantity: i.quantity + 1 }
              : i
          ),
          venueId,
        }
      }
      return {
        items: [...state.items, { menuItem, quantity: 1, venueId }],
        venueId,
      }
    })
  },
  removeItem: (itemId) => {
    set((state) => ({
      items: state.items.filter((i) => i.menuItem.id !== itemId),
    }))
  },
  updateQuantity: (itemId, quantity) => {
    if (quantity <= 0) {
      get().removeItem(itemId)
      return
    }
    set((state) => ({
      items: state.items.map((i) =>
        i.menuItem.id === itemId ? { ...i, quantity } : i
      ),
    }))
  },
  clearCart: () => set({ items: [], venueId: null }),
  getTotal: () => {
    return get().items.reduce(
      (sum, item) => sum + item.menuItem.price * item.quantity,
      0
    )
  },
  getItemCount: () => {
    return get().items.reduce((sum, item) => sum + item.quantity, 0)
  },
}))
