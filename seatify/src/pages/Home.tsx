import { useEffect } from 'react'
import { useNavigate, Link } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import { ChevronRight, Clock, Star } from 'lucide-react'
import { motion } from 'framer-motion'
import { VenueCard } from '@/components/venue/VenueCard'
import { PageTransition } from '@/components/layout/PageTransition'
import { VenueCardSkeleton } from '@/components/venue/VenueCardSkeleton'
import { FoodCategories } from '@/components/home/FoodCategories'
import { DietaryFilters } from '@/components/home/DietaryFilters'
import { HeroCarousel } from '@/components/home/HeroCarousel'
import { AIRecommendations } from '@/components/home/AIRecommendations'
import { SearchAutocomplete } from '@/components/common/SearchAutocomplete'
import { useVenueStore } from '@/store/venueStore'
import { useRecentStore } from '@/store/recentStore'

export default function Home() {
  const { t } = useTranslation()
  const navigate = useNavigate()
  const { venues, fetchVenues, setFilters, loading } = useVenueStore()
  const { items: recentItems } = useRecentStore()

  useEffect(() => {
    fetchVenues()
  }, [fetchVenues])

  const handleSearch = (query: string) => {
    // Called on Enter or form-level submit behavior from autocomplete
  }

  const handleSearchSubmit = (query: string) => {
    setFilters({ query })
    navigate('/search')
  }

  const showSkeletons = loading || venues.length === 0

  return (
    <PageTransition>
    <div>
      {/* Hero Carousel */}
      <section className="max-w-7xl mx-auto px-4 pt-6">
        <HeroCarousel />
      </section>

      {/* Title + Search */}
      <section className="max-w-7xl mx-auto px-4 pt-6 pb-4">
        <motion.h1
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          className="text-2xl sm:text-3xl font-bold text-text-primary mb-1"
        >
          {t('home.hero_title')}
        </motion.h1>
        <motion.p
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="text-text-secondary mb-4 text-sm"
        >
          {t('home.hero_subtitle')}
        </motion.p>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.2 }}
          className="max-w-xl"
        >
          <SearchAutocomplete
            onSearch={handleSearchSubmit}
            placeholder={t('home.search_placeholder')}
            className="w-full"
          />
        </motion.div>
      </section>

      {/* Food Categories */}
      <section className="max-w-7xl mx-auto px-4 py-6">
        <h2 className="text-xl font-semibold mb-4">{t('home.categories')}</h2>
        <FoodCategories />
      </section>

      {/* Dietary Filters */}
      <section className="max-w-7xl mx-auto px-4 pb-6">
        <h2 className="text-sm font-semibold text-text-secondary mb-3">Dietary Preferences</h2>
        <DietaryFilters />
      </section>

      {/* Recently Viewed */}
      {recentItems.length > 0 && (
        <section className="max-w-7xl mx-auto px-4 pb-6">
          <div className="flex items-center gap-2 mb-4">
            <Clock size={18} className="text-text-secondary" />
            <h2 className="text-xl font-semibold">Recently Viewed</h2>
          </div>
          <div
            className="flex gap-4 overflow-x-auto pb-2 scrollbar-hide"
            style={{ scrollbarWidth: 'none', msOverflowStyle: 'none' }}
          >
            {recentItems.map((item) => (
              <Link
                key={item.id}
                to={`/venue/${item.slug}`}
                className="flex flex-col items-center shrink-0 group"
              >
                <div className="w-20 h-20 rounded-lg overflow-hidden mb-1.5">
                  {item.image ? (
                    <img
                      src={item.image}
                      alt={item.name}
                      className="w-full h-full object-cover group-hover:scale-105 transition-transform"
                    />
                  ) : (
                    <div className="w-full h-full bg-surface" />
                  )}
                </div>
                <p className="text-xs font-medium text-text-primary text-center truncate max-w-[100px] group-hover:text-primary transition-colors">
                  {item.name}
                </p>
                <div className="flex items-center gap-0.5">
                  <Star size={10} className="fill-primary text-primary" />
                  <span className="text-[10px] text-text-tertiary">{item.rating}</span>
                </div>
              </Link>
            ))}
          </div>
        </section>
      )}

      {/* Featured */}
      <section className="max-w-7xl mx-auto px-4 pb-8">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-xl font-semibold">{t('home.featured')}</h2>
          <button
            onClick={() => navigate('/search')}
            className="flex items-center gap-1 text-sm text-primary font-medium hover:underline cursor-pointer"
          >
            {t('home.view_all')}
            <ChevronRight size={16} />
          </button>
        </div>
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {showSkeletons
            ? Array.from({ length: 3 }).map((_, i) => (
                <VenueCardSkeleton key={i} />
              ))
            : venues.slice(0, 3).map((venue, i) => (
                <VenueCard key={venue.id} venue={venue} index={i} />
              ))}
        </div>
      </section>

      {/* Recommended for You */}
      <AIRecommendations />

      {/* Near You */}
      <section className="max-w-7xl mx-auto px-4 pb-12">
        <div className="flex items-center justify-between mb-4">
          <h2 className="text-xl font-semibold">{t('home.near_you')}</h2>
          <button
            onClick={() => navigate('/search')}
            className="flex items-center gap-1 text-sm text-primary font-medium hover:underline cursor-pointer"
          >
            {t('home.view_all')}
            <ChevronRight size={16} />
          </button>
        </div>
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          {showSkeletons
            ? Array.from({ length: 3 }).map((_, i) => (
                <VenueCardSkeleton key={i} />
              ))
            : venues.slice(3, 6).map((venue, i) => (
                <VenueCard key={venue.id} venue={venue} index={i} />
              ))}
        </div>
      </section>
    </div>
    </PageTransition>
  )
}
