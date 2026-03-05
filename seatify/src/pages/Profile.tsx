import { useNavigate } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import {
  User,
  Star,
  DollarSign,
  Globe,
  Bell,
  HelpCircle,
  LogOut,
  ChevronRight,
} from 'lucide-react'
import { motion } from 'framer-motion'
import { Button } from '@/components/ui/button'
import { useAuthStore } from '@/store/authStore'
import { cn } from '@/lib/utils'

const languages = [
  { code: 'en', label: 'English' },
  { code: 'hy', label: 'Հայerեdelays海n' },
  { code: 'ru', label: 'Русский' },
] as const

export default function Profile() {
  const { t, i18n } = useTranslation()
  const navigate = useNavigate()
  const { user, isAuthenticated, logout, updateProfile } = useAuthStore()

  if (!isAuthenticated || !user) {
    return (
      <div className="max-w-md mx-auto px-4 py-12 text-center">
        <User size={48} className="text-text-tertiary mx-auto mb-4" />
        <h2 className="text-xl font-bold mb-2">{t('auth.welcome')}</h2>
        <p className="text-text-secondary mb-6">{t('auth.subtitle')}</p>
        <Button onClick={() => navigate('/auth')}>{t('auth.login')}</Button>
      </div>
    )
  }

  const handleLanguage = async (code: string) => {
    i18n.changeLanguage(code)
    try {
      await updateProfile({ language: code as 'en' | 'hy' | 'ru' })
    } catch {
      // language is already changed locally, ignore API error
    }
  }

  const handleLogout = async () => {
    await logout()
    navigate('/')
  }

  const menuItems = [
    {
      icon: Bell,
      label: t('profile.notifications'),
      onClick: () => {},
    },
    {
      icon: HelpCircle,
      label: t('profile.help'),
      onClick: () => {},
    },
  ]

  return (
    <div className="max-w-md mx-auto px-4 py-6">
      <h1 className="text-2xl font-bold mb-6">{t('profile.title')}</h1>

      {/* User card */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="flex items-center gap-4 p-4 rounded-[16px] bg-surface mb-6"
      >
        <img
          src={user.avatar}
          alt={user.name}
          className="w-16 h-16 rounded-full object-cover"
        />
        <div>
          <h2 className="font-semibold">{user.name}</h2>
          <p className="text-sm text-text-secondary">{user.email}</p>
          {user.phone && (
            <p className="text-sm text-text-secondary">{user.phone}</p>
          )}
        </div>
      </motion.div>

      {/* Loyalty & Cashback */}
      <div className="grid grid-cols-2 gap-3 mb-6">
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.1 }}
          className="p-4 rounded-[16px] border border-border-light text-center"
        >
          <Star size={24} className="text-primary mx-auto mb-2" />
          <p className="text-2xl font-bold">{user.loyaltyPoints}</p>
          <p className="text-xs text-text-secondary">
            {t('profile.loyalty_points')}
          </p>
        </motion.div>
        <motion.div
          initial={{ opacity: 0, y: 10 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.15 }}
          className="p-4 rounded-[16px] border border-border-light text-center"
        >
          <DollarSign size={24} className="text-secondary mx-auto mb-2" />
          <p className="text-2xl font-bold">${user.cashback.toFixed(2)}</p>
          <p className="text-xs text-text-secondary">
            {t('profile.cashback')}
          </p>
        </motion.div>
      </div>

      {/* Language */}
      <div className="mb-6">
        <div className="flex items-center gap-2 mb-3">
          <Globe size={18} className="text-text-secondary" />
          <span className="text-sm font-medium">{t('profile.language')}</span>
        </div>
        <div className="flex gap-2">
          {languages.map((lang) => (
            <button
              key={lang.code}
              onClick={() => handleLanguage(lang.code)}
              className={cn(
                'flex-1 py-2.5 rounded-[12px] text-sm font-medium border transition-colors cursor-pointer',
                i18n.language === lang.code
                  ? 'border-primary bg-primary/5 text-primary'
                  : 'border-border text-text-secondary hover:border-text-primary'
              )}
            >
              {lang.label}
            </button>
          ))}
        </div>
      </div>

      {/* Menu items */}
      <div className="space-y-1 mb-6">
        {menuItems.map(({ icon: Icon, label, onClick }) => (
          <button
            key={label}
            onClick={onClick}
            className="w-full flex items-center justify-between p-3 rounded-[12px] hover:bg-surface transition-colors cursor-pointer"
          >
            <div className="flex items-center gap-3">
              <Icon size={18} className="text-text-secondary" />
              <span className="text-sm">{label}</span>
            </div>
            <ChevronRight size={16} className="text-text-tertiary" />
          </button>
        ))}
      </div>

      {/* Logout */}
      <Button
        variant="outline"
        className="w-full text-error border-error/30 hover:bg-red-50"
        onClick={handleLogout}
      >
        <LogOut size={16} className="mr-2" />
        {t('profile.logout')}
      </Button>
    </div>
  )
}
