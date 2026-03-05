import { useTranslation } from 'react-i18next'
import { Plus, Minus } from 'lucide-react'
import { motion } from 'framer-motion'
import type { Venue, MenuItem } from '@/types'
import { useCartStore } from '@/store/cartStore'
import { formatPrice } from '@/lib/utils'

interface VenueMenuProps {
  venue: Venue
}

export function VenueMenu({ venue }: VenueMenuProps) {
  const { i18n } = useTranslation()
  const { items: cartItems, addItem, removeItem, updateQuantity } =
    useCartStore()
  const lang = i18n.language

  const getCartQuantity = (itemId: string) => {
    return cartItems.find((i) => i.menuItem.id === itemId)?.quantity || 0
  }

  return (
    <div className="space-y-8">
      {venue.menu.map((category) => (
        <div key={category.id}>
          <h3 className="text-lg font-semibold mb-4">
            {category.name[lang] || category.name.en}
          </h3>
          <div className="space-y-3">
            {category.items.map((item) => (
              <MenuItemCard
                key={item.id}
                item={item}
                lang={lang}
                quantity={getCartQuantity(item.id)}
                onAdd={() => addItem(item, venue.id)}
                onRemove={() => {
                  const qty = getCartQuantity(item.id)
                  if (qty > 1) updateQuantity(item.id, qty - 1)
                  else removeItem(item.id)
                }}
              />
            ))}
          </div>
        </div>
      ))}
    </div>
  )
}

function MenuItemCard({
  item,
  lang,
  quantity,
  onAdd,
  onRemove,
}: {
  item: MenuItem
  lang: string
  quantity: number
  onAdd: () => void
  onRemove: () => void
}) {
  return (
    <motion.div
      layout
      className="flex items-center justify-between p-3 rounded-[12px] border border-border-light hover:border-border transition-colors"
    >
      <div className="flex-1 min-w-0 mr-4">
        <div className="flex items-center gap-2">
          <h4 className="font-medium text-sm">
            {item.name[lang] || item.name.en}
          </h4>
          {item.tags.map((tag) => (
            <span
              key={tag}
              className="text-[10px] px-1.5 py-0.5 rounded-full bg-green-50 text-green-700"
            >
              {tag}
            </span>
          ))}
        </div>
        <p className="text-xs text-text-secondary mt-0.5 truncate">
          {item.description[lang] || item.description.en}
        </p>
        <p className="text-sm font-semibold text-primary mt-1">
          {formatPrice(item.price)}
        </p>
      </div>

      <div className="flex items-center gap-2">
        {quantity > 0 ? (
          <div className="flex items-center gap-2 bg-primary/10 rounded-full px-1">
            <button
              onClick={onRemove}
              className="w-7 h-7 flex items-center justify-center rounded-full hover:bg-primary/20 transition-colors cursor-pointer"
            >
              <Minus size={14} className="text-primary" />
            </button>
            <span className="text-sm font-medium text-primary w-4 text-center">
              {quantity}
            </span>
            <button
              onClick={onAdd}
              className="w-7 h-7 flex items-center justify-center rounded-full hover:bg-primary/20 transition-colors cursor-pointer"
            >
              <Plus size={14} className="text-primary" />
            </button>
          </div>
        ) : (
          <button
            onClick={onAdd}
            className="w-8 h-8 flex items-center justify-center rounded-full border border-border hover:border-primary hover:text-primary transition-colors cursor-pointer"
          >
            <Plus size={16} />
          </button>
        )}
      </div>
    </motion.div>
  )
}
