import { useState, useRef, useEffect } from 'react'
import { useTranslation } from 'react-i18next'
import { Globe } from 'lucide-react'
import { cn } from '@/lib/utils'
import { useAuthStore } from '@/store/authStore'

const languages = [
  { code: 'en', label: 'EN' },
  { code: 'hy', label: 'HY' },
  { code: 'ru', label: 'RU' },
] as const

export function LanguageSwitcher() {
  const { i18n } = useTranslation()
  const { updateProfile } = useAuthStore()
  const [open, setOpen] = useState(false)
  const ref = useRef<HTMLDivElement>(null)

  useEffect(() => {
    function handleClick(e: MouseEvent) {
      if (ref.current && !ref.current.contains(e.target as Node)) {
        setOpen(false)
      }
    }
    document.addEventListener('mousedown', handleClick)
    return () => document.removeEventListener('mousedown', handleClick)
  }, [])

  const handleChange = (code: string) => {
    i18n.changeLanguage(code)
    updateProfile({ language: code as 'en' | 'hy' | 'ru' })
    setOpen(false)
  }

  return (
    <div className="relative" ref={ref}>
      <button
        onClick={() => setOpen(!open)}
        className="flex items-center gap-1 p-2 rounded-full hover:bg-surface transition-colors cursor-pointer"
      >
        <Globe size={18} className="text-text-secondary" />
        <span className="text-xs font-medium text-text-secondary uppercase">
          {i18n.language}
        </span>
      </button>
      {open && (
        <div className="absolute right-0 top-full mt-1 bg-white rounded-lg shadow-lg border border-border-light py-1 min-w-[80px] z-50">
          {languages.map((lang) => (
            <button
              key={lang.code}
              onClick={() => handleChange(lang.code)}
              className={cn(
                'w-full px-4 py-2 text-sm text-left hover:bg-surface transition-colors cursor-pointer',
                i18n.language === lang.code
                  ? 'text-primary font-medium'
                  : 'text-text-primary'
              )}
            >
              {lang.label}
            </button>
          ))}
        </div>
      )}
    </div>
  )
}
