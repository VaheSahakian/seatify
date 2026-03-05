import { useTranslation } from 'react-i18next'
import { ShoppingBag, CalendarDays } from 'lucide-react'
import { motion } from 'framer-motion'
import { useReservationStore } from '@/store/reservationStore'
import { formatPrice } from '@/lib/utils'

export default function Orders() {
  const { t, i18n } = useTranslation()
  const lang = i18n.language
  const { reservations } = useReservationStore()

  const orders = reservations.filter(
    (r) => r.preOrder.length > 0 && r.status !== 'cancelled'
  )

  return (
    <div className="max-w-2xl mx-auto px-4 py-6">
      <h1 className="text-2xl font-bold mb-6">{t('orders.title')}</h1>

      {orders.length === 0 ? (
        <div className="text-center py-12">
          <ShoppingBag size={48} className="text-text-tertiary mx-auto mb-3" />
          <p className="text-text-secondary">{t('orders.no_orders')}</p>
        </div>
      ) : (
        <div className="space-y-4">
          {orders.map((order, i) => (
            <motion.div
              key={order.id}
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: i * 0.05 }}
              className="p-4 rounded-[16px] border border-border-light"
            >
              <div className="flex items-center justify-between mb-3">
                <h3 className="font-semibold text-sm">{order.venueName}</h3>
                <span className="text-xs text-text-tertiary flex items-center gap-1">
                  <CalendarDays size={12} />
                  {order.date}
                </span>
              </div>
              <div className="space-y-1.5">
                {order.preOrder.map((item) => (
                  <div
                    key={item.menuItem.id}
                    className="flex justify-between text-sm text-text-secondary"
                  >
                    <span>
                      {item.quantity}x{' '}
                      {item.menuItem.name[lang] || item.menuItem.name.en}
                    </span>
                    <span>
                      {formatPrice(item.menuItem.price * item.quantity)}
                    </span>
                  </div>
                ))}
              </div>
              <div className="flex justify-between items-center pt-3 mt-3 border-t border-border-light">
                <span className="text-xs text-text-tertiary">
                  {t('orders.items', { count: order.preOrder.length })}
                </span>
                <span className="font-semibold text-sm">
                  {t('orders.total')}: {formatPrice(order.totalAmount)}
                </span>
              </div>
            </motion.div>
          ))}
        </div>
      )}
    </div>
  )
}
