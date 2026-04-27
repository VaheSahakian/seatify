import { Link, useLocation } from 'react-router-dom'
import { Home, Search, Heart, CalendarDays, ShoppingBag, User } from 'lucide-react'
import { useTranslation } from 'react-i18next'
import { cn } from '@/lib/utils'

const navItems = [
  { icon: Home, labelKey: 'nav.home', path: '/' },
  { icon: Search, labelKey: 'nav.search', path: '/search' },
  { icon: Heart, labelKey: 'nav.favorites', path: '/favorites' },
  { icon: CalendarDays, labelKey: 'nav.reservations', path: '/reservations' },
  { icon: ShoppingBag, labelKey: 'nav.orders', path: '/orders' },
  { icon: User, labelKey: 'nav.profile', path: '/profile' },
]

export function BottomNav() {
  const location = useLocation()
  const { t } = useTranslation()

  return (
    <nav className="fixed bottom-0 left-0 right-0 z-40 bg-white/80 backdrop-blur-md border-t border-border-light md:hidden">
      <div className="flex items-center justify-around h-16 px-2">
        {navItems.map(({ icon: Icon, labelKey, path }) => {
          const isActive =
            path === '/'
              ? location.pathname === '/'
              : location.pathname.startsWith(path)
          return (
            <Link
              key={path}
              to={path}
              className={cn(
                'flex flex-col items-center gap-0.5 px-3 py-1 rounded-lg transition-colors',
                isActive ? 'text-primary' : 'text-text-tertiary'
              )}
            >
              <Icon size={20} />
              <span className="text-[10px] font-medium">{t(labelKey)}</span>
            </Link>
          )
        })}
      </div>
    </nav>
  )
}
