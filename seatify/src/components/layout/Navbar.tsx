import { Link, useNavigate } from 'react-router-dom'
import { Search, User, Sun, Moon } from 'lucide-react'
import { useAuthStore } from '@/store/authStore'
import { useThemeStore } from '@/store/themeStore'
import { LanguageSwitcher } from '@/components/common/LanguageSwitcher'
import { UserAvatar } from '@/components/common/UserAvatar'

export function Navbar() {
  const { isAuthenticated, user } = useAuthStore()
  const { dark, toggle: toggleTheme } = useThemeStore()
  const navigate = useNavigate()

  return (
    <header className="sticky top-0 z-40 bg-white/80 backdrop-blur-md border-b border-border-light">
      <div className="max-w-7xl mx-auto px-4 h-16 flex items-center justify-between">
        <Link to="/" className="flex items-center gap-2">
          <div className="w-8 h-8 bg-primary rounded-lg flex items-center justify-center">
            <span className="text-white font-bold text-sm">S</span>
          </div>
          <span className="text-xl font-bold text-text-primary hidden sm:block">
            Seatify
          </span>
        </Link>

        <div className="flex items-center gap-3">
          <button
            onClick={() => navigate('/search')}
            className="p-2 rounded-full hover:bg-surface transition-colors cursor-pointer"
          >
            <Search size={20} className="text-text-secondary" />
          </button>

          <button
            onClick={toggleTheme}
            className="p-2 rounded-full hover:bg-surface transition-colors cursor-pointer"
            aria-label="Toggle dark mode"
          >
            {dark ? (
              <Sun size={20} className="text-text-secondary" />
            ) : (
              <Moon size={20} className="text-text-secondary" />
            )}
          </button>

          <LanguageSwitcher />

          {isAuthenticated ? (
            <Link to="/profile" className="flex items-center gap-2">
              <UserAvatar name={user?.name} avatar={user?.avatar} size="sm" />
            </Link>
          ) : (
            <Link
              to="/auth"
              className="p-2 rounded-full hover:bg-surface transition-colors border border-border"
            >
              <User size={20} className="text-text-secondary" />
            </Link>
          )}
        </div>
      </div>
    </header>
  )
}
