import { useEffect, useState } from 'react'
import { useAdminVenueStore } from '@/store/adminVenueStore'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Plus, Pencil, Trash2 } from 'lucide-react'
import { toast } from 'sonner'
import type { FloorZone, FloorTable } from '@/types'

const LANGS = ['en', 'hy', 'ru'] as const

export default function AdminFloorPlan() {
  const { venue, fetchVenue, createFloorZone, updateFloorZone, deleteFloorZone,
    createFloorTable, updateFloorTable, deleteFloorTable } = useAdminVenueStore()
  const [editingZone, setEditingZone] = useState<any>(null)
  const [editingTable, setEditingTable] = useState<any>(null)
  const [langTab, setLangTab] = useState('en')

  useEffect(() => { fetchVenue() }, [fetchVenue])

  const zones = venue?.floorPlan?.zones || []
  const tables = venue?.floorPlan?.tables || []

  const handleSaveZone = async () => {
    if (!editingZone) return
    try {
      const data = { name: editingZone.name, x: editingZone.x, y: editingZone.y, width: editingZone.width, height: editingZone.height, color: editingZone.color }
      if (editingZone.id) {
        await updateFloorZone(editingZone.id, data)
      } else {
        await createFloorZone(data)
      }
      toast.success('Zone saved!')
      setEditingZone(null)
      fetchVenue()
    } catch (err: any) { toast.error(err.message) }
  }

  const handleDeleteZone = async (id: string) => {
    try {
      await deleteFloorZone(id)
      toast.success('Zone deleted')
      fetchVenue()
    } catch (err: any) { toast.error(err.message) }
  }

  const handleSaveTable = async () => {
    if (!editingTable) return
    try {
      const data = { zoneId: editingTable.zoneId, x: editingTable.x, y: editingTable.y, width: editingTable.width, height: editingTable.height, shape: editingTable.shape, seats: editingTable.seats, label: editingTable.label, defaultStatus: editingTable.defaultStatus }
      if (editingTable.id) {
        await updateFloorTable(editingTable.id, data)
      } else {
        await createFloorTable(data)
      }
      toast.success('Table saved!')
      setEditingTable(null)
      fetchVenue()
    } catch (err: any) { toast.error(err.message) }
  }

  const handleDeleteTable = async (id: string) => {
    try {
      await deleteFloorTable(id)
      toast.success('Table deleted')
      fetchVenue()
    } catch (err: any) { toast.error(err.message) }
  }

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-900 mb-6">Floor Plan</h1>

      {/* Visual floor plan preview */}
      {venue?.floorPlan && (
        <div className="bg-white rounded-xl border border-gray-200 p-5 mb-6 overflow-auto">
          <div className="relative" style={{ width: venue.floorPlan.width, height: venue.floorPlan.height, minWidth: 400 }}>
            {zones.map((z: FloorZone) => (
              <div key={z.id} className="absolute border border-dashed border-gray-300 rounded-lg flex items-center justify-center text-xs text-gray-500" style={{ left: z.x, top: z.y, width: z.width, height: z.height, backgroundColor: z.color || '#f3f4f6' }}>
                {z.name.en || Object.values(z.name)[0]}
              </div>
            ))}
            {tables.map((t: FloorTable) => (
              <div key={t.id} className={`absolute flex items-center justify-center text-xs font-medium text-white bg-indigo-500 ${t.shape === 'circle' ? 'rounded-full' : 'rounded-lg'}`} style={{ left: t.x, top: t.y, width: t.width, height: t.height }}>
                {t.label}
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Zone edit */}
      {editingZone && (
        <div className="mb-6 bg-white rounded-xl border border-gray-200 p-5 space-y-3">
          <h3 className="font-semibold">{editingZone.id ? 'Edit' : 'New'} Zone</h3>
          <div className="flex gap-2 mb-2">
            {LANGS.map((l) => (
              <button key={l} onClick={() => setLangTab(l)} className={`px-3 py-1 text-sm rounded-lg cursor-pointer ${langTab === l ? 'bg-indigo-100 text-indigo-700 font-medium' : 'text-gray-500 hover:bg-gray-100'}`}>{l.toUpperCase()}</button>
            ))}
          </div>
          <Input placeholder="Zone name" value={editingZone.name[langTab] || ''} onChange={(e) => setEditingZone({ ...editingZone, name: { ...editingZone.name, [langTab]: e.target.value } })} />
          <div className="grid grid-cols-4 gap-2">
            <Input type="number" placeholder="X" value={editingZone.x} onChange={(e) => setEditingZone({ ...editingZone, x: Number(e.target.value) })} />
            <Input type="number" placeholder="Y" value={editingZone.y} onChange={(e) => setEditingZone({ ...editingZone, y: Number(e.target.value) })} />
            <Input type="number" placeholder="Width" value={editingZone.width} onChange={(e) => setEditingZone({ ...editingZone, width: Number(e.target.value) })} />
            <Input type="number" placeholder="Height" value={editingZone.height} onChange={(e) => setEditingZone({ ...editingZone, height: Number(e.target.value) })} />
          </div>
          <Input placeholder="Color (e.g. #E8F5E9)" value={editingZone.color} onChange={(e) => setEditingZone({ ...editingZone, color: e.target.value })} />
          <div className="flex gap-2">
            <Button onClick={handleSaveZone} className="bg-indigo-600 hover:bg-indigo-700">Save</Button>
            <Button variant="outline" onClick={() => setEditingZone(null)}>Cancel</Button>
          </div>
        </div>
      )}

      {/* Table edit */}
      {editingTable && (
        <div className="mb-6 bg-white rounded-xl border border-gray-200 p-5 space-y-3">
          <h3 className="font-semibold">{editingTable.id ? 'Edit' : 'New'} Table</h3>
          <div className="grid grid-cols-2 gap-2">
            <div>
              <label className="text-xs text-gray-500">Zone</label>
              <select className="w-full border border-gray-200 rounded-lg p-2 text-sm" value={editingTable.zoneId} onChange={(e) => setEditingTable({ ...editingTable, zoneId: e.target.value })}>
                <option value="">Select zone</option>
                {zones.map((z: FloorZone) => <option key={z.id} value={z.id}>{z.name.en || Object.values(z.name)[0]}</option>)}
              </select>
            </div>
            <Input placeholder="Label" value={editingTable.label} onChange={(e) => setEditingTable({ ...editingTable, label: e.target.value })} />
          </div>
          <div className="grid grid-cols-4 gap-2">
            <Input type="number" placeholder="X" value={editingTable.x} onChange={(e) => setEditingTable({ ...editingTable, x: Number(e.target.value) })} />
            <Input type="number" placeholder="Y" value={editingTable.y} onChange={(e) => setEditingTable({ ...editingTable, y: Number(e.target.value) })} />
            <Input type="number" placeholder="Width" value={editingTable.width} onChange={(e) => setEditingTable({ ...editingTable, width: Number(e.target.value) })} />
            <Input type="number" placeholder="Height" value={editingTable.height} onChange={(e) => setEditingTable({ ...editingTable, height: Number(e.target.value) })} />
          </div>
          <div className="grid grid-cols-3 gap-2">
            <div>
              <label className="text-xs text-gray-500">Shape</label>
              <select className="w-full border border-gray-200 rounded-lg p-2 text-sm" value={editingTable.shape} onChange={(e) => setEditingTable({ ...editingTable, shape: e.target.value })}>
                <option value="rect">Rectangle</option>
                <option value="circle">Circle</option>
              </select>
            </div>
            <Input type="number" placeholder="Seats" value={editingTable.seats} onChange={(e) => setEditingTable({ ...editingTable, seats: Number(e.target.value) })} />
            <div>
              <label className="text-xs text-gray-500">Status</label>
              <select className="w-full border border-gray-200 rounded-lg p-2 text-sm" value={editingTable.defaultStatus} onChange={(e) => setEditingTable({ ...editingTable, defaultStatus: e.target.value })}>
                <option value="available">Available</option>
                <option value="occupied">Occupied</option>
                <option value="reserved">Reserved</option>
              </select>
            </div>
          </div>
          <div className="flex gap-2">
            <Button onClick={handleSaveTable} className="bg-indigo-600 hover:bg-indigo-700">Save</Button>
            <Button variant="outline" onClick={() => setEditingTable(null)}>Cancel</Button>
          </div>
        </div>
      )}

      {/* Zones list */}
      <div className="flex items-center justify-between mb-3">
        <h2 className="font-semibold text-gray-900">Zones</h2>
        <Button size="sm" onClick={() => setEditingZone({ name: { en: '' }, x: 0, y: 0, width: 200, height: 200, color: '#f3f4f6' })} className="bg-indigo-600 hover:bg-indigo-700">
          <Plus size={14} className="mr-1" /> Zone
        </Button>
      </div>
      <div className="space-y-2 mb-6">
        {zones.map((z: FloorZone) => (
          <div key={z.id} className="bg-white rounded-lg border border-gray-200 px-4 py-3 flex items-center justify-between">
            <div>
              <span className="font-medium text-sm">{z.name.en || Object.values(z.name)[0]}</span>
              <span className="text-xs text-gray-400 ml-2">{z.width}x{z.height} at ({z.x},{z.y})</span>
            </div>
            <div className="flex gap-1">
              <button onClick={() => setEditingZone({ id: z.id, name: z.name, x: z.x, y: z.y, width: z.width, height: z.height, color: z.color })} className="p-1.5 text-gray-400 hover:text-gray-600 cursor-pointer"><Pencil size={14} /></button>
              <button onClick={() => handleDeleteZone(z.id)} className="p-1.5 text-gray-400 hover:text-red-600 cursor-pointer"><Trash2 size={14} /></button>
            </div>
          </div>
        ))}
      </div>

      {/* Tables list */}
      <div className="flex items-center justify-between mb-3">
        <h2 className="font-semibold text-gray-900">Tables</h2>
        <Button size="sm" onClick={() => setEditingTable({ zoneId: zones[0]?.id || '', x: 0, y: 0, width: 80, height: 80, shape: 'rect', seats: 2, label: '', defaultStatus: 'available' })} className="bg-indigo-600 hover:bg-indigo-700">
          <Plus size={14} className="mr-1" /> Table
        </Button>
      </div>
      <div className="space-y-2">
        {tables.map((t: FloorTable) => (
          <div key={t.id} className="bg-white rounded-lg border border-gray-200 px-4 py-3 flex items-center justify-between">
            <div>
              <span className="font-medium text-sm">{t.label || t.id}</span>
              <span className="text-xs text-gray-400 ml-2">{t.seats} seats &middot; {t.shape} &middot; {t.status}</span>
            </div>
            <div className="flex gap-1">
              <button onClick={() => setEditingTable({ id: t.id, zoneId: t.zoneId, x: t.x, y: t.y, width: t.width, height: t.height, shape: t.shape, seats: t.seats, label: t.label, defaultStatus: t.status })} className="p-1.5 text-gray-400 hover:text-gray-600 cursor-pointer"><Pencil size={14} /></button>
              <button onClick={() => handleDeleteTable(t.id)} className="p-1.5 text-gray-400 hover:text-red-600 cursor-pointer"><Trash2 size={14} /></button>
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
