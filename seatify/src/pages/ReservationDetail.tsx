import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import { ArrowLeft, CalendarDays, Clock, Users, MapPin } from 'lucide-react'
import { motion } from 'framer-motion'
import QRCode from 'react-qr-code'
import { Button } from '@/components/ui/button'
import { Badge } from '@/components/ui/badge'
import { Dialog } from '@/components/ui/dialog'
import { useReservationStore } from '@/store/reservationStore'
import { formatPrice } from '@/lib/utils'
import { toast } from 'sonner'

export default function ReservationDetail() {
  const { id } = useParams<{ id: string }>()
  const navigate = useNavigate()
  const { t, i18n } = useTranslation()
  const lang = i18n.language
  const { getReservationById, cancelReservation, fetchReservations, reservations } = useReservationStore()
  const [showCancel, setShowCancel] = useState(false)
  const [showQR, setShowQR] = useState(false)
  const [cancelling, setCancelling] = useState(false)

  useEffect(() => {
    if (reservations.length === 0) {
      fetchReservations()
    }
  }, [reservations.length, fetchReservations])

  const reservation = getReservationById(id || '')

  if (!reservation) {
    return (
      <div className="flex items-center justify-center min-h-[50vh]">
        <p className="text-text-secondary">Reservation not found</p>
      </div>
    )
  }

  const handleCancel = async () => {
    setCancelling(true)
    try {
      await cancelReservation(reservation.id)
      setShowCancel(false)
      toast.success('Reservation cancelled')
    } catch (err: any) {
      toast.error(err.message || 'Failed to cancel')
    } finally {
      setCancelling(false)
    }
  }

  return (
    <div className="max-w-2xl mx-auto px-4 py-6">
      <div className="flex items-center gap-3 mb-6">
        <button
          onClick={() => navigate('/reservations')}
          className="w-10 h-10 rounded-full border border-border flex items-center justify-center hover:bg-surface transition-colors cursor-pointer"
        >
          <ArrowLeft size={20} />
        </button>
        <h1 className="text-xl font-bold">{t('reservations.title')}</h1>
      </div>

      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
      >
        {/* Venue image & info */}
        <div className="relative rounded-[16px] overflow-hidden mb-6">
          <img
            src={reservation.venueImage}
            alt={reservation.venueName}
            className="w-full aspect-[2/1] object-cover"
          />
          <div className="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/60 to-transparent p-4">
            <h2 className="text-white text-xl font-bold">
              {reservation.venueName}
            </h2>
          </div>
        </div>

        {/* Status badge */}
        <div className="mb-6">
          <Badge
            variant={
              reservation.status === 'upcoming'
                ? 'success'
                : reservation.status === 'cancelled'
                ? 'error'
                : 'default'
            }
            className="text-sm px-3 py-1"
          >
            {t(`reservations.${reservation.status}`)}
          </Badge>
        </div>

        {/* Details */}
        <div className="space-y-3 mb-6">
          <div className="flex items-center gap-3 text-sm">
            <CalendarDays size={18} className="text-text-tertiary" />
            <span>{reservation.date}</span>
          </div>
          <div className="flex items-center gap-3 text-sm">
            <Clock size={18} className="text-text-tertiary" />
            <span>{reservation.time}</span>
          </div>
          <div className="flex items-center gap-3 text-sm">
            <Users size={18} className="text-text-tertiary" />
            <span>{t('reservations.party_size', { count: reservation.partySize })}</span>
          </div>
          <div className="flex items-center gap-3 text-sm">
            <MapPin size={18} className="text-text-tertiary" />
            <span>{t('reservations.table', { label: reservation.tableLabel })}</span>
          </div>
        </div>

        {/* Pre-order */}
        {reservation.preOrder.length > 0 && (
          <div className="p-4 rounded-[16px] border border-border-light mb-6">
            <h3 className="font-semibold mb-3">
              {t('checkout.pre_order_items')}
            </h3>
            <div className="space-y-2">
              {reservation.preOrder.map((item) => (
                <div
                  key={item.menuItem.id}
                  className="flex justify-between text-sm"
                >
                  <span>
                    {item.quantity}x{' '}
                    {item.menuItem.name[lang] || item.menuItem.name.en}
                  </span>
                  <span>{formatPrice(item.menuItem.price * item.quantity)}</span>
                </div>
              ))}
            </div>
            {reservation.totalAmount > 0 && (
              <div className="flex justify-between text-sm font-semibold pt-3 mt-3 border-t border-border-light">
                <span>{t('checkout.total')}</span>
                <span>{formatPrice(reservation.totalAmount)}</span>
              </div>
            )}
          </div>
        )}

        {/* Actions */}
        {reservation.status === 'upcoming' && (
          <div className="space-y-3">
            <Button
              className="w-full"
              onClick={() => setShowQR(true)}
            >
              {t('reservations.view_qr')}
            </Button>
            <Button
              variant="outline"
              className="w-full text-error border-error/30 hover:bg-red-50"
              onClick={() => setShowCancel(true)}
            >
              {t('reservations.cancel')}
            </Button>
          </div>
        )}
      </motion.div>

      {/* QR Dialog */}
      <Dialog open={showQR} onClose={() => setShowQR(false)}>
        <div className="text-center pt-4">
          <h2 className="text-lg font-semibold mb-4">
            {reservation.venueName}
          </h2>
          <div className="inline-block p-4 bg-white rounded-[12px]">
            <QRCode value={reservation.qrCode} size={200} />
          </div>
          <p className="text-xs text-text-tertiary mt-3">
            {reservation.qrCode}
          </p>
        </div>
      </Dialog>

      {/* Cancel Dialog */}
      <Dialog open={showCancel} onClose={() => setShowCancel(false)}>
        <h2 className="text-lg font-semibold mb-2">
          {t('reservations.cancel')}
        </h2>
        <p className="text-sm text-text-secondary mb-6">
          {t('reservations.cancel_confirm')}
        </p>
        <div className="flex gap-3">
          <Button
            variant="outline"
            className="flex-1"
            onClick={() => setShowCancel(false)}
          >
            {t('common.back')}
          </Button>
          <Button
            className="flex-1 bg-error hover:bg-red-700"
            onClick={handleCancel}
            disabled={cancelling}
          >
            {cancelling ? '...' : t('reservations.cancel')}
          </Button>
        </div>
      </Dialog>
    </div>
  )
}
