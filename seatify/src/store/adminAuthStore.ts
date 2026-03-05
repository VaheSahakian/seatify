import { create } from 'zustand'
import type { AdminUser } from '@/types'
import { adminFetch, setAdminTokens, clearAdminTokens } from '@/lib/adminApi'

interface AdminAuthResponse {
  admin: AdminUser
  accessToken: string
  refreshToken: string
}

interface AdminAuthState {
  admin: AdminUser | null
  isAuthenticated: boolean
  loading: boolean
  login: (email: string, password: string) => Promise<void>
  logout: () => Promise<void>
  initialize: () => Promise<void>
}

export const useAdminAuthStore = create<AdminAuthState>((set) => ({
  admin: null,
  isAuthenticated: false,
  loading: true,

  initialize: async () => {
    const token = localStorage.getItem('admin_access_token')
    if (!token) {
      set({ loading: false })
      return
    }
    try {
      const admin = await adminFetch<AdminUser>('/api/admin/auth/me')
      set({ admin, isAuthenticated: true, loading: false })
    } catch {
      clearAdminTokens()
      set({ admin: null, isAuthenticated: false, loading: false })
    }
  },

  login: async (email: string, password: string) => {
    const data = await adminFetch<AdminAuthResponse>('/api/admin/auth/login', {
      method: 'POST',
      body: JSON.stringify({ email, password }),
    })
    setAdminTokens(data.accessToken, data.refreshToken)
    set({ admin: data.admin, isAuthenticated: true })
  },

  logout: async () => {
    try {
      await adminFetch('/api/admin/auth/logout', { method: 'POST' })
    } catch {
      // ignore
    }
    clearAdminTokens()
    set({ admin: null, isAuthenticated: false })
  },
}))
