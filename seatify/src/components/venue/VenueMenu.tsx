import { useRef, useState, useEffect, useCallback } from 'react'
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

  const [activeCategory, setActiveCategory] = useState(venue.menu[0]?.id ?? '')
  const categoryRefs = useRef<Record<string, HTMLDivElement | null>>({})
  const chipRefs = useRef<Record<string, HTMLButtonElement | null>>({})
  const chipBarRef = useRef<HTMLDivElement>(null)
  const isScrollingTo = useRef(false)

  const getCartQuantity = (itemId: string) => {
    return cartItems.find((i) => i.menuItem.id === itemId)?.quantity || 0
  }

  const scrollChipIntoView = useCallback((catId: string) => {
    const chip = chipRefs.current[catId]
    const bar = chipBarRef.current
    if (chip && bar) {
      const barRect = bar.getBoundingClientRect()
      const chipRect = chip.getBoundingClientRect()
      if (chipRect.left < barRect.left || chipRect.right > barRect.right) {
        chip.scrollIntoView({ behavior: 'smooth', inline: 'center', block: 'nearest' })
      }
    }
  }, [])

  const handleChipClick = (catId: string) => {
    isScrollingTo.current = true
    setActiveCategory(catId)
    scrollChipIntoView(catId)

    const el = categoryRefs.current[catId]
    if (el) {
      const y = el.getBoundingClientRect().top + window.scrollY - 160
      window.scrollTo({ top: y, behavior: 'smooth' })
      setTimeout(() => { isScrollingTo.current = false }, 800)
    }
  }

  useEffect(() => {
    const observer = new IntersectionObserver(
      (entries) => {
        if (isScrollingTo.current) return
        for (const entry of entries) {
          if (entry.isIntersecting) {
            const catId = entry.target.getAttribute('data-cat-id')
            if (catId) {
              setActiveCategory(catId)
              scrollChipIntoView(catId)
            }
            break
          }
        }
      },
      { rootMargin: '-160px 0px -60% 0px', threshold: 0.1 }
    )

    for (const el of Object.values(categoryRefs.current)) {
      if (el) observer.observe(el)
    }
    return () => observer.disconnect()
  }, [venue.menu, scrollChipIntoView])

  return (
    <div>
      {/* Sticky category chips bar */}
      <div
        ref={chipBarRef}
        className="flex gap-2 overflow-x-auto pb-2 mb-6 sticky top-0 bg-white z-10 pt-2 -mt-2 scrollbar-hide"
        style={{ scrollbarWidth: 'none', msOverflowStyle: 'none' }}
      >
        {venue.menu.map((category) => (
          <button
            key={category.id}
            ref={(el) => { chipRefs.current[category.id] = el }}
            onClick={() => handleChipClick(category.id)}
            className={`whitespace-nowrap px-4 py-1.5 rounded-full text-sm font-medium transition-colors cursor-pointer shrink-0 ${
              activeCategory === category.id
                ? 'bg-primary text-white'
                : 'bg-gray-100 text-text-secondary hover:bg-gray-200'
            }`}
          >
            {category.name[lang] || category.name.en}
          </button>
        ))}
      </div>

      {/* Menu sections */}
      <div className="space-y-8">
        {venue.menu.map((category) => (
          <div
            key={category.id}
            ref={(el) => { categoryRefs.current[category.id] = el }}
            data-cat-id={category.id}
          >
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
          {item.description ? (item.description[lang] || item.description.en) : ''}
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
