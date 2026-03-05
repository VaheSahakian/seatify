import { useState, useEffect } from 'react'
import { Link } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import { CalendarDays, Clock, Users, ChevronRight } from 'lucide-react'
import { motion } from 'framer-motion'
import { Badge } from '@/components/ui/badge'
import { useReservationStore } from '@/store/reservationStore'
import { cn } from '@/lib/utils'

const statusTabs = ['upcoming', 'completed', 'cancelled'] as const

export default function Reservations() {
  const { t } = useTranslation()
  const { reservations, fetchReservations, loading } = useReservationStore()
  const [activeTab, setActiveTab] = useState<typeof statusTabs[number]>('upcoming')

  useEffect(() => {
    fetchReservations()
  }, [fetchReservations])

  const filtered = reservations.filter((r) => r.status === activeTab)

  return (
    <div className="max-w-2xl mx-auto px-4 py-6">
      <h1 className="text-2xl font-bold mb-6">{t('reservations.title')}</h1>

      <div className="flex gap-2 mb-6">
        {statusTabs.map((tab) => (
          <button
            key={tab}
            onClick={() => setActiveTab(tab)}
            className={cn(
              'px-4 py-2 rounded-full text-sm font-medium transition-colors cursor-pointer',
              activeTab === tab
                ? 'bg-primary text-white'
                : 'bg-surface text-text-secondary hover:bg-surface-hover'
            )}
          >
            {t(`reservations.${tab}`)}
          </button>
        ))}
      </div>

      {loading ? (
        <div className="flex justify-center py-12">
          <div className="w-8 h-8 border-2 border-primary border-t-transparent rounded-full animate-spin" />
        </div>
      ) : filtered.length === 0 ? (
        <div className="text-center py-12">
          <CalendarDays size={48} className="text-text-tertiary mx-auto mb-3" />
          <p className="text-text-secondary">
            {t('reservations.no_reservations')}
          </p>
        </div>
      ) : (
        <div className="space-y-3">
          {filtered.map((reservation, i) => (
            <motion.div
              key={reservation.id}
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: i * 0.05 }}
            >
              <Link
                to={`/reservations/${reservation.id}`}
                className="flex items-center gap-4 p-4 rounded-[16px] border border-border-light hover:border-border transition-colors group"
              >
                <img
                  src={reservation.venueImage}
                  alt={reservation.venueName}
                  className="w-20 h-20 rounded-[12px] object-cover shrink-0"
                />
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-2 mb-1">
                    <h3 className="font-semibold text-sm truncate">
                      {reservation.venueName}
                    </h3>
                    <Badge
                      variant={
                        reservation.status === 'upcoming'
                          ? 'success'
                          : reservation.status === 'cancelled'
                          ? 'error'
                          : 'default'
                      }
                    >
                      {t(`reservations.${reservation.status}`)}
                    </Badge>
                  </div>
                  <div className="flex items-center gap-3 text-xs text-text-secondary">
                    <span className="flex items-center gap-1">
                      <CalendarDays size={12} />
                      {reservation.date}
                    </span>
                    <span className="flex items-center gap-1">
                      <Clock size={12} />
                      {reservation.time}
                    </span>
                    <span className="flex items-center gap-1">
                      <Users size={12} />
                      {reservation.partySize}
                    </span>
                  </div>
                </div>
                <ChevronRight
                  size={20}
                  className="text-text-tertiary group-hover:text-primary transition-colors shrink-0"
                />
              </Link>
            </motion.div>
          ))}
        </div>
      )}
    </div>
  )
}
