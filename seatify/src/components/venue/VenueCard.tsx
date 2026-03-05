import { Link } from 'react-router-dom'
import { Star, MapPin } from 'lucide-react'
import { motion } from 'framer-motion'
import type { Venue } from '@/types'

interface VenueCardProps {
  venue: Venue
  index?: number
}

export function VenueCard({ venue, index = 0 }: VenueCardProps) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ delay: index * 0.05, duration: 0.3 }}
    >
      <Link to={`/venue/${venue.slug}`} className="group block">
        <div className="aspect-[4/3] rounded-[16px] overflow-hidden mb-3 relative">
          <img
            src={venue.images[0]}
            alt={venue.name}
            className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
          />
          <div className="absolute top-3 right-3 bg-white/90 backdrop-blur-sm rounded-full px-2 py-1 flex items-center gap-1">
            <Star size={14} className="fill-primary text-primary" />
            <span className="text-sm font-medium">{venue.rating}</span>
          </div>
        </div>
        <div>
          <div className="flex items-start justify-between gap-2">
            <h3 className="font-semibold text-text-primary group-hover:text-primary transition-colors">
              {venue.name}
            </h3>
            <span className="text-sm text-text-secondary shrink-0">
              {'$'.repeat(venue.priceRange)}
            </span>
          </div>
          <div className="flex items-center gap-1 mt-1 text-sm text-text-secondary">
            <MapPin size={14} />
            <span className="truncate">{venue.address}</span>
          </div>
          <div className="flex gap-1.5 mt-2">
            {venue.cuisine.slice(0, 3).map((c) => (
              <span
                key={c}
                className="text-xs px-2 py-0.5 rounded-full bg-surface text-text-secondary"
              >
                {c}
              </span>
            ))}
          </div>
        </div>
      </Link>
    </motion.div>
  )
}
