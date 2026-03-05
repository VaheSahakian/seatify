import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import { Search, ChevronRight } from 'lucide-react'
import { motion } from 'framer-motion'
import { VenueCard } from '@/components/venue/VenueCard'
import { useVenueStore } from '@/store/venueStore'

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

export default function Home() {
  const { t } = useTranslation()
  const navigate = useNavigate()
  const { venues, fetchVenues, setFilters } = useVenueStore()
  const [query, setQuery] = useState('')

  useEffect(() => {
    fetchVenues()
  }, [fetchVenues])

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault()
    setFilters({ query })
    navigate('/search')
  }

  const handleCuisine = (cuisine: string) => {
    setFilters({ cuisine: [cuisine], query: '' })
    navigate('/search')
  }

  return (
    <div>
      {/* Hero */}
      <section className="relative bg-gradient-to-b from-primary/5 to-transparent">
        <div className="max-w-7xl mx-auto px-4 pt-12 pb-8">
          <motion.h1
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            className="text-3xl sm:text-4xl font-bold text-text-primary mb-2"
          >
            {t('home.hero_title')}
          </motion.h1>
          <motion.p
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.1 }}
            className="text-text-secondary mb-6"
          >
            {t('home.hero_subtitle')}
          </motion.p>

          <motion.form
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.2 }}
            onSubmit={handleSearch}
            className="relative max-w-xl"
          >
            <Search
              size={20}
              className="absolute left-4 top-1/2 -translate-y-1/2 text-text-tertiary"
            />
            <input
              type="text"
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              placeholder={t('home.search_placeholder')}
              className="w-full pl-12 pr-4 py-4 rounded-full border border-border bg-white shadow-md focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary text-sm"
            />
          </motion.form>
        </div>
      </section>

      {/* Categories */}
      <section className="max-w-7xl mx-auto px-4 py-8">
        <h2 className="text-xl font-semibold mb-4">{t('home.categories')}</h2>
        <div className="flex gap-2 overflow-x-auto no-scrollbar pb-2">
          {cuisineCategories.slice(0, 8).map((cuisine) => (
            <button
              key={cuisine}
              onClick={() => handleCuisine(cuisine)}
              className="px-4 py-2 rounded-full bg-surface text-sm font-medium text-text-secondary hover:bg-primary hover:text-white transition-colors whitespace-nowrap shrink-0 cursor-pointer"
            >
              {cuisine}
            </button>
          ))}
        </div>
      </section>

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
          {venues.slice(0, 3).map((venue, i) => (
            <VenueCard key={venue.id} venue={venue} index={i} />
          ))}
        </div>
      </section>

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
          {venues.slice(3, 6).map((venue, i) => (
            <VenueCard key={venue.id} venue={venue} index={i} />
          ))}
        </div>
      </section>
    </div>
  )
}
