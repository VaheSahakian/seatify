import { Outlet } from 'react-router-dom'
import { AdminSidebar } from './AdminSidebar'
import { Toaster } from 'sonner'

export function AdminLayout() {
  return (
    <div className="flex min-h-screen bg-gray-50">
      <AdminSidebar />
      <main className="flex-1 p-6 overflow-auto">
        <Outlet />
      </main>
      <Toaster position="top-center" richColors />
    </div>
  )
}
