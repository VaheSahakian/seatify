import { useNavigate } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import { ShoppingBag } from 'lucide-react'
import { motion, AnimatePresence } from 'framer-motion'
import { useCartStore } from '@/store/cartStore'
import { formatPrice } from '@/lib/utils'

export function CartBar() {
  const { t } = useTranslation()
  const navigate = useNavigate()
  const { getItemCount, getTotal, venueId } = useCartStore()
  const count = getItemCount()
  const total = getTotal()

  if (count === 0) return null

  return (
    <AnimatePresence>
      <motion.div
        initial={{ y: 100, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        exit={{ y: 100, opacity: 0 }}
        className="fixed bottom-20 md:bottom-6 left-4 right-4 z-30 max-w-lg mx-auto"
      >
        <button
          onClick={() => navigate(`/reserve/${venueId}`)}
          className="w-full flex items-center justify-between bg-primary text-white px-5 py-4 rounded-[16px] shadow-xl hover:bg-primary-dark transition-colors cursor-pointer"
        >
          <div className="flex items-center gap-3">
            <div className="relative">
              <ShoppingBag size={20} />
              <span className="absolute -top-1 -right-1 w-4 h-4 bg-white text-primary text-[10px] font-bold rounded-full flex items-center justify-center">
                {count}
              </span>
            </div>
            <span className="text-sm font-medium">
              {t('cart.items', { count })}
            </span>
          </div>
          <span className="font-semibold">{formatPrice(total)}</span>
        </button>
      </motion.div>
    </AnimatePresence>
  )
}
