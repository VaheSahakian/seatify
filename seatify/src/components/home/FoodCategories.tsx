import { useNavigate } from 'react-router-dom'
import { useVenueStore } from '@/store/venueStore'

interface FoodCategory {
  label: string
  emoji: string
  /** Cuisine tags to filter by — matches venue.cuisine array */
  cuisines: string[]
  /** Special action instead of cuisine filter */
  action?: 'openNow'
}

const categories: FoodCategory[] = [
  { label: 'Open Now', emoji: '🕐', cuisines: [], action: 'openNow' },
  { label: 'Burgers', emoji: '🍔', cuisines: ['Burgers', 'American', 'Fast Food'] },
  { label: 'Pizza', emoji: '🍕', cuisines: ['Pizza'] },
  { label: 'Pasta', emoji: '🍝', cuisines: ['Pasta', 'Italian'] },
  { label: 'Sushi', emoji: '🍣', cuisines: ['Sushi'] },
  { label: 'BBQ & Grill', emoji: '🥩', cuisines: ['BBQ', 'Grill', 'Steaks'] },
  { label: 'Seafood', emoji: '🦐', cuisines: ['Seafood', 'Mediterranean'] },
  { label: 'Chinese', emoji: '🥡', cuisines: ['Chinese', 'Asian', 'Wok'] },
  { label: 'Armenian', emoji: '🫓', cuisines: ['Armenian', 'Traditional'] },
  { label: 'Coffee', emoji: '☕', cuisines: ['Coffee', 'Cafe'] },
  { label: 'Bakery', emoji: '🥐', cuisines: ['Bakery', 'Pastry'] },
  { label: 'Desserts', emoji: '🍰', cuisines: ['Desserts'] },
  { label: 'Breakfast', emoji: '🍳', cuisines: ['Breakfast'] },
  { label: 'Fine Dining', emoji: '🍷', cuisines: ['Fine Dining', 'European', 'Wine'] },
  { label: 'Bar', emoji: '🍹', cuisines: ['Bar', 'Cocktails', 'Tapas'] },
  { label: 'Salads', emoji: '🥗', cuisines: ['Salads', 'Vegan'] },
]

export function FoodCategories() {
  const navigate = useNavigate()
  const { setFilters } = useVenueStore()

  const handleClick = (cat: FoodCategory) => {
    if (cat.action === 'openNow') {
      setFilters({ openNow: true, cuisine: [], query: '' })
    } else {
      setFilters({ cuisine: cat.cuisines, query: '', openNow: false })
    }
    navigate('/search')
  }

  return (
    <div
      className="flex gap-4 overflow-x-auto pb-2 scrollbar-hide"
      style={{ scrollbarWidth: 'none', msOverflowStyle: 'none' }}
    >
      {categories.map((cat) => (
        <button
          key={cat.label}
          onClick={() => handleClick(cat)}
          className="flex flex-col items-center gap-1.5 shrink-0 cursor-pointer group"
        >
          <div className="w-16 h-16 rounded-full bg-gray-50 border border-gray-100 flex items-center justify-center text-3xl group-hover:border-primary group-hover:bg-primary/5 transition-all group-hover:scale-105">
            {cat.emoji}
          </div>
          <span className="text-xs font-medium text-text-secondary group-hover:text-primary transition-colors whitespace-nowrap">
            {cat.label}
          </span>
        </button>
      ))}
    </div>
  )
}
