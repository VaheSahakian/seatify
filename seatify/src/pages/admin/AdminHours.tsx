import { useEffect, useState } from 'react'
import { useAdminVenueStore } from '@/store/adminVenueStore'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Plus, Trash2 } from 'lucide-react'
import { toast } from 'sonner'

interface HourRow {
  day: string
  openTime: string
  closeTime: string
}

export default function AdminHours() {
  const { venue, fetchVenue, replaceHours } = useAdminVenueStore()
  const [rows, setRows] = useState<HourRow[]>([])
  const [saving, setSaving] = useState(false)

  useEffect(() => { fetchVenue() }, [fetchVenue])

  useEffect(() => {
    if (venue?.hours) {
      setRows(venue.hours.map((h) => ({ day: h.day, openTime: h.open, closeTime: h.close })))
    }
  }, [venue])

  const addRow = () => setRows([...rows, { day: '', openTime: '09:00', closeTime: '23:00' }])

  const removeRow = (i: number) => setRows(rows.filter((_, idx) => idx !== i))

  const updateRow = (i: number, field: keyof HourRow, value: string) => {
    const updated = [...rows]
    updated[i] = { ...updated[i], [field]: value }
    setRows(updated)
  }

  const handleSave = async () => {
    setSaving(true)
    try {
      await replaceHours(rows)
      toast.success('Hours updated!')
    } catch (err: any) {
      toast.error(err.message || 'Failed to save')
    } finally {
      setSaving(false)
    }
  }

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Hours</h1>
        <div className="flex gap-2">
          <Button variant="outline" onClick={addRow}>
            <Plus size={16} className="mr-1" /> Add Row
          </Button>
          <Button onClick={handleSave} disabled={saving} className="bg-indigo-600 hover:bg-indigo-700">
            {saving ? 'Saving...' : 'Save'}
          </Button>
        </div>
      </div>

      <div className="bg-white rounded-xl border border-gray-200">
        <div className="grid grid-cols-[1fr_1fr_1fr_auto] gap-3 px-5 py-3 border-b border-gray-200 text-sm font-medium text-gray-500">
          <span>Day</span>
          <span>Open</span>
          <span>Close</span>
          <span></span>
        </div>
        {rows.map((row, i) => (
          <div key={i} className="grid grid-cols-[1fr_1fr_1fr_auto] gap-3 px-5 py-2 items-center border-b border-gray-50 last:border-0">
            <Input
              placeholder="e.g. Mon-Fri"
              value={row.day}
              onChange={(e) => updateRow(i, 'day', e.target.value)}
            />
            <Input
              type="time"
              value={row.openTime}
              onChange={(e) => updateRow(i, 'openTime', e.target.value)}
            />
            <Input
              type="time"
              value={row.closeTime}
              onChange={(e) => updateRow(i, 'closeTime', e.target.value)}
            />
            <button onClick={() => removeRow(i)} className="p-2 text-gray-400 hover:text-red-600 cursor-pointer">
              <Trash2 size={16} />
            </button>
          </div>
        ))}
        {rows.length === 0 && (
          <p className="px-5 py-4 text-sm text-gray-400">No hours set. Click "Add Row" to start.</p>
        )}
      </div>
    </div>
  )
}
