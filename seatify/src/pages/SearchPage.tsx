import { useEffect, useRef, useCallback } from 'react'
import { useTranslation } from 'react-i18next'
import { List, Map as MapIcon, MapPin, Clock } from 'lucide-react'
import { motion } from 'framer-motion'
import { VenueCard } from '@/components/venue/VenueCard'
import { PageTransition } from '@/components/layout/PageTransition'
import { VenueCardSkeleton } from '@/components/venue/VenueCardSkeleton'
import { MapView } from '@/components/map/MapView'
import { SearchFilters } from '@/components/common/SearchFilters'
import { SearchAutocomplete } from '@/components/common/SearchAutocomplete'
import { EmptyState } from '@/components/common/EmptyState'
import { useVenueStore } from '@/store/venueStore'
import { getUserLocation } from '@/lib/geo'
import { cn } from '@/lib/utils'

export default function SearchPage() {
  const { t } = useTranslation()
  const {
    filteredVenues,
    filters,
    setFilters,
    viewMode,
    setViewMode,
    fetchVenues,
    applyFilters,
    loading,
    userLocation,
    setUserLocation,
    dishSearchResults,
    dishSearchLoading,
    searchByDish,
    clearDishSearch,
    resetFilters,
  } = useVenueStore()

  const dishSearchTimer = useRef<ReturnType<typeof setTimeout> | null>(null)

  useEffect(() => {
    fetchVenues()
  }, [fetchVenues])

  useEffect(() => {
    applyFilters()
  }, [applyFilters])

  // Debounced dish search when query changes
  const handleQueryChange = useCallback(
    (value: string) => {
      setFilters({ query: value })

      if (dishSearchTimer.current) clearTimeout(dishSearchTimer.current)

      if (!value || value.length < 2) {
        clearDishSearch()
        return
      }

      dishSearchTimer.current = setTimeout(() => {
        searchByDish(value)
      }, 400)
    },
    [setFilters, searchByDish, clearDishSearch]
  )

  const handleSortByDistance = async () => {
    if (filters.sortBy === 'distance') {
      setFilters({ sortBy: 'rating' })
      return
    }
    if (!userLocation) {
      const loc = await getUserLocation()
      if (loc) {
        setUserLocation(loc)
      } else {
        return // Could not get location
      }
    }
    setFilters({ sortBy: 'distance' })
  }

  const toggleOpenNow = () => {
    setFilters({ openNow: !filters.openNow })
  }

  // Compute dish-only results (not already in filtered venues)
  const filteredIds = new Set(filteredVenues.map((v) => v.id))
  const extraDishMatches = dishSearchResults.filter((v) => !filteredIds.has(v.id))

  return (
    <PageTransition>
    <div className="max-w-7xl mx-auto px-4 py-6">
      {/* Search bar */}
      <div className="flex items-center gap-3 mb-2">
        <SearchAutocomplete
          onSearch={handleQueryChange}
          placeholder="Search restaurants or dishes..."
          className="flex-1"
          initialValue={filters.query}
        />

        {/* Open Now toggle */}
        <button
          onClick={toggleOpenNow}
          className={cn(
            'flex items-center gap-2 px-4 py-2 rounded-full border transition-colors cursor-pointer shrink-0',
            filters.openNow
              ? 'border-green-500 bg-green-50 text-green-700'
              : 'border-border text-text-secondary hover:border-text-primary'
          )}
        >
          {filters.openNow ? (
            <span className="relative flex h-2.5 w-2.5">
              <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-green-400 opacity-75" />
              <span className="relative inline-flex rounded-full h-2.5 w-2.5 bg-green-500" />
            </span>
          ) : (
            <Clock size={14} />
          )}
          <span className="text-sm font-medium">Open Now</span>
        </button>

        <SearchFilters />

        {/* Sort buttons */}
        <div className="flex items-center border border-border rounded-full overflow-hidden">
          <button
            onClick={() => setFilters({ sortBy: 'rating' })}
            className={cn(
              'px-3 py-2 text-xs font-medium transition-colors cursor-pointer',
              filters.sortBy === 'rating'
                ? 'bg-primary text-white'
                : 'text-text-secondary hover:bg-surface'
            )}
          >
            Top Rated
          </button>
          <button
            onClick={() => setFilters({ sortBy: 'price' })}
            className={cn(
              'px-3 py-2 text-xs font-medium transition-colors cursor-pointer',
              filters.sortBy === 'price'
                ? 'bg-primary text-white'
                : 'text-text-secondary hover:bg-surface'
            )}
          >
            Price
          </button>
          <button
            onClick={handleSortByDistance}
            className={cn(
              'flex items-center gap-1 px-3 py-2 text-xs font-medium transition-colors cursor-pointer',
              filters.sortBy === 'distance'
                ? 'bg-primary text-white'
                : 'text-text-secondary hover:bg-surface'
            )}
          >
            <MapPin size={12} />
            Nearest
          </button>
        </div>

        {/* View mode */}
        <div className="flex items-center border border-border rounded-full overflow-hidden">
          <button
            onClick={() => setViewMode('list')}
            className={cn(
              'p-2 transition-colors cursor-pointer',
              viewMode === 'list'
                ? 'bg-primary text-white'
                : 'text-text-secondary hover:bg-surface'
            )}
          >
            <List size={18} />
          </button>
          <button
            onClick={() => setViewMode('map')}
            className={cn(
              'p-2 transition-colors cursor-pointer',
              viewMode === 'map'
                ? 'bg-primary text-white'
                : 'text-text-secondary hover:bg-surface'
            )}
          >
            <MapIcon size={18} />
          </button>
        </div>
      </div>

      {/* Search hint */}
      {filters.query && (
        <p className="text-xs text-text-tertiary mb-3 ml-1">
          Searching by restaurant name and dish name
        </p>
      )}

      {/* Results count */}
      <p className="text-sm text-text-secondary mb-4">
        {filteredVenues.length + extraDishMatches.length} results
        {filters.openNow && ' (open now)'}
      </p>

      {viewMode === 'map' ? (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
        >
          <MapView venues={[...filteredVenues, ...extraDishMatches]} className="h-[60vh] rounded-[16px] overflow-hidden" />
        </motion.div>
      ) : (
        <div>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            {loading
              ? Array.from({ length: 6 }).map((_, i) => (
                  <VenueCardSkeleton key={i} />
                ))
              : filteredVenues.map((venue, i) => (
                  <VenueCard key={venue.id} venue={venue} index={i} />
                ))}
          </div>

          {/* Dish search results section */}
          {!loading && extraDishMatches.length > 0 && (
            <div className="mt-8">
              <div className="flex items-center gap-2 mb-4">
                <div className="h-px flex-1 bg-border" />
                <span className="text-sm font-medium text-text-secondary px-2">
                  Serves dishes matching &ldquo;{filters.query}&rdquo;
                </span>
                <div className="h-px flex-1 bg-border" />
              </div>
              <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                {extraDishMatches.map((venue, i) => (
                  <VenueCard key={venue.id} venue={venue} index={filteredVenues.length + i} />
                ))}
              </div>
            </div>
          )}

          {dishSearchLoading && filters.query && (
            <p className="text-sm text-text-tertiary text-center py-4">
              Searching dishes...
            </p>
          )}

          {!loading && filteredVenues.length === 0 && extraDishMatches.length === 0 && (
            <EmptyState
              icon="🔍"
              title="No restaurants found"
              description="Try adjusting your filters or search for something else"
              action={
                <button
                  onClick={() => resetFilters()}
                  className="px-5 py-2.5 bg-primary text-white rounded-full text-sm font-medium hover:bg-primary/90 transition-colors cursor-pointer"
                >
                  Reset Filters
                </button>
              }
            />
          )}
        </div>
      )}
    </div>
    </PageTransition>
  )
}
