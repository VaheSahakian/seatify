import { useState } from 'react'
import { useTranslation } from 'react-i18next'
import { SlidersHorizontal, X, Star } from 'lucide-react'
import { Button } from '@/components/ui/button'
import { Dialog } from '@/components/ui/dialog'
import { useVenueStore } from '@/store/venueStore'
import { cn } from '@/lib/utils'

const cuisineCategories = [
  'Armenian',
  'Italian',
  'Pasta',
  'Pizza',
  'Fast Food',
  'American',
  'BBQ',
  'Kebab',
  'Salads',
  'Wine',
  'Vegan',
  'Desserts',
  'Cafe',
]

export function SearchFilters() {
  const { t } = useTranslation()
  const { filters, setFilters, resetFilters } = useVenueStore()
  const [open, setOpen] = useState(false)
  const [localFilters, setLocalFilters] = useState(filters)

  const handleOpen = () => {
    setLocalFilters(filters)
    setOpen(true)
  }

  const handleApply = () => {
    setFilters(localFilters)
    setOpen(false)
  }

  const toggleCuisine = (cuisine: string) => {
    setLocalFilters((f) => ({
      ...f,
      cuisine: f.cuisine.includes(cuisine)
        ? f.cuisine.filter((c) => c !== cuisine)
        : [...f.cuisine, cuisine],
    }))
  }

  const togglePrice = (price: number) => {
    setLocalFilters((f) => ({
      ...f,
      priceRange: f.priceRange.includes(price)
        ? f.priceRange.filter((p) => p !== price)
        : [...f.priceRange, price],
    }))
  }

  const hasActiveFilters =
    filters.cuisine.length > 0 || filters.priceRange.length > 0 || filters.minRating > 0 || filters.openNow

  return (
    <>
      <button
        onClick={handleOpen}
        className={cn(
          'flex items-center gap-2 px-4 py-2 rounded-full border transition-colors cursor-pointer',
          hasActiveFilters
            ? 'border-primary bg-primary/5 text-primary'
            : 'border-border text-text-secondary hover:border-text-primary'
        )}
      >
        <SlidersHorizontal size={16} />
        <span className="text-sm font-medium">{t('common.filters')}</span>
      </button>

      <Dialog open={open} onClose={() => setOpen(false)} className="max-w-lg">
        <h2 className="text-lg font-semibold mb-6">{t('common.filters')}</h2>

        <div className="space-y-6">
          <div>
            <h3 className="text-sm font-medium text-text-secondary mb-3">
              Cuisine
            </h3>
            <div className="flex flex-wrap gap-2">
              {cuisineCategories.map((c) => (
                <button
                  key={c}
                  onClick={() => toggleCuisine(c)}
                  className={cn(
                    'px-3 py-1.5 rounded-full text-sm border transition-colors cursor-pointer',
                    localFilters.cuisine.includes(c)
                      ? 'border-primary bg-primary/10 text-primary'
                      : 'border-border text-text-secondary hover:border-text-primary'
                  )}
                >
                  {c}
                </button>
              ))}
            </div>
          </div>

          <div>
            <h3 className="text-sm font-medium text-text-secondary mb-3">
              {t('common.price')}
            </h3>
            <div className="flex gap-2">
              {[1, 2, 3, 4].map((p) => (
                <button
                  key={p}
                  onClick={() => togglePrice(p)}
                  className={cn(
                    'px-4 py-2 rounded-full text-sm border transition-colors cursor-pointer',
                    localFilters.priceRange.includes(p)
                      ? 'border-primary bg-primary/10 text-primary'
                      : 'border-border text-text-secondary hover:border-text-primary'
                  )}
                >
                  {'$'.repeat(p)}
                </button>
              ))}
            </div>
          </div>

          <div>
            <h3 className="text-sm font-medium text-text-secondary mb-3">
              {t('common.rating')}
            </h3>
            <div className="flex gap-2">
              {[0, 3, 3.5, 4, 4.5].map((r) => (
                <button
                  key={r}
                  onClick={() =>
                    setLocalFilters((f) => ({ ...f, minRating: r }))
                  }
                  className={cn(
                    'flex items-center gap-1 px-3 py-2 rounded-full text-sm border transition-colors cursor-pointer',
                    localFilters.minRating === r
                      ? 'border-primary bg-primary/10 text-primary'
                      : 'border-border text-text-secondary hover:border-text-primary'
                  )}
                >
                  {r === 0 ? (
                    'All'
                  ) : (
                    <>
                      <Star size={14} className="fill-current" />
                      {r}+
                    </>
                  )}
                </button>
              ))}
            </div>
          </div>
        </div>

        <div className="flex gap-3 mt-8">
          <Button
            variant="outline"
            className="flex-1"
            onClick={() => {
              resetFilters()
              setOpen(false)
            }}
          >
            <X size={16} className="mr-1" />
            {t('common.clear_filters')}
          </Button>
          <Button className="flex-1" onClick={handleApply}>
            {t('common.apply')}
          </Button>
        </div>
      </Dialog>
    </>
  )
}
