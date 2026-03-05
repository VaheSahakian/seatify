import { useEffect } from 'react'
import { Navigate, Outlet } from 'react-router-dom'
import { useAdminAuthStore } from '@/store/adminAuthStore'

export function AdminGuard() {
  const { isAuthenticated, loading, initialize } = useAdminAuthStore()

  useEffect(() => {
    initialize()
  }, [initialize])

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-indigo-600" />
      </div>
    )
  }

  if (!isAuthenticated) {
    return <Navigate to="/admin/login" replace />
  }

  return <Outlet />
}
