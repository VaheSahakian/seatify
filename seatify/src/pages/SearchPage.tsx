import { useEffect } from 'react'
import { useTranslation } from 'react-i18next'
import { Search, List, Map as MapIcon } from 'lucide-react'
import { motion } from 'framer-motion'
import { VenueCard } from '@/components/venue/VenueCard'
import { MapView } from '@/components/map/MapView'
import { SearchFilters } from '@/components/common/SearchFilters'
import { useVenueStore } from '@/store/venueStore'
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
  } = useVenueStore()

  useEffect(() => {
    fetchVenues()
  }, [fetchVenues])

  useEffect(() => {
    applyFilters()
  }, [applyFilters])

  return (
    <div className="max-w-7xl mx-auto px-4 py-6">
      {/* Search bar */}
      <div className="flex items-center gap-3 mb-6">
        <div className="relative flex-1">
          <Search
            size={18}
            className="absolute left-3 top-1/2 -translate-y-1/2 text-text-tertiary"
          />
          <input
            type="text"
            value={filters.query}
            onChange={(e) => setFilters({ query: e.target.value })}
            placeholder={t('home.search_placeholder')}
            className="w-full pl-10 pr-4 py-2.5 rounded-full border border-border bg-white text-sm focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary"
          />
        </div>
        <SearchFilters />
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

      {/* Results count */}
      <p className="text-sm text-text-secondary mb-4">
        {filteredVenues.length} results
      </p>

      {viewMode === 'map' ? (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
        >
          <MapView venues={filteredVenues} className="h-[60vh] rounded-[16px] overflow-hidden" />
        </motion.div>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {filteredVenues.map((venue, i) => (
            <VenueCard key={venue.id} venue={venue} index={i} />
          ))}
          {filteredVenues.length === 0 && (
            <div className="col-span-full text-center py-12">
              <p className="text-text-secondary">No venues found</p>
            </div>
          )}
        </div>
      )}
    </div>
  )
}
