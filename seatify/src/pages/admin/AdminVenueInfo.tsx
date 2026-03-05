import { useEffect, useState } from 'react'
import { useAdminVenueStore } from '@/store/adminVenueStore'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { toast } from 'sonner'

const LANGS = ['en', 'hy', 'ru'] as const

export default function AdminVenueInfo() {
  const { venue, loading, fetchVenue, updateVenue } = useAdminVenueStore()
  const [form, setForm] = useState({
    name: '',
    description: {} as Record<string, string>,
    cuisine: [] as string[],
    priceRange: 1 as number,
    address: '',
    phone: '',
    features: [] as string[],
    policies: {} as Record<string, string>,
  })
  const [saving, setSaving] = useState(false)
  const [langTab, setLangTab] = useState<string>('en')

  useEffect(() => {
    fetchVenue()
  }, [fetchVenue])

  useEffect(() => {
    if (venue) {
      setForm({
        name: venue.name,
        description: venue.description || {},
        cuisine: venue.cuisine || [],
        priceRange: venue.priceRange,
        address: venue.address,
        phone: venue.phone,
        features: venue.features || [],
        policies: venue.policies || {},
      })
    }
  }, [venue])

  const handleSave = async () => {
    setSaving(true)
    try {
      await updateVenue({
        name: form.name,
        description: form.description,
        cuisine: form.cuisine,
        priceRange: form.priceRange as any,
        address: form.address,
        phone: form.phone,
        features: form.features,
        policies: form.policies,
      })
      toast.success('Venue updated!')
    } catch (err: any) {
      toast.error(err.message || 'Failed to update')
    } finally {
      setSaving(false)
    }
  }

  if (loading && !venue) {
    return <div className="flex justify-center py-20"><div className="animate-spin rounded-full h-8 w-8 border-b-2 border-indigo-600" /></div>
  }

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Venue Info</h1>
        <Button onClick={handleSave} disabled={saving} className="bg-indigo-600 hover:bg-indigo-700">
          {saving ? 'Saving...' : 'Save Changes'}
        </Button>
      </div>

      <div className="space-y-6 max-w-2xl">
        <div className="bg-white rounded-xl border border-gray-200 p-5 space-y-4">
          <h2 className="font-semibold text-gray-900">Basic Info</h2>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Name</label>
            <Input value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Address</label>
            <Input value={form.address} onChange={(e) => setForm({ ...form, address: e.target.value })} />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Phone</label>
            <Input value={form.phone} onChange={(e) => setForm({ ...form, phone: e.target.value })} />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Price Range (1-4)</label>
            <Input
              type="number"
              min={1}
              max={4}
              value={form.priceRange}
              onChange={(e) => setForm({ ...form, priceRange: Number(e.target.value) })}
            />
          </div>
        </div>

        <div className="bg-white rounded-xl border border-gray-200 p-5 space-y-4">
          <h2 className="font-semibold text-gray-900">Description</h2>
          <div className="flex gap-2 mb-2">
            {LANGS.map((l) => (
              <button
                key={l}
                onClick={() => setLangTab(l)}
                className={`px-3 py-1 text-sm rounded-lg cursor-pointer ${
                  langTab === l ? 'bg-indigo-100 text-indigo-700 font-medium' : 'text-gray-500 hover:bg-gray-100'
                }`}
              >
                {l.toUpperCase()}
              </button>
            ))}
          </div>
          <textarea
            className="w-full border border-gray-200 rounded-lg p-3 text-sm min-h-[100px] focus:outline-none focus:ring-2 focus:ring-indigo-500"
            value={form.description[langTab] || ''}
            onChange={(e) =>
              setForm({ ...form, description: { ...form.description, [langTab]: e.target.value } })
            }
          />
        </div>

        <div className="bg-white rounded-xl border border-gray-200 p-5 space-y-4">
          <h2 className="font-semibold text-gray-900">Cuisine Tags</h2>
          <Input
            placeholder="Comma-separated: Armenian, Italian, BBQ"
            value={form.cuisine.join(', ')}
            onChange={(e) => setForm({ ...form, cuisine: e.target.value.split(',').map((s) => s.trim()).filter(Boolean) })}
          />
        </div>

        <div className="bg-white rounded-xl border border-gray-200 p-5 space-y-4">
          <h2 className="font-semibold text-gray-900">Features</h2>
          <Input
            placeholder="Comma-separated: WiFi, Valet Parking, Private Rooms"
            value={form.features.join(', ')}
            onChange={(e) => setForm({ ...form, features: e.target.value.split(',').map((s) => s.trim()).filter(Boolean) })}
          />
        </div>

        <div className="bg-white rounded-xl border border-gray-200 p-5 space-y-4">
          <h2 className="font-semibold text-gray-900">Policies</h2>
          <div className="flex gap-2 mb-2">
            {LANGS.map((l) => (
              <button
                key={l}
                onClick={() => setLangTab(l)}
                className={`px-3 py-1 text-sm rounded-lg cursor-pointer ${
                  langTab === l ? 'bg-indigo-100 text-indigo-700 font-medium' : 'text-gray-500 hover:bg-gray-100'
                }`}
              >
                {l.toUpperCase()}
              </button>
            ))}
          </div>
          <textarea
            className="w-full border border-gray-200 rounded-lg p-3 text-sm min-h-[80px] focus:outline-none focus:ring-2 focus:ring-indigo-500"
            value={form.policies[langTab] || ''}
            onChange={(e) =>
              setForm({ ...form, policies: { ...form.policies, [langTab]: e.target.value } })
            }
          />
        </div>
      </div>
    </div>
  )
}
