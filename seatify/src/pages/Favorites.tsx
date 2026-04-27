import { useEffect } from 'react'
import { Heart } from 'lucide-react'
import { VenueCard } from '@/components/venue/VenueCard'
import { PageTransition } from '@/components/layout/PageTransition'
import { EmptyState } from '@/components/common/EmptyState'
import { useFavoriteStore } from '@/store/favoriteStore'
import { useVenueStore } from '@/store/venueStore'
import { useAuthStore } from '@/store/authStore'
import { Link } from 'react-router-dom'

export default function Favorites() {
  const { favoriteIds, loaded, fetchFavorites } = useFavoriteStore()
  const { venues, fetchVenues } = useVenueStore()
  const { isAuthenticated, loading: authLoading } = useAuthStore()

  useEffect(() => {
    fetchVenues()
  }, [fetchVenues])

  useEffect(() => {
    if (isAuthenticated) {
      fetchFavorites()
    }
  }, [isAuthenticated, fetchFavorites])

  const favoriteVenues = venues.filter((v) => favoriteIds.includes(v.id))

  if (authLoading) {
    return (
      <div className="flex items-center justify-center min-h-[50vh]">
        <div className="w-8 h-8 border-2 border-primary border-t-transparent rounded-full animate-spin" />
      </div>
    )
  }

  if (!isAuthenticated) {
    return (
      <PageTransition>
        <div className="max-w-7xl mx-auto px-4 py-12 text-center">
          <Heart size={48} className="mx-auto mb-4 text-text-tertiary" />
          <h2 className="text-xl font-semibold mb-2">Sign in to see your favorites</h2>
          <p className="text-text-secondary mb-6">
            Save your favorite restaurants and access them anytime.
          </p>
          <Link
            to="/auth"
            className="inline-block px-6 py-2.5 bg-primary text-white rounded-full font-medium text-sm hover:bg-primary/90 transition-colors"
          >
            Sign in
          </Link>
        </div>
      </PageTransition>
    )
  }

  if (!loaded) {
    return (
      <PageTransition>
        <div className="max-w-7xl mx-auto px-4 py-6">
          <h1 className="text-2xl font-bold mb-6">Favorites</h1>
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            {[1, 2, 3].map((i) => (
              <div key={i} className="animate-pulse">
                <div className="aspect-[4/3] rounded-[16px] bg-surface mb-3" />
                <div className="h-4 bg-surface rounded w-3/4 mb-2" />
                <div className="h-3 bg-surface rounded w-1/2" />
              </div>
            ))}
          </div>
        </div>
      </PageTransition>
    )
  }

  return (
    <PageTransition>
      <div className="max-w-7xl mx-auto px-4 py-6">
        <h1 className="text-2xl font-bold mb-6">Favorites</h1>

        {favoriteVenues.length === 0 ? (
          <EmptyState
            icon="💝"
            title="No favorites yet"
            description="Start exploring and save restaurants you love!"
            action={
              <Link
                to="/search"
                className="inline-block px-5 py-2.5 bg-primary text-white rounded-full text-sm font-medium hover:bg-primary/90 transition-colors"
              >
                Browse Restaurants
              </Link>
            }
          />
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
            {favoriteVenues.map((venue, i) => (
              <VenueCard key={venue.id} venue={venue} index={i} />
            ))}
          </div>
        )}
      </div>
    </PageTransition>
  )
}
