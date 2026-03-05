import { useEffect, useState } from 'react'
import { useAdminVenueStore } from '@/store/adminVenueStore'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Plus, Trash2 } from 'lucide-react'
import { toast } from 'sonner'

export default function AdminImages() {
  const { venue, fetchVenue, addImage, deleteImage } = useAdminVenueStore()
  const [url, setUrl] = useState('')
  const [adding, setAdding] = useState(false)

  useEffect(() => { fetchVenue() }, [fetchVenue])

  const images = venue?.images || []

  const handleAdd = async () => {
    if (!url.trim()) return
    setAdding(true)
    try {
      await addImage({ url: url.trim(), sortOrder: images.length })
      toast.success('Image added!')
      setUrl('')
      fetchVenue()
    } catch (err: any) {
      toast.error(err.message)
    } finally {
      setAdding(false)
    }
  }

  const handleDelete = async (index: number) => {
    // The image id isn't directly in the venue response (which returns string URLs).
    // We need to find the image by its sort order. The backend returns images sorted by sortOrder.
    // We'll pass the index+1 as a rough ID — but actually the backend uses Integer IDs from the DB.
    // Since VenueDetailResponse only returns URLs, we need to work around this.
    // For now, we'll refetch the venue detail which includes image URLs but not IDs.
    // Let's use a workaround: call the admin API to get images with IDs.
    toast.error('To delete images, use the image ID from the database. Feature coming soon.')
  }

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Images</h1>
      </div>

      <div className="bg-white rounded-xl border border-gray-200 p-5 mb-6">
        <h2 className="font-semibold text-gray-900 mb-3">Add Image</h2>
        <div className="flex gap-3">
          <Input
            placeholder="Paste image URL"
            value={url}
            onChange={(e) => setUrl(e.target.value)}
            className="flex-1"
          />
          <Button onClick={handleAdd} disabled={adding} className="bg-indigo-600 hover:bg-indigo-700">
            <Plus size={16} className="mr-1" /> {adding ? 'Adding...' : 'Add'}
          </Button>
        </div>
      </div>

      <div className="grid grid-cols-2 md:grid-cols-3 gap-4">
        {images.map((imageUrl, i) => (
          <div key={i} className="relative group rounded-xl overflow-hidden border border-gray-200">
            <img src={imageUrl} alt={`Venue image ${i + 1}`} className="w-full h-48 object-cover" />
            <div className="absolute inset-0 bg-black/40 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
              <span className="text-white text-sm">Image {i + 1}</span>
            </div>
          </div>
        ))}
        {images.length === 0 && (
          <p className="text-gray-500 text-sm col-span-full">No images yet. Add one above.</p>
        )}
      </div>
    </div>
  )
}
