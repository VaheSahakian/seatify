import { useEffect, useState } from 'react'
import { useAdminVenueStore } from '@/store/adminVenueStore'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Plus, Pencil, Trash2, ChevronDown, ChevronRight } from 'lucide-react'
import { toast } from 'sonner'
import type { MenuCategory, MenuItem } from '@/types'

const LANGS = ['en', 'hy', 'ru'] as const

export default function AdminMenu() {
  const { venue, fetchVenue, createMenuCategory, updateMenuCategory, deleteMenuCategory,
    createMenuItem, updateMenuItem, deleteMenuItem } = useAdminVenueStore()
  const [expandedCat, setExpandedCat] = useState<string | null>(null)
  const [editingCat, setEditingCat] = useState<{ id?: string; name: Record<string, string>; sortOrder: number } | null>(null)
  const [editingItem, setEditingItem] = useState<{ id?: string; categoryId: string; name: Record<string, string>; description: Record<string, string>; price: number; image: string; tags: string[]; sortOrder: number } | null>(null)
  const [langTab, setLangTab] = useState('en')

  useEffect(() => { fetchVenue() }, [fetchVenue])

  const categories = venue?.menu || []

  const handleSaveCategory = async () => {
    if (!editingCat) return
    try {
      if (editingCat.id) {
        await updateMenuCategory(editingCat.id, { name: editingCat.name, sortOrder: editingCat.sortOrder })
      } else {
        await createMenuCategory({ name: editingCat.name, sortOrder: editingCat.sortOrder })
      }
      toast.success('Category saved!')
      setEditingCat(null)
      fetchVenue()
    } catch (err: any) { toast.error(err.message) }
  }

  const handleDeleteCategory = async (id: string) => {
    try {
      await deleteMenuCategory(id)
      toast.success('Category deleted')
      fetchVenue()
    } catch (err: any) { toast.error(err.message) }
  }

  const handleSaveItem = async () => {
    if (!editingItem) return
    try {
      const data = {
        categoryId: editingItem.categoryId,
        name: editingItem.name,
        description: editingItem.description,
        price: editingItem.price,
        image: editingItem.image || null,
        tags: editingItem.tags,
        sortOrder: editingItem.sortOrder,
      }
      if (editingItem.id) {
        await updateMenuItem(editingItem.id, data)
      } else {
        await createMenuItem(data)
      }
      toast.success('Item saved!')
      setEditingItem(null)
      fetchVenue()
    } catch (err: any) { toast.error(err.message) }
  }

  const handleDeleteItem = async (id: string) => {
    try {
      await deleteMenuItem(id)
      toast.success('Item deleted')
      fetchVenue()
    } catch (err: any) { toast.error(err.message) }
  }

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Menu</h1>
        <Button onClick={() => setEditingCat({ name: { en: '' }, sortOrder: 0 })} className="bg-indigo-600 hover:bg-indigo-700">
          <Plus size={16} className="mr-1" /> Add Category
        </Button>
      </div>

      {/* Category edit modal */}
      {editingCat && (
        <div className="mb-6 bg-white rounded-xl border border-gray-200 p-5 space-y-3">
          <h3 className="font-semibold">{editingCat.id ? 'Edit' : 'New'} Category</h3>
          <div className="flex gap-2 mb-2">
            {LANGS.map((l) => (
              <button key={l} onClick={() => setLangTab(l)} className={`px-3 py-1 text-sm rounded-lg cursor-pointer ${langTab === l ? 'bg-indigo-100 text-indigo-700 font-medium' : 'text-gray-500 hover:bg-gray-100'}`}>{l.toUpperCase()}</button>
            ))}
          </div>
          <Input placeholder="Category name" value={editingCat.name[langTab] || ''} onChange={(e) => setEditingCat({ ...editingCat, name: { ...editingCat.name, [langTab]: e.target.value } })} />
          <Input type="number" placeholder="Sort order" value={editingCat.sortOrder} onChange={(e) => setEditingCat({ ...editingCat, sortOrder: Number(e.target.value) })} />
          <div className="flex gap-2">
            <Button onClick={handleSaveCategory} className="bg-indigo-600 hover:bg-indigo-700">Save</Button>
            <Button variant="outline" onClick={() => setEditingCat(null)}>Cancel</Button>
          </div>
        </div>
      )}

      {/* Item edit modal */}
      {editingItem && (
        <div className="mb-6 bg-white rounded-xl border border-gray-200 p-5 space-y-3">
          <h3 className="font-semibold">{editingItem.id ? 'Edit' : 'New'} Menu Item</h3>
          <div className="flex gap-2 mb-2">
            {LANGS.map((l) => (
              <button key={l} onClick={() => setLangTab(l)} className={`px-3 py-1 text-sm rounded-lg cursor-pointer ${langTab === l ? 'bg-indigo-100 text-indigo-700 font-medium' : 'text-gray-500 hover:bg-gray-100'}`}>{l.toUpperCase()}</button>
            ))}
          </div>
          <Input placeholder="Item name" value={editingItem.name[langTab] || ''} onChange={(e) => setEditingItem({ ...editingItem, name: { ...editingItem.name, [langTab]: e.target.value } })} />
          <Input placeholder="Description" value={editingItem.description[langTab] || ''} onChange={(e) => setEditingItem({ ...editingItem, description: { ...editingItem.description, [langTab]: e.target.value } })} />
          <div className="grid grid-cols-2 gap-3">
            <Input type="number" placeholder="Price" value={editingItem.price} onChange={(e) => setEditingItem({ ...editingItem, price: Number(e.target.value) })} />
            <Input placeholder="Image URL" value={editingItem.image} onChange={(e) => setEditingItem({ ...editingItem, image: e.target.value })} />
          </div>
          <Input placeholder="Tags (comma-separated)" value={editingItem.tags.join(', ')} onChange={(e) => setEditingItem({ ...editingItem, tags: e.target.value.split(',').map((s) => s.trim()).filter(Boolean) })} />
          <div className="flex gap-2">
            <Button onClick={handleSaveItem} className="bg-indigo-600 hover:bg-indigo-700">Save</Button>
            <Button variant="outline" onClick={() => setEditingItem(null)}>Cancel</Button>
          </div>
        </div>
      )}

      {/* Categories list */}
      <div className="space-y-3">
        {categories.map((cat: MenuCategory) => (
          <div key={cat.id} className="bg-white rounded-xl border border-gray-200">
            <div className="flex items-center justify-between px-5 py-3 cursor-pointer" onClick={() => setExpandedCat(expandedCat === cat.id ? null : cat.id)}>
              <div className="flex items-center gap-2">
                {expandedCat === cat.id ? <ChevronDown size={16} /> : <ChevronRight size={16} />}
                <span className="font-medium text-gray-900">{cat.name.en || Object.values(cat.name)[0]}</span>
                <span className="text-xs text-gray-400">{cat.items.length} items</span>
              </div>
              <div className="flex gap-1" onClick={(e) => e.stopPropagation()}>
                <button onClick={() => setEditingCat({ id: cat.id, name: cat.name, sortOrder: 0 })} className="p-1.5 text-gray-400 hover:text-gray-600 cursor-pointer"><Pencil size={14} /></button>
                <button onClick={() => handleDeleteCategory(cat.id)} className="p-1.5 text-gray-400 hover:text-red-600 cursor-pointer"><Trash2 size={14} /></button>
                <Button size="sm" variant="outline" onClick={() => setEditingItem({ categoryId: cat.id, name: { en: '' }, description: { en: '' }, price: 0, image: '', tags: [], sortOrder: 0 })}>
                  <Plus size={14} className="mr-1" /> Item
                </Button>
              </div>
            </div>
            {expandedCat === cat.id && (
              <div className="border-t border-gray-100 divide-y divide-gray-50">
                {cat.items.map((item: MenuItem) => (
                  <div key={item.id} className="px-5 py-3 flex items-center justify-between">
                    <div>
                      <p className="text-sm font-medium text-gray-900">{item.name.en || Object.values(item.name)[0]}</p>
                      <p className="text-xs text-gray-500">{item.price.toLocaleString()} AMD{item.tags.length > 0 && ` · ${item.tags.join(', ')}`}</p>
                    </div>
                    <div className="flex gap-1">
                      <button onClick={() => setEditingItem({ id: item.id, categoryId: cat.id, name: item.name, description: item.description || {}, price: item.price, image: item.image || '', tags: item.tags, sortOrder: 0 })} className="p-1.5 text-gray-400 hover:text-gray-600 cursor-pointer"><Pencil size={14} /></button>
                      <button onClick={() => handleDeleteItem(item.id)} className="p-1.5 text-gray-400 hover:text-red-600 cursor-pointer"><Trash2 size={14} /></button>
                    </div>
                  </div>
                ))}
                {cat.items.length === 0 && <p className="px-5 py-3 text-sm text-gray-400">No items in this category.</p>}
              </div>
            )}
          </div>
        ))}
        {categories.length === 0 && <p className="text-gray-500 text-sm">No menu categories yet. Add one to get started.</p>}
      </div>
    </div>
  )
}
