import { NavLink, useNavigate } from 'react-router-dom'
import {
  LayoutDashboard,
  Store,
  UtensilsCrossed,
  Grid3X3,
  Clock,
  ImageIcon,
  CalendarDays,
  LogOut,
} from 'lucide-react'
import { useAdminAuthStore } from '@/store/adminAuthStore'

const links = [
  { to: '/admin', label: 'Dashboard', icon: LayoutDashboard, end: true },
  { to: '/admin/venue', label: 'Venue Info', icon: Store },
  { to: '/admin/menu', label: 'Menu', icon: UtensilsCrossed },
  { to: '/admin/floor-plan', label: 'Floor Plan', icon: Grid3X3 },
  { to: '/admin/hours', label: 'Hours', icon: Clock },
  { to: '/admin/images', label: 'Images', icon: ImageIcon },
  { to: '/admin/reservations', label: 'Reservations', icon: CalendarDays },
]

export function AdminSidebar() {
  const navigate = useNavigate()
  const { admin, logout } = useAdminAuthStore()

  const handleLogout = async () => {
    await logout()
    navigate('/admin/login')
  }

  return (
    <aside className="w-64 bg-white border-r border-gray-200 flex flex-col min-h-screen">
      <div className="p-4 border-b border-gray-200">
        <div className="flex items-center gap-3">
          <div className="w-9 h-9 bg-indigo-600 rounded-lg flex items-center justify-center">
            <span className="text-white font-bold text-sm">S</span>
          </div>
          <div className="min-w-0">
            <p className="text-sm font-semibold text-gray-900 truncate">{admin?.name}</p>
            <p className="text-xs text-gray-500 truncate">{admin?.email}</p>
          </div>
        </div>
      </div>

      <nav className="flex-1 p-3 space-y-1">
        {links.map(({ to, label, icon: Icon, end }) => (
          <NavLink
            key={to}
            to={to}
            end={end}
            className={({ isActive }) =>
              `flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium transition-colors ${
                isActive
                  ? 'bg-indigo-50 text-indigo-700'
                  : 'text-gray-600 hover:bg-gray-50 hover:text-gray-900'
              }`
            }
          >
            <Icon size={18} />
            {label}
          </NavLink>
        ))}
      </nav>

      <div className="p-3 border-t border-gray-200">
        <button
          onClick={handleLogout}
          className="flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-50 hover:text-gray-900 w-full transition-colors cursor-pointer"
        >
          <LogOut size={18} />
          Sign Out
        </button>
      </div>
    </aside>
  )
}
