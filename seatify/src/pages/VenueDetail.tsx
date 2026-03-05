import { useEffect, useState } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import { Star, MapPin, Phone, ArrowLeft } from 'lucide-react'
import { motion } from 'framer-motion'
import { Button } from '@/components/ui/button'
import { Tabs } from '@/components/ui/tabs'
import { VenueMenu } from '@/components/venue/VenueMenu'
import { VenueReviews } from '@/components/venue/VenueReviews'
import { VenueDetails } from '@/components/venue/VenueDetails'
import { FloorPlan } from '@/components/venue/FloorPlan'
import { MapView } from '@/components/map/MapView'
import { CartBar } from '@/components/cart/CartBar'
import { useVenueStore } from '@/store/venueStore'
import { useReservationStore } from '@/store/reservationStore'
import type { Venue } from '@/types'

export default function VenueDetail() {
  const { slug } = useParams<{ slug: string }>()
  const navigate = useNavigate()
  const { t, i18n } = useTranslation()
  const { fetchVenueBySlug, getVenueBySlug } = useVenueStore()
  const { setCurrentReservation } = useReservationStore()
  const lang = i18n.language
  const [loading, setLoading] = useState(true)

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
      content: <FloorPlan floorPlan={venue.floorPlan} />,
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

  return (
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
          <h1 className="text-2xl font-bold mb-2">{venue.name}</h1>
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
    </div>
  )
}
