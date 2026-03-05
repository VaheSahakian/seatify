import { useEffect, useState } from 'react'
import { useAdminVenueStore } from '@/store/adminVenueStore'
import { Input } from '@/components/ui/input'

export default function AdminReservations() {
  const { reservations, fetchReservations, updateReservationStatus } = useAdminVenueStore()
  const [dateFilter, setDateFilter] = useState('')
  const [statusFilter, setStatusFilter] = useState('')

  useEffect(() => {
    fetchReservations(dateFilter || undefined, statusFilter || undefined)
  }, [fetchReservations, dateFilter, statusFilter])

  const statusColors: Record<string, string> = {
    upcoming: 'bg-green-50 text-green-700',
    completed: 'bg-gray-100 text-gray-600',
    cancelled: 'bg-red-50 text-red-700',
  }

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-900 mb-6">Reservations</h1>

      <div className="flex gap-3 mb-6">
        <Input
          type="date"
          value={dateFilter}
          onChange={(e) => setDateFilter(e.target.value)}
          className="w-48"
        />
        <select
          value={statusFilter}
          onChange={(e) => setStatusFilter(e.target.value)}
          className="border border-gray-200 rounded-lg px-3 py-2 text-sm"
        >
          <option value="">All statuses</option>
          <option value="upcoming">Upcoming</option>
          <option value="completed">Completed</option>
          <option value="cancelled">Cancelled</option>
        </select>
      </div>

      <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
        <table className="w-full text-sm">
          <thead>
            <tr className="border-b border-gray-200 bg-gray-50">
              <th className="text-left px-4 py-3 font-medium text-gray-500">Customer</th>
              <th className="text-left px-4 py-3 font-medium text-gray-500">Date</th>
              <th className="text-left px-4 py-3 font-medium text-gray-500">Time</th>
              <th className="text-left px-4 py-3 font-medium text-gray-500">Party</th>
              <th className="text-left px-4 py-3 font-medium text-gray-500">Table</th>
              <th className="text-left px-4 py-3 font-medium text-gray-500">Status</th>
              <th className="text-left px-4 py-3 font-medium text-gray-500">Amount</th>
              <th className="text-left px-4 py-3 font-medium text-gray-500">Actions</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-50">
            {reservations.map((r) => (
              <tr key={r.id} className="hover:bg-gray-50">
                <td className="px-4 py-3">
                  <p className="font-medium text-gray-900">{r.customerName}</p>
                  <p className="text-xs text-gray-400">{r.customerPhone}</p>
                </td>
                <td className="px-4 py-3 text-gray-600">{r.date}</td>
                <td className="px-4 py-3 text-gray-600">{r.time}</td>
                <td className="px-4 py-3 text-gray-600">{r.partySize}</td>
                <td className="px-4 py-3 text-gray-600">{r.tableLabel}</td>
                <td className="px-4 py-3">
                  <span className={`text-xs font-medium px-2.5 py-1 rounded-full ${statusColors[r.status] || 'bg-gray-100 text-gray-600'}`}>
                    {r.status}
                  </span>
                </td>
                <td className="px-4 py-3 text-gray-600">{r.totalAmount.toLocaleString()} AMD</td>
                <td className="px-4 py-3">
                  {r.status === 'upcoming' && (
                    <div className="flex gap-1">
                      <button
                        onClick={() => updateReservationStatus(r.id, 'completed')}
                        className="text-xs px-2 py-1 rounded bg-green-50 text-green-700 hover:bg-green-100 cursor-pointer"
                      >
                        Complete
                      </button>
                      <button
                        onClick={() => updateReservationStatus(r.id, 'cancelled')}
                        className="text-xs px-2 py-1 rounded bg-red-50 text-red-700 hover:bg-red-100 cursor-pointer"
                      >
                        Cancel
                      </button>
                    </div>
                  )}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
        {reservations.length === 0 && (
          <p className="px-4 py-8 text-center text-gray-400 text-sm">No reservations found.</p>
        )}
      </div>
    </div>
  )
}
