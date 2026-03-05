import { useEffect, useState } from 'react'
import { useTranslation } from 'react-i18next'
import { Star } from 'lucide-react'
import { motion } from 'framer-motion'
import { apiFetch } from '@/lib/api'
import type { Review } from '@/types'

interface VenueReviewsProps {
  venueId: string
}

export function VenueReviews({ venueId }: VenueReviewsProps) {
  const { i18n } = useTranslation()
  const lang = i18n.language
  const [venueReviews, setVenueReviews] = useState<Review[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    apiFetch<{ content: Review[] }>(`/api/venues/${venueId}/reviews?size=50`)
      .then((data) => setVenueReviews(data.content))
      .catch(() => {})
      .finally(() => setLoading(false))
  }, [venueId])

  if (loading) {
    return (
      <div className="flex justify-center py-8">
        <div className="w-6 h-6 border-2 border-primary border-t-transparent rounded-full animate-spin" />
      </div>
    )
  }

  if (venueReviews.length === 0) {
    return (
      <p className="text-text-secondary text-sm py-8 text-center">
        No reviews yet
      </p>
    )
  }

  return (
    <div className="space-y-4">
      {venueReviews.map((review, i) => (
        <motion.div
          key={review.id}
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: i * 0.05 }}
          className="p-4 rounded-[12px] border border-border-light"
        >
          <div className="flex items-center gap-3 mb-2">
            {review.userAvatar ? (
              <img
                src={review.userAvatar}
                alt={review.userName}
                className="w-10 h-10 rounded-full object-cover"
              />
            ) : (
              <div className="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-primary font-semibold text-sm">
                {review.userName.charAt(0)}
              </div>
            )}
            <div>
              <p className="font-medium text-sm">{review.userName}</p>
              <div className="flex items-center gap-1">
                {Array.from({ length: 5 }).map((_, idx) => (
                  <Star
                    key={idx}
                    size={12}
                    className={
                      idx < review.rating
                        ? 'fill-primary text-primary'
                        : 'text-border'
                    }
                  />
                ))}
                <span className="text-xs text-text-tertiary ml-1">
                  {review.date}
                </span>
              </div>
            </div>
          </div>
          <p className="text-sm text-text-secondary leading-relaxed">
            {review.comment[lang] || review.comment.en}
          </p>
        </motion.div>
      ))}
    </div>
  )
}
