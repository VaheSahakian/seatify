import { useEffect } from 'react'
import { useAdminVenueStore } from '@/store/adminVenueStore'
import { CalendarDays, TrendingUp, Star, Users } from 'lucide-react'

export default function AdminDashboard() {
  const { dashboard, reservations, fetchDashboard, fetchReservations } = useAdminVenueStore()

  useEffect(() => {
    fetchDashboard()
    const today = new Date().toISOString().split('T')[0]
    fetchReservations(today)
  }, [fetchDashboard, fetchReservations])

  const stats = [
    { label: 'Total Reservations', value: dashboard?.totalReservations ?? 0, icon: CalendarDays, color: 'bg-blue-50 text-blue-600' },
    { label: 'Upcoming', value: dashboard?.upcomingReservations ?? 0, icon: Users, color: 'bg-green-50 text-green-600' },
    { label: 'Today', value: dashboard?.todayReservations ?? 0, icon: TrendingUp, color: 'bg-amber-50 text-amber-600' },
    { label: 'Avg Rating', value: dashboard?.averageRating?.toFixed(1) ?? '—', icon: Star, color: 'bg-purple-50 text-purple-600' },
  ]

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-900 mb-6">Dashboard</h1>

      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
        {stats.map(({ label, value, icon: Icon, color }) => (
          <div key={label} className="bg-white rounded-xl border border-gray-200 p-5">
            <div className="flex items-center gap-3 mb-3">
              <div className={`w-10 h-10 rounded-lg flex items-center justify-center ${color}`}>
                <Icon size={20} />
              </div>
              <span className="text-sm text-gray-500">{label}</span>
            </div>
            <p className="text-2xl font-bold text-gray-900">{value}</p>
          </div>
        ))}
      </div>

      <div className="bg-white rounded-xl border border-gray-200">
        <div className="px-5 py-4 border-b border-gray-200 flex items-center justify-between">
          <h2 className="font-semibold text-gray-900">Today's Reservations</h2>
          <span className="text-sm text-gray-500">{reservations.length} bookings</span>
        </div>
        {reservations.length === 0 ? (
          <p className="p-5 text-gray-500 text-sm">No reservations today.</p>
        ) : (
          <div className="divide-y divide-gray-100">
            {reservations.map((r) => (
              <div key={r.id} className="px-5 py-3 flex items-center justify-between">
                <div>
                  <p className="text-sm font-medium text-gray-900">{r.customerName}</p>
                  <p className="text-xs text-gray-500">{r.time} &middot; {r.partySize} guests &middot; Table {r.tableLabel}</p>
                </div>
                <span className={`text-xs font-medium px-2.5 py-1 rounded-full ${
                  r.status === 'upcoming' ? 'bg-green-50 text-green-700' :
                  r.status === 'completed' ? 'bg-gray-100 text-gray-600' :
                  'bg-red-50 text-red-700'
                }`}>
                  {r.status}
                </span>
              </div>
            ))}
          </div>
        )}
      </div>

      {dashboard && (
        <div className="mt-6 grid grid-cols-1 sm:grid-cols-2 gap-4">
          <div className="bg-white rounded-xl border border-gray-200 p-5">
            <p className="text-sm text-gray-500 mb-1">Total Revenue</p>
            <p className="text-2xl font-bold text-gray-900">{dashboard.revenue.toLocaleString()} AMD</p>
          </div>
          <div className="bg-white rounded-xl border border-gray-200 p-5">
            <p className="text-sm text-gray-500 mb-1">Reviews</p>
            <p className="text-2xl font-bold text-gray-900">{dashboard.reviewCount}</p>
          </div>
        </div>
      )}
    </div>
  )
}
