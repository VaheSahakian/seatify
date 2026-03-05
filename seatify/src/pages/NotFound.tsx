import { useNavigate } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import { MapPin } from 'lucide-react'
import { motion } from 'framer-motion'
import { Button } from '@/components/ui/button'

export default function NotFound() {
  const { t } = useTranslation()
  const navigate = useNavigate()

  return (
    <div className="min-h-[70vh] flex items-center justify-center px-4">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="text-center"
      >
        <MapPin size={64} className="text-text-tertiary mx-auto mb-4" />
        <h1 className="text-6xl font-bold text-text-tertiary mb-2">404</h1>
        <h2 className="text-xl font-semibold mb-2">{t('common.not_found')}</h2>
        <p className="text-text-secondary mb-6">
          {t('common.not_found_desc')}
        </p>
        <Button onClick={() => navigate('/')}>{t('common.go_home')}</Button>
      </motion.div>
    </div>
  )
}
