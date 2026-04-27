import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { useVenueStore } from '@/store/venueStore'
import { cn } from '@/lib/utils'

interface DietaryOption {
  label: string
  tag: string
  icon: string
}

const dietaryOptions: DietaryOption[] = [
  { label: 'Vegan', tag: 'Vegan', icon: '\u{1F331}' },
  { label: 'Vegetarian', tag: 'Vegetarian', icon: '\u{1F96C}' },
  { label: 'Halal', tag: 'Halal', icon: '\u{262A}\u{FE0F}' },
  { label: 'Gluten-Free', tag: 'Gluten-Free', icon: '\u{1F33E}' },
  { label: 'Seafood-Free', tag: 'Seafood-Free', icon: '\u{1F6AB}' },
]

export function DietaryFilters() {
  const navigate = useNavigate()
  const { setFilters } = useVenueStore()
  const [selected, setSelected] = useState<string[]>([])

  const toggle = (tag: string) => {
    const next = selected.includes(tag)
      ? selected.filter((t) => t !== tag)
      : [...selected, tag]
    setSelected(next)

    if (next.length > 0) {
      setFilters({ dietaryTags: next })
      navigate('/search')
    } else {
      setFilters({ dietaryTags: [] })
    }
  }

  return (
    <div
      className="flex gap-2.5 overflow-x-auto pb-1 scrollbar-hide"
      style={{ scrollbarWidth: 'none', msOverflowStyle: 'none' }}
    >
      {dietaryOptions.map((opt) => {
        const active = selected.includes(opt.tag)
        return (
          <button
            key={opt.tag}
            onClick={() => toggle(opt.tag)}
            className={cn(
              'flex items-center gap-1.5 px-3.5 py-2 rounded-full border text-sm font-medium whitespace-nowrap transition-all cursor-pointer shrink-0',
              active
                ? 'border-primary bg-primary/10 text-primary'
                : 'border-border bg-white text-text-secondary hover:border-text-primary hover:bg-surface dark:bg-gray-800 dark:border-gray-700'
            )}
          >
            <span>{opt.icon}</span>
            <span>{opt.label}</span>
          </button>
        )
      })}
    </div>
  )
}
