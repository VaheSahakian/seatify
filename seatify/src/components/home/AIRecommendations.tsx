import { useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { Star, ChevronRight, X } from 'lucide-react'
import { motion } from 'framer-motion'
import { useFavoriteStore } from '@/store/favoriteStore'
import { useVenueStore } from '@/store/venueStore'
import { useRecentStore } from '@/store/recentStore'
import type { Venue } from '@/types'

interface ScoredVenue {
  venue: Venue
  score: number
  reason: string
}

export function AIRecommendations() {
  const { favoriteIds } = useFavoriteStore()
  const { venues } = useVenueStore()
  const { items: recentItems } = useRecentStore()

  const recentIds = useMemo(() => recentItems.map((i) => i.id), [recentItems])

  const recommendations = useMemo(() => {
    // Need at least 1 favorite or 2 recent views
    if (favoriteIds.length < 1 && recentIds.length < 2) return []

    const favoriteVenues = venues.filter((v) => favoriteIds.includes(v.id))
    const recentVenues = venues.filter((v) => recentIds.includes(v.id))

    // Collect cuisine tags from favorites and recent views
    const favCuisines = new Map<string, number>()
    for (const v of favoriteVenues) {
      for (const c of v.cuisine) {
        favCuisines.set(c, (favCuisines.get(c) || 0) + 1)
      }
    }

    const recentCuisines = new Map<string, number>()
    for (const v of recentVenues) {
      for (const c of v.cuisine) {
        recentCuisines.set(c, (recentCuisines.get(c) || 0) + 1)
      }
    }

    // Exclude already-favorited and recently viewed venues
    const excludeIds = new Set([...favoriteIds, ...recentIds])

    const scored: ScoredVenue[] = []

    for (const venue of venues) {
      if (excludeIds.has(venue.id)) continue

      let score = 0
      let matchedCuisine = ''

      // +2 points for each cuisine tag matching favorites
      for (const c of venue.cuisine) {
        if (favCuisines.has(c)) {
          score += 2 * (favCuisines.get(c) || 1)
          if (!matchedCuisine) matchedCuisine = c
        }
      }

      // +1 point for each cuisine tag matching recent views
      for (const c of venue.cuisine) {
        if (recentCuisines.has(c)) {
          score += 1 * (recentCuisines.get(c) || 1)
          if (!matchedCuisine) matchedCuisine = c
        }
      }

      const reason = matchedCuisine
        ? `You liked ${matchedCuisine}`
        : `Highly rated`

      scored.push({ venue, score, reason })
    }

    // Sort by score descending, then by rating
    scored.sort((a, b) => b.score - a.score || b.venue.rating - a.venue.rating)

    // Take top 4; if not enough scored, fill with highest-rated unseen
    const results = scored.filter((s) => s.score > 0).slice(0, 4)

    if (results.length < 4) {
      const usedIds = new Set(results.map((r) => r.venue.id))
      const remaining = venues
        .filter((v) => !excludeIds.has(v.id) && !usedIds.has(v.id))
        .sort((a, b) => b.rating - a.rating)

      for (const venue of remaining) {
        if (results.length >= 4) break
        results.push({ venue, score: 0, reason: 'Highly rated' })
      }
    }

    return results
  }, [venues, favoriteIds, recentIds])

  const [dismissed, setDismissed] = useState(false)

  if (recommendations.length === 0 || dismissed) return null

  return (
    <section className="max-w-7xl mx-auto px-4 pb-8">
      <div className="rounded-[20px] bg-gradient-to-r from-primary/5 via-primary/10 to-primary/5 p-6">
        <div className="flex items-center justify-between mb-1">
          <h2 className="text-xl font-semibold flex items-center gap-2">
            <span>Recommended for You</span>
          </h2>
          <div className="flex items-center gap-2">
            <Link
              to="/search"
              className="flex items-center gap-1 text-sm text-primary font-medium hover:underline"
            >
              View all
              <ChevronRight size={16} />
            </Link>
            <button
              onClick={() => setDismissed(true)}
              className="p-1 rounded-full hover:bg-black/5 transition-colors cursor-pointer"
              title="Hide recommendations"
            >
              <X size={16} className="text-text-tertiary" />
            </button>
          </div>
        </div>
        <p className="text-sm text-text-secondary mb-5">Based on your taste</p>

        <div className="flex gap-4 overflow-x-auto pb-2 scrollbar-hide -mx-1 px-1">
          {recommendations.map(({ venue, reason }, i) => (
            <motion.div
              key={venue.id}
              initial={{ opacity: 0, x: 20 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ delay: i * 0.08, duration: 0.3 }}
              className="shrink-0 w-[220px]"
            >
              <Link to={`/venue/${venue.slug}`} className="group block">
                <div className="aspect-[4/3] rounded-[14px] overflow-hidden mb-2.5 relative">
                  <img
                    src={venue.images[0]}
                    alt={venue.name}
                    className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
                  />
                  <div className="absolute top-2 right-2 bg-white/90 backdrop-blur-sm rounded-full px-1.5 py-0.5 flex items-center gap-0.5">
                    <Star size={12} className="fill-primary text-primary" />
                    <span className="text-xs font-medium">{venue.rating}</span>
                  </div>
                </div>
                <h3 className="font-semibold text-sm text-text-primary group-hover:text-primary transition-colors truncate">
                  {venue.name}
                </h3>
                <div className="flex gap-1 mt-1 flex-wrap">
                  {venue.cuisine.slice(0, 2).map((c) => (
                    <span
                      key={c}
                      className="text-[10px] px-1.5 py-0.5 rounded-full bg-white/80 text-text-secondary"
                    >
                      {c}
                    </span>
                  ))}
                </div>
                <p className="text-[11px] text-primary/70 mt-1.5 font-medium">
                  {reason}
                </p>
              </Link>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  )
}
