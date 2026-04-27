import { useState, useEffect, useRef, useCallback } from 'react'
import { useNavigate } from 'react-router-dom'
import { Search, X } from 'lucide-react'
import { useVenueStore } from '@/store/venueStore'
import { apiFetch } from '@/lib/api'
import { cn } from '@/lib/utils'
import type { Venue } from '@/types'

interface SearchAutocompleteProps {
  onSearch: (query: string) => void
  placeholder?: string
  className?: string
  initialValue?: string
}

interface DishResult {
  venue: Venue
  query: string
}

export function SearchAutocomplete({
  onSearch,
  placeholder = 'Search restaurants or dishes...',
  className,
  initialValue = '',
}: SearchAutocompleteProps) {
  const navigate = useNavigate()
  const { venues } = useVenueStore()
  const [query, setQuery] = useState(initialValue)
  const [open, setOpen] = useState(false)
  const [activeIndex, setActiveIndex] = useState(-1)
  const [restaurantResults, setRestaurantResults] = useState<Venue[]>([])
  const [dishResults, setDishResults] = useState<DishResult[]>([])
  const [dishLoading, setDishLoading] = useState(false)
  const containerRef = useRef<HTMLDivElement>(null)
  const inputRef = useRef<HTMLInputElement>(null)
  const debounceRef = useRef<ReturnType<typeof setTimeout> | null>(null)

  // Close on click outside
  useEffect(() => {
    const handleClickOutside = (e: MouseEvent) => {
      if (containerRef.current && !containerRef.current.contains(e.target as Node)) {
        setOpen(false)
      }
    }
    document.addEventListener('mousedown', handleClickOutside)
    return () => document.removeEventListener('mousedown', handleClickOutside)
  }, [])

  // Sync initialValue
  useEffect(() => {
    setQuery(initialValue)
  }, [initialValue])

  // Debounced search
  const performSearch = useCallback(
    (value: string) => {
      if (!value || value.length < 1) {
        setRestaurantResults([])
        setDishResults([])
        setOpen(false)
        return
      }

      // Restaurant matches (immediate, from local store)
      const q = value.toLowerCase()
      const matched = venues
        .filter(
          (v) =>
            v.name.toLowerCase().includes(q) ||
            v.cuisine.some((c) => c.toLowerCase().includes(q))
        )
        .slice(0, 4)
      setRestaurantResults(matched)

      // Dish search (API call, debounced)
      if (value.length >= 2) {
        setDishLoading(true)
        apiFetch<Venue[]>(`/api/venues/search?dish=${encodeURIComponent(value)}`)
          .then((results) => {
            // Exclude venues already shown in restaurant results
            const matchedIds = new Set(matched.map((v) => v.id))
            const dishVenues = results
              .filter((v) => !matchedIds.has(v.id))
              .slice(0, 3)
            setDishResults(dishVenues.map((v) => ({ venue: v, query: value })))
            setDishLoading(false)
          })
          .catch(() => {
            setDishResults([])
            setDishLoading(false)
          })
      } else {
        setDishResults([])
      }

      setOpen(true)
      setActiveIndex(-1)
    },
    [venues]
  )

  const handleChange = (value: string) => {
    setQuery(value)
    onSearch(value)

    if (debounceRef.current) clearTimeout(debounceRef.current)
    debounceRef.current = setTimeout(() => performSearch(value), 200)
  }

  const handleClear = () => {
    setQuery('')
    onSearch('')
    setRestaurantResults([])
    setDishResults([])
    setOpen(false)
    inputRef.current?.focus()
  }

  const allItems = [
    ...restaurantResults.map((v) => ({ type: 'restaurant' as const, venue: v })),
    ...dishResults.map((d) => ({ type: 'dish' as const, venue: d.venue, dishQuery: d.query })),
  ]

  const handleSelect = (item: (typeof allItems)[number]) => {
    setOpen(false)
    navigate(`/venue/${item.venue.slug}`)
  }

  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (!open || allItems.length === 0) {
      if (e.key === 'Enter') {
        e.preventDefault()
        setOpen(false)
        onSearch(query)
      }
      return
    }

    switch (e.key) {
      case 'ArrowDown':
        e.preventDefault()
        setActiveIndex((prev) => (prev < allItems.length - 1 ? prev + 1 : 0))
        break
      case 'ArrowUp':
        e.preventDefault()
        setActiveIndex((prev) => (prev > 0 ? prev - 1 : allItems.length - 1))
        break
      case 'Enter':
        e.preventDefault()
        if (activeIndex >= 0 && activeIndex < allItems.length) {
          handleSelect(allItems[activeIndex])
        } else {
          setOpen(false)
          onSearch(query)
        }
        break
      case 'Escape':
        setOpen(false)
        setActiveIndex(-1)
        break
    }
  }

  const hasResults = restaurantResults.length > 0 || dishResults.length > 0

  return (
    <div ref={containerRef} className={cn('relative', className)}>
      <div className="relative">
        <Search
          size={18}
          className="absolute left-3.5 top-1/2 -translate-y-1/2 text-text-tertiary pointer-events-none"
        />
        <input
          ref={inputRef}
          type="text"
          value={query}
          onChange={(e) => handleChange(e.target.value)}
          onKeyDown={handleKeyDown}
          onFocus={() => {
            if (query && hasResults) setOpen(true)
          }}
          placeholder={placeholder}
          className="w-full pl-11 pr-10 py-3 rounded-full border border-border bg-white text-sm focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary dark:bg-gray-800 dark:border-gray-700 dark:text-gray-100"
          autoComplete="off"
        />
        {query && (
          <button
            onClick={handleClear}
            className="absolute right-3.5 top-1/2 -translate-y-1/2 text-text-tertiary hover:text-text-primary cursor-pointer p-0.5"
          >
            <X size={16} />
          </button>
        )}
      </div>

      {/* Dropdown */}
      {open && (hasResults || dishLoading) && (
        <div className="absolute top-full left-0 right-0 mt-1 bg-white dark:bg-gray-800 rounded-xl border border-border shadow-lg z-50 overflow-hidden max-h-[400px] overflow-y-auto">
          {/* Restaurant section */}
          {restaurantResults.length > 0 && (
            <div>
              <div className="px-3 py-2 text-xs font-semibold text-text-tertiary uppercase tracking-wide">
                Restaurants
              </div>
              {restaurantResults.map((venue, i) => {
                const itemIndex = i
                return (
                  <button
                    key={venue.id}
                    onClick={() => handleSelect({ type: 'restaurant', venue })}
                    className={cn(
                      'w-full flex items-center gap-3 px-3 py-2.5 text-left transition-colors cursor-pointer',
                      activeIndex === itemIndex
                        ? 'bg-primary/10'
                        : 'hover:bg-surface'
                    )}
                  >
                    {venue.images[0] ? (
                      <img
                        src={venue.images[0]}
                        alt={venue.name}
                        className="w-10 h-10 rounded-lg object-cover shrink-0"
                      />
                    ) : (
                      <div className="w-10 h-10 rounded-lg bg-surface shrink-0" />
                    )}
                    <div className="min-w-0 flex-1">
                      <p className="text-sm font-medium text-text-primary truncate">
                        {venue.name}
                      </p>
                      <p className="text-xs text-text-tertiary truncate">
                        {venue.cuisine.join(', ')}
                      </p>
                    </div>
                    <span className="text-xs text-text-tertiary shrink-0">
                      {venue.rating} ★
                    </span>
                  </button>
                )
              })}
            </div>
          )}

          {/* Dish section */}
          {dishResults.length > 0 && (
            <div>
              {restaurantResults.length > 0 && (
                <div className="h-px bg-border mx-3" />
              )}
              <div className="px-3 py-2 text-xs font-semibold text-text-tertiary uppercase tracking-wide">
                Dishes
              </div>
              {dishResults.map((d, i) => {
                const itemIndex = restaurantResults.length + i
                return (
                  <button
                    key={d.venue.id}
                    onClick={() =>
                      handleSelect({ type: 'dish', venue: d.venue, dishQuery: d.query })
                    }
                    className={cn(
                      'w-full flex items-center gap-3 px-3 py-2.5 text-left transition-colors cursor-pointer',
                      activeIndex === itemIndex
                        ? 'bg-primary/10'
                        : 'hover:bg-surface'
                    )}
                  >
                    {d.venue.images[0] ? (
                      <img
                        src={d.venue.images[0]}
                        alt={d.venue.name}
                        className="w-10 h-10 rounded-lg object-cover shrink-0"
                      />
                    ) : (
                      <div className="w-10 h-10 rounded-lg bg-surface shrink-0" />
                    )}
                    <div className="min-w-0 flex-1">
                      <p className="text-sm font-medium text-text-primary truncate">
                        {d.venue.name}
                      </p>
                      <p className="text-xs text-primary truncate">
                        serves &ldquo;{d.query}&rdquo;
                      </p>
                    </div>
                  </button>
                )
              })}
            </div>
          )}

          {/* Loading state for dishes */}
          {dishLoading && dishResults.length === 0 && restaurantResults.length > 0 && (
            <div className="px-3 py-2 text-xs text-text-tertiary">
              Searching dishes...
            </div>
          )}
        </div>
      )}
    </div>
  )
}
