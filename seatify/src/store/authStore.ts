import { create } from 'zustand'
import type { User } from '@/types'
import { apiFetch, setTokens, clearTokens } from '@/lib/api'

interface AuthResponse {
  user: User
  accessToken: string
  refreshToken: string
}

interface AuthState {
  user: User | null
  isAuthenticated: boolean
  loading: boolean
  login: (email: string, password: string) => Promise<void>
  register: (name: string, email: string, password: string) => Promise<void>
  logout: () => Promise<void>
  fetchMe: () => Promise<void>
  updateProfile: (updates: Partial<User>) => Promise<void>
  initialize: () => Promise<void>
}

export const useAuthStore = create<AuthState>((set) => ({
  user: null,
  isAuthenticated: false,
  loading: true,

  initialize: async () => {
    const token = localStorage.getItem('access_token')
    if (!token) {
      set({ loading: false })
      return
    }
    try {
      const user = await apiFetch<User>('/api/auth/me')
      set({ user, isAuthenticated: true, loading: false })
    } catch {
      clearTokens()
      set({ user: null, isAuthenticated: false, loading: false })
    }
  },

  login: async (email: string, password: string) => {
    const data = await apiFetch<AuthResponse>('/api/auth/login', {
      method: 'POST',
      body: JSON.stringify({ email, password }),
    })
    setTokens(data.accessToken, data.refreshToken)
    set({ user: data.user, isAuthenticated: true })
  },

  register: async (name: string, email: string, password: string) => {
    const data = await apiFetch<AuthResponse>('/api/auth/register', {
      method: 'POST',
      body: JSON.stringify({ name, email, password }),
    })
    setTokens(data.accessToken, data.refreshToken)
    set({ user: data.user, isAuthenticated: true })
  },

  logout: async () => {
    try {
      await apiFetch('/api/auth/logout', { method: 'POST' })
    } catch {
      // ignore errors on logout
    }
    clearTokens()
    set({ user: null, isAuthenticated: false })
  },

  fetchMe: async () => {
    const user = await apiFetch<User>('/api/auth/me')
    set({ user, isAuthenticated: true })
  },

  updateProfile: async (updates) => {
    const user = await apiFetch<User>('/api/auth/profile', {
      method: 'PATCH',
      body: JSON.stringify(updates),
    })
    set({ user })
  },
}))
