import { useEffect, useMemo, useState } from 'react'
import { useAdminVenueStore } from '@/store/adminVenueStore'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Plus, Pencil, Trash2, RotateCw, MousePointer2 } from 'lucide-react'
import { toast } from 'sonner'
import { FloorPlanEditor } from '@/components/admin/FloorPlanEditor'
import type { FloorZone, FloorTable } from '@/types'

const LANGS = ['en', 'hy', 'ru'] as const

interface ZoneDraft {
  id?: string
  name: Record<string, string>
  x: number
  y: number
  width: number
  height: number
  color: string
}

interface TableDraft {
  id?: string
  zoneId: string
  x: number
  y: number
  width: number
  height: number
  shape: 'rect' | 'circle'
  seats: number
  label: string
  defaultStatus: 'available' | 'occupied' | 'reserved'
  rotation: number
}

export default function AdminFloorPlan() {
  const {
    venue,
    fetchVenue,
    createFloorZone,
    updateFloorZone,
    deleteFloorZone,
    createFloorTable,
    updateFloorTable,
    deleteFloorTable,
  } = useAdminVenueStore()

  const [editingZone, setEditingZone] = useState<ZoneDraft | null>(null)
  const [editingTable, setEditingTable] = useState<TableDraft | null>(null)
  const [langTab, setLangTab] = useState<(typeof LANGS)[number]>('en')
  const [selectedTableId, setSelectedTableId] = useState<string | null>(null)
  const [pendingChanges, setPendingChanges] = useState<
    Record<string, Partial<FloorTable>>
  >({})
  const [savingId, setSavingId] = useState<string | null>(null)

  useEffect(() => {
    fetchVenue()
  }, [fetchVenue])

  const zones = venue?.floorPlan?.zones || []
  const dbTables = venue?.floorPlan?.tables || []

  // Apply local pending edits on top of server data so the canvas is responsive
  const tables = useMemo<FloorTable[]>(() => {
    return dbTables.map((t) =>
      pendingChanges[t.id] ? { ...t, ...pendingChanges[t.id] } : t
    )
  }, [dbTables, pendingChanges])

  const selectedTable = tables.find((t) => t.id === selectedTableId) || null

  async function persistTablePatch(id: string, patch: Partial<FloorTable>) {
    const current = dbTables.find((t) => t.id === id)
    if (!current) return
    const merged = { ...current, ...pendingChanges[id], ...patch }

    setSavingId(id)
    try {
      await updateFloorTable(id, {
        zoneId: merged.zoneId,
        x: merged.x,
        y: merged.y,
        width: merged.width,
        height: merged.height,
        shape: merged.shape,
        seats: merged.seats,
        label: merged.label,
        defaultStatus: merged.status,
        rotation: merged.rotation ?? 0,
      })
      // Clear pending entry for this table; refetch picks up canonical values
      setPendingChanges((prev) => {
        const next = { ...prev }
        delete next[id]
        return next
      })
      await fetchVenue()
    } catch (err: any) {
      toast.error(err.message || 'Failed to save table')
    } finally {
      setSavingId(null)
    }
  }

  function handleCanvasTableChange(id: string, patch: Partial<FloorTable>) {
    // Update pending state immediately for snappy feedback
    setPendingChanges((prev) => ({ ...prev, [id]: { ...(prev[id] || {}), ...patch } }))
    // Persist on the trailing edge of drag/transform end
    persistTablePatch(id, patch)
  }

  async function rotateSelected(deltaDegrees: number) {
    if (!selectedTable) return
    const current = selectedTable.rotation || 0
    const next = ((current + deltaDegrees) % 360 + 360) % 360
    handleCanvasTableChange(selectedTable.id, { rotation: next })
  }

  async function toggleSelectedShape() {
    if (!selectedTable) return
    const next: 'rect' | 'circle' = selectedTable.shape === 'rect' ? 'circle' : 'rect'
    setSavingId(selectedTable.id)
    try {
      await updateFloorTable(selectedTable.id, {
        zoneId: selectedTable.zoneId,
        x: selectedTable.x,
        y: selectedTable.y,
        width: selectedTable.width,
        height: selectedTable.height,
        shape: next,
        seats: selectedTable.seats,
        label: selectedTable.label,
        defaultStatus: selectedTable.status,
        rotation: selectedTable.rotation ?? 0,
      })
      await fetchVenue()
    } catch (err: any) {
      toast.error(err.message || 'Failed to update shape')
    } finally {
      setSavingId(null)
    }
  }

  const handleSaveZone = async () => {
    if (!editingZone) return
    try {
      const data = {
        name: editingZone.name,
        x: editingZone.x,
        y: editingZone.y,
        width: editingZone.width,
        height: editingZone.height,
        color: editingZone.color,
      }
      if (editingZone.id) {
        await updateFloorZone(editingZone.id, data)
      } else {
        await createFloorZone(data)
      }
      toast.success('Zone saved!')
      setEditingZone(null)
      fetchVenue()
    } catch (err: any) {
      toast.error(err.message)
    }
  }

  const handleDeleteZone = async (id: string) => {
    try {
      await deleteFloorZone(id)
      toast.success('Zone deleted')
      fetchVenue()
    } catch (err: any) {
      toast.error(err.message)
    }
  }

  const handleSaveTable = async () => {
    if (!editingTable) return
    try {
      const data = {
        zoneId: editingTable.zoneId,
        x: editingTable.x,
        y: editingTable.y,
        width: editingTable.width,
        height: editingTable.height,
        shape: editingTable.shape,
        seats: editingTable.seats,
        label: editingTable.label,
        defaultStatus: editingTable.defaultStatus,
        rotation: editingTable.rotation,
      }
      if (editingTable.id) {
        await updateFloorTable(editingTable.id, data)
      } else {
        await createFloorTable(data)
      }
      toast.success('Table saved!')
      setEditingTable(null)
      fetchVenue()
    } catch (err: any) {
      toast.error(err.message)
    }
  }

  const handleDeleteTable = async (id: string) => {
    try {
      await deleteFloorTable(id)
      toast.success('Table deleted')
      if (selectedTableId === id) setSelectedTableId(null)
      fetchVenue()
    } catch (err: any) {
      toast.error(err.message)
    }
  }

  const handleAddTable = () => {
    if (zones.length === 0) {
      toast.error('Create a zone first')
      return
    }
    const nextNum = tables.length + 1
    setEditingTable({
      zoneId: zones[0].id,
      x: 40,
      y: 40,
      width: 80,
      height: 60,
      shape: 'rect',
      seats: 2,
      label: `T${nextNum}`,
      defaultStatus: 'available',
      rotation: 0,
    })
  }

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Floor Plan</h1>
        <div className="flex gap-2">
          <Button
            size="sm"
            variant="outline"
            onClick={() =>
              setEditingZone({
                name: { en: '' },
                x: 0,
                y: 0,
                width: 200,
                height: 200,
                color: '#F3F4F6',
              })
            }
          >
            <Plus size={14} className="mr-1" /> Zone
          </Button>
          <Button
            size="sm"
            onClick={handleAddTable}
            className="bg-indigo-600 hover:bg-indigo-700"
          >
            <Plus size={14} className="mr-1" /> Table
          </Button>
        </div>
      </div>

      {/* Interactive editor canvas */}
      {venue?.floorPlan && (
        <div className="bg-white rounded-xl border border-gray-200 p-5 mb-6 overflow-auto">
          <div className="flex items-center justify-between mb-3 text-xs text-gray-500">
            <div className="flex items-center gap-2">
              <MousePointer2 size={12} />
              <span>Click to select. Drag to move. Use handles to resize/rotate.</span>
            </div>
            {savingId && (
              <span className="text-indigo-600 animate-pulse">Saving…</span>
            )}
          </div>

          <FloorPlanEditor
            width={venue.floorPlan.width}
            height={venue.floorPlan.height}
            zones={zones}
            tables={tables}
            selectedTableId={selectedTableId}
            onSelect={setSelectedTableId}
            onTableChange={handleCanvasTableChange}
            lang={langTab}
          />

          {/* Selection toolbar */}
          {selectedTable && (
            <div className="mt-4 flex flex-wrap items-center gap-2 p-3 bg-gray-50 border border-gray-200 rounded-lg">
              <span className="text-xs font-medium text-gray-700 mr-2">
                {selectedTable.label || 'Table'} · {selectedTable.shape} ·{' '}
                {selectedTable.width}×{selectedTable.height} ·{' '}
                {selectedTable.rotation || 0}°
              </span>
              <Button size="sm" variant="outline" onClick={() => rotateSelected(15)}>
                <RotateCw size={14} className="mr-1" />
                +15°
              </Button>
              <Button size="sm" variant="outline" onClick={() => rotateSelected(-15)}>
                <RotateCw size={14} className="mr-1 -scale-x-100" />
                −15°
              </Button>
              <Button size="sm" variant="outline" onClick={() => rotateSelected(90)}>
                90°
              </Button>
              <Button size="sm" variant="outline" onClick={toggleSelectedShape}>
                Shape: {selectedTable.shape === 'rect' ? '→ circle' : '→ rect'}
              </Button>
              <Button
                size="sm"
                variant="outline"
                onClick={() => {
                  const t = selectedTable
                  setEditingTable({
                    id: t.id,
                    zoneId: t.zoneId,
                    x: t.x,
                    y: t.y,
                    width: t.width,
                    height: t.height,
                    shape: t.shape,
                    seats: t.seats,
                    label: t.label,
                    defaultStatus: t.status,
                    rotation: t.rotation || 0,
                  })
                }}
              >
                <Pencil size={14} className="mr-1" /> Details
              </Button>
              <Button
                size="sm"
                variant="outline"
                className="text-red-600 hover:text-red-700"
                onClick={() => handleDeleteTable(selectedTable.id)}
              >
                <Trash2 size={14} className="mr-1" /> Delete
              </Button>
            </div>
          )}

          <div className="flex items-center gap-2 mt-4 pt-4 border-t border-gray-100 text-xs text-gray-500">
            <span>Zone label language:</span>
            {LANGS.map((l) => (
              <button
                key={l}
                onClick={() => setLangTab(l)}
                className={`px-2 py-1 rounded cursor-pointer ${
                  langTab === l
                    ? 'bg-indigo-100 text-indigo-700 font-medium'
                    : 'hover:bg-gray-100'
                }`}
              >
                {l.toUpperCase()}
              </button>
            ))}
          </div>
        </div>
      )}

      {/* Zone edit form */}
      {editingZone && (
        <div className="mb-6 bg-white rounded-xl border border-gray-200 p-5 space-y-3">
          <h3 className="font-semibold">{editingZone.id ? 'Edit' : 'New'} Zone</h3>
          <div className="flex gap-2 mb-2">
            {LANGS.map((l) => (
              <button
                key={l}
                onClick={() => setLangTab(l)}
                className={`px-3 py-1 text-sm rounded-lg cursor-pointer ${
                  langTab === l
                    ? 'bg-indigo-100 text-indigo-700 font-medium'
                    : 'text-gray-500 hover:bg-gray-100'
                }`}
              >
                {l.toUpperCase()}
              </button>
            ))}
          </div>
          <Input
            placeholder="Zone name"
            value={editingZone.name[langTab] || ''}
            onChange={(e) =>
              setEditingZone({
                ...editingZone,
                name: { ...editingZone.name, [langTab]: e.target.value },
              })
            }
          />
          <div className="grid grid-cols-4 gap-2">
            <Input
              type="number"
              placeholder="X"
              value={editingZone.x}
              onChange={(e) => setEditingZone({ ...editingZone, x: Number(e.target.value) })}
            />
            <Input
              type="number"
              placeholder="Y"
              value={editingZone.y}
              onChange={(e) => setEditingZone({ ...editingZone, y: Number(e.target.value) })}
            />
            <Input
              type="number"
              placeholder="Width"
              value={editingZone.width}
              onChange={(e) =>
                setEditingZone({ ...editingZone, width: Number(e.target.value) })
              }
            />
            <Input
              type="number"
              placeholder="Height"
              value={editingZone.height}
              onChange={(e) =>
                setEditingZone({ ...editingZone, height: Number(e.target.value) })
              }
            />
          </div>
          <Input
            placeholder="Color (e.g. #E8F5E9)"
            value={editingZone.color}
            onChange={(e) => setEditingZone({ ...editingZone, color: e.target.value })}
          />
          <div className="flex gap-2">
            <Button onClick={handleSaveZone} className="bg-indigo-600 hover:bg-indigo-700">
              Save
            </Button>
            <Button variant="outline" onClick={() => setEditingZone(null)}>
              Cancel
            </Button>
          </div>
        </div>
      )}

      {/* Table edit form */}
      {editingTable && (
        <div className="mb-6 bg-white rounded-xl border border-gray-200 p-5 space-y-3">
          <h3 className="font-semibold">{editingTable.id ? 'Edit' : 'New'} Table</h3>
          <div className="grid grid-cols-2 gap-2">
            <div>
              <label className="text-xs text-gray-500">Zone</label>
              <select
                className="w-full border border-gray-200 rounded-lg p-2 text-sm"
                value={editingTable.zoneId}
                onChange={(e) =>
                  setEditingTable({ ...editingTable, zoneId: e.target.value })
                }
              >
                <option value="">Select zone</option>
                {zones.map((z: FloorZone) => (
                  <option key={z.id} value={z.id}>
                    {z.name.en || Object.values(z.name)[0]}
                  </option>
                ))}
              </select>
            </div>
            <Input
              placeholder="Label"
              value={editingTable.label}
              onChange={(e) =>
                setEditingTable({ ...editingTable, label: e.target.value })
              }
            />
          </div>
          <div className="grid grid-cols-4 gap-2">
            <Input
              type="number"
              placeholder="X"
              value={editingTable.x}
              onChange={(e) => setEditingTable({ ...editingTable, x: Number(e.target.value) })}
            />
            <Input
              type="number"
              placeholder="Y"
              value={editingTable.y}
              onChange={(e) => setEditingTable({ ...editingTable, y: Number(e.target.value) })}
            />
            <Input
              type="number"
              placeholder="Width"
              value={editingTable.width}
              onChange={(e) =>
                setEditingTable({ ...editingTable, width: Number(e.target.value) })
              }
            />
            <Input
              type="number"
              placeholder="Height"
              value={editingTable.height}
              onChange={(e) =>
                setEditingTable({ ...editingTable, height: Number(e.target.value) })
              }
            />
          </div>
          <div className="grid grid-cols-4 gap-2">
            <div>
              <label className="text-xs text-gray-500">Shape</label>
              <select
                className="w-full border border-gray-200 rounded-lg p-2 text-sm"
                value={editingTable.shape}
                onChange={(e) =>
                  setEditingTable({
                    ...editingTable,
                    shape: e.target.value as 'rect' | 'circle',
                  })
                }
              >
                <option value="rect">Rectangle</option>
                <option value="circle">Circle</option>
              </select>
            </div>
            <Input
              type="number"
              placeholder="Seats"
              value={editingTable.seats}
              onChange={(e) =>
                setEditingTable({ ...editingTable, seats: Number(e.target.value) })
              }
            />
            <Input
              type="number"
              placeholder="Rotation°"
              value={editingTable.rotation}
              onChange={(e) =>
                setEditingTable({ ...editingTable, rotation: Number(e.target.value) })
              }
            />
            <div>
              <label className="text-xs text-gray-500">Status</label>
              <select
                className="w-full border border-gray-200 rounded-lg p-2 text-sm"
                value={editingTable.defaultStatus}
                onChange={(e) =>
                  setEditingTable({
                    ...editingTable,
                    defaultStatus: e.target.value as TableDraft['defaultStatus'],
                  })
                }
              >
                <option value="available">Available</option>
                <option value="occupied">Occupied</option>
                <option value="reserved">Reserved</option>
              </select>
            </div>
          </div>
          <div className="flex gap-2">
            <Button onClick={handleSaveTable} className="bg-indigo-600 hover:bg-indigo-700">
              Save
            </Button>
            <Button variant="outline" onClick={() => setEditingTable(null)}>
              Cancel
            </Button>
          </div>
        </div>
      )}

      {/* Zones list */}
      <h2 className="font-semibold text-gray-900 mb-3">Zones</h2>
      <div className="space-y-2 mb-6">
        {zones.map((z: FloorZone) => (
          <div
            key={z.id}
            className="bg-white rounded-lg border border-gray-200 px-4 py-3 flex items-center justify-between"
          >
            <div>
              <span className="font-medium text-sm">
                {z.name.en || Object.values(z.name)[0]}
              </span>
              <span className="text-xs text-gray-400 ml-2">
                {z.width}×{z.height} at ({z.x},{z.y})
              </span>
            </div>
            <div className="flex gap-1">
              <button
                onClick={() =>
                  setEditingZone({
                    id: z.id,
                    name: z.name,
                    x: z.x,
                    y: z.y,
                    width: z.width,
                    height: z.height,
                    color: z.color,
                  })
                }
                className="p-1.5 text-gray-400 hover:text-gray-600 cursor-pointer"
              >
                <Pencil size={14} />
              </button>
              <button
                onClick={() => handleDeleteZone(z.id)}
                className="p-1.5 text-gray-400 hover:text-red-600 cursor-pointer"
              >
                <Trash2 size={14} />
              </button>
            </div>
          </div>
        ))}
      </div>

      {/* Tables list */}
      <h2 className="font-semibold text-gray-900 mb-3">Tables</h2>
      <div className="space-y-2">
        {tables.map((t: FloorTable) => (
          <div
            key={t.id}
            onClick={() => setSelectedTableId(t.id)}
            className={`bg-white rounded-lg border px-4 py-3 flex items-center justify-between cursor-pointer ${
              t.id === selectedTableId
                ? 'border-indigo-300 ring-2 ring-indigo-100'
                : 'border-gray-200 hover:border-gray-300'
            }`}
          >
            <div>
              <span className="font-medium text-sm">{t.label || t.id}</span>
              <span className="text-xs text-gray-400 ml-2">
                {t.seats} seats &middot; {t.shape} &middot; {t.status}
                {t.rotation ? ` · ${t.rotation}°` : ''}
              </span>
            </div>
            <div className="flex gap-1">
              <button
                onClick={(e) => {
                  e.stopPropagation()
                  setEditingTable({
                    id: t.id,
                    zoneId: t.zoneId,
                    x: t.x,
                    y: t.y,
                    width: t.width,
                    height: t.height,
                    shape: t.shape,
                    seats: t.seats,
                    label: t.label,
                    defaultStatus: t.status,
                    rotation: t.rotation || 0,
                  })
                }}
                className="p-1.5 text-gray-400 hover:text-gray-600 cursor-pointer"
              >
                <Pencil size={14} />
              </button>
              <button
                onClick={(e) => {
                  e.stopPropagation()
                  handleDeleteTable(t.id)
                }}
                className="p-1.5 text-gray-400 hover:text-red-600 cursor-pointer"
              >
                <Trash2 size={14} />
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
