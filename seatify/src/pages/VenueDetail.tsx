import { useEffect, useState, useCallback } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import { Star, MapPin, Phone, ArrowLeft, ChevronUp, Heart } from 'lucide-react'
import { motion } from 'framer-motion'
import { Button } from '@/components/ui/button'
import { Tabs } from '@/components/ui/tabs'
import { VenueMenu } from '@/components/venue/VenueMenu'
import { VenueReviews } from '@/components/venue/VenueReviews'
import { VenueDetails } from '@/components/venue/VenueDetails'
import { FloorPlan } from '@/components/venue/FloorPlan'
import { MapView } from '@/components/map/MapView'
import { CartBar } from '@/components/cart/CartBar'
import { PageTransition } from '@/components/layout/PageTransition'
import { useVenueStore } from '@/store/venueStore'
import { useReservationStore } from '@/store/reservationStore'
import { useFavoriteStore } from '@/store/favoriteStore'
import { useAuthStore } from '@/store/authStore'
import { useRecentStore } from '@/store/recentStore'
import type { Venue } from '@/types'
import { intempoFloor2, floor2Walls } from '@/data/intempoFloor2'

export default function VenueDetail() {
  const { slug } = useParams<{ slug: string }>()
  const navigate = useNavigate()
  const { t, i18n } = useTranslation()
  const { fetchVenueBySlug, getVenueBySlug } = useVenueStore()
  const { setCurrentReservation } = useReservationStore()
  const { isFavorite, toggleFavorite } = useFavoriteStore()
  const { isAuthenticated } = useAuthStore()
  const { addView } = useRecentStore()
  const lang = i18n.language
  const [loading, setLoading] = useState(true)
  const [showScrollTop, setShowScrollTop] = useState(false)
  const [selectedFloor, setSelectedFloor] = useState(1)

  useEffect(() => {
    const onScroll = () => setShowScrollTop(window.scrollY > 400)
    window.addEventListener('scroll', onScroll, { passive: true })
    return () => window.removeEventListener('scroll', onScroll)
  }, [])

  const scrollToTop = useCallback(() => {
    window.scrollTo({ top: 0, behavior: 'smooth' })
  }, [])

  useEffect(() => {
    if (!slug) return
    const cached = getVenueBySlug(slug)
    if (cached?.floorPlan) {
      setLoading(false)
      return
    }
    fetchVenueBySlug(slug).finally(() => setLoading(false))
  }, [slug, fetchVenueBySlug, getVenueBySlug])

  const venue = getVenueBySlug(slug || '')

  // Track recently viewed
  useEffect(() => {
    if (venue) {
      addView({
        id: venue.id,
        slug: venue.slug,
        name: venue.name,
        image: venue.images[0] || '',
        cuisine: venue.cuisine,
        rating: venue.rating,
      })
    }
  }, [venue?.id]) // eslint-disable-line react-hooks/exhaustive-deps

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[50vh]">
        <div className="w-8 h-8 border-2 border-primary border-t-transparent rounded-full animate-spin" />
      </div>
    )
  }

  if (!venue) {
    return (
      <div className="flex items-center justify-center min-h-[50vh]">
        <p className="text-text-secondary">Venue not found</p>
      </div>
    )
  }

  const handleReserve = () => {
    setCurrentReservation({
      venueId: venue.id,
      venueName: venue.name,
      venueImage: venue.images[0],
    })
    navigate(`/reserve/${venue.id}`)
  }

  const tabs = [
    {
      label: t('venue.menu'),
      value: 'menu',
      content: <VenueMenu venue={venue} />,
    },
    {
      label: t('venue.reviews'),
      value: 'reviews',
      content: <VenueReviews venueId={venue.id} />,
    },
    {
      label: t('venue.details'),
      value: 'details',
      content: <VenueDetails venue={venue} />,
    },
    {
      label: t('venue.floor_plan'),
      value: 'floorplan',
      content: (
        <div>
          {venue.slug === 'intempo' && (
            <div className="flex gap-1 p-1 bg-gray-100 rounded-full w-fit mb-4">
              <button
                onClick={() => setSelectedFloor(1)}
                className={`px-4 py-1.5 rounded-full text-sm font-medium transition-colors cursor-pointer ${selectedFloor === 1 ? 'bg-primary text-white' : 'text-text-secondary hover:text-text-primary'}`}
              >1st Floor</button>
              <button
                onClick={() => setSelectedFloor(2)}
                className={`px-4 py-1.5 rounded-full text-sm font-medium transition-colors cursor-pointer ${selectedFloor === 2 ? 'bg-primary text-white' : 'text-text-secondary hover:text-text-primary'}`}
              >2nd Floor</button>
            </div>
          )}
          <FloorPlan
            floorPlan={venue.slug === 'intempo' && selectedFloor === 2 ? intempoFloor2 : venue.floorPlan}
            walls={venue.slug === 'intempo' && selectedFloor === 2 ? floor2Walls : undefined}
          />
        </div>
      ),
    },
    {
      label: t('venue.map'),
      value: 'map',
      content: (
        <MapView
          venues={[venue]}
          center={[venue.coordinates.lat, venue.coordinates.lng]}
          zoom={16}
          className="h-[300px] rounded-[16px] overflow-hidden"
        />
      ),
    },
  ]

  const favorited = venue ? isFavorite(venue.id) : false

  return (
    <PageTransition>
    <div>
      {/* Image gallery */}
      <div className="relative">
        <div className="flex overflow-x-auto no-scrollbar snap-x snap-mandatory">
          {venue.images.map((img, i) => (
            <motion.div
              key={i}
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ delay: i * 0.1 }}
              className="w-full shrink-0 snap-center aspect-[16/9] sm:aspect-[2/1]"
            >
              <img
                src={img}
                alt={`${venue.name} ${i + 1}`}
                className="w-full h-full object-cover"
              />
            </motion.div>
          ))}
        </div>
        <button
          onClick={() => navigate(-1)}
          className="absolute top-4 left-4 w-10 h-10 bg-white/90 backdrop-blur-sm rounded-full flex items-center justify-center shadow-md cursor-pointer"
        >
          <ArrowLeft size={20} />
        </button>
      </div>

      <div className="max-w-3xl mx-auto px-4 py-6">
        {/* Header info */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
        >
          <div className="flex items-center gap-3 mb-2">
            <h1 className="text-2xl font-bold">{venue.name}</h1>
            {isAuthenticated && (
              <button
                onClick={() => toggleFavorite(venue.id)}
                className="w-9 h-9 rounded-full border border-border-light flex items-center justify-center cursor-pointer hover:bg-surface transition-colors shrink-0"
              >
                <Heart
                  size={18}
                  className={
                    favorited
                      ? 'fill-red-500 text-red-500'
                      : 'text-text-secondary'
                  }
                />
              </button>
            )}
          </div>
          <div className="flex flex-wrap items-center gap-3 text-sm text-text-secondary mb-2">
            <div className="flex items-center gap-1">
              <Star size={16} className="fill-primary text-primary" />
              <span className="font-medium text-text-primary">
                {venue.rating}
              </span>
              <span>({venue.reviewCount})</span>
            </div>
            <span>·</span>
            <span>{venue.cuisine.join(', ')}</span>
            <span>·</span>
            <span>{'$'.repeat(venue.priceRange)}</span>
          </div>
          <div className="flex items-center gap-1 text-sm text-text-secondary mb-1">
            <MapPin size={14} />
            {venue.address}
          </div>
          <div className="flex items-center gap-1 text-sm text-text-secondary mb-4">
            <Phone size={14} />
            {venue.phone}
          </div>
          <p className="text-sm text-text-secondary leading-relaxed mb-6">
            {venue.description[lang] || venue.description.en}
          </p>
        </motion.div>

        {/* Reserve button */}
        <Button size="lg" className="w-full mb-6" onClick={handleReserve}>
          {t('venue.reserve')}
        </Button>

        {/* Tabs */}
        <Tabs tabs={tabs} defaultValue="menu" />
      </div>

      <CartBar />

      {/* Scroll to top button */}
      {showScrollTop && (
        <button
          onClick={scrollToTop}
          className="fixed bottom-24 right-4 z-50 w-10 h-10 bg-primary text-white rounded-full shadow-lg flex items-center justify-center hover:bg-primary/90 transition-all cursor-pointer animate-in fade-in"
        >
          <ChevronUp size={22} />
        </button>
      )}
    </div>
    </PageTransition>
  )
}
