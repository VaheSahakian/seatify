import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import { ArrowLeft, CalendarDays, Clock, Users, Banknote } from 'lucide-react'
import {
  VisaLogo,
  MastercardLogo,
  ApplePayLogo,
  GooglePayLogo,
  IdramLogo,
  TelcellLogo,
} from '@/components/checkout/PaymentIcons'
import { motion, AnimatePresence } from 'framer-motion'
import QRCode from 'react-qr-code'
import { Button } from '@/components/ui/button'
import { useReservationStore } from '@/store/reservationStore'
import { useCartStore } from '@/store/cartStore'
import { useAuthStore } from '@/store/authStore'
import { useLoginPrompt } from '@/store/loginPromptStore'
import { formatPrice } from '@/lib/utils'
import { cn } from '@/lib/utils'
import { toast } from 'sonner'
import { fireConfetti } from '@/lib/confetti'
import type { Reservation } from '@/types'

export default function Checkout() {
  const navigate = useNavigate()
  const { t, i18n } = useTranslation()
  const lang = i18n.language
  const { currentReservation, confirmReservation } = useReservationStore()
  const { clearCart } = useCartStore()
  const isAuthenticated = useAuthStore((s) => s.isAuthenticated)
  const openLoginPrompt = useLoginPrompt((s) => s.open)
  const [paymentMethod, setPaymentMethod] = useState<string>('card')
  const [confirmed, setConfirmed] = useState<Reservation | null>(null)
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    if (confirmed) {
      fireConfetti()
    }
  }, [confirmed])

  if (!currentReservation && !confirmed) {
    navigate('/reservations')
    return null
  }

  const handleConfirm = async () => {
    if (!isAuthenticated) {
      openLoginPrompt(() => handleConfirm())
      return
    }
    setLoading(true)
    try {
      const reservation = await confirmReservation(paymentMethod)
      clearCart()
      setConfirmed(reservation)
    } catch (err: any) {
      toast.error(err.message || 'Failed to confirm reservation')
    } finally {
      setLoading(false)
    }
  }

  const preOrderTotal = currentReservation?.preOrder.reduce(
    (sum, item) => sum + item.menuItem.price * item.quantity,
    0
  ) || 0

  if (confirmed) {
    return (
      <div className="max-w-md mx-auto px-4 py-12 text-center">
        <motion.div
          initial={{ scale: 0 }}
          animate={{ scale: 1 }}
          transition={{ type: 'spring', stiffness: 200, damping: 15 }}
          className="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4"
        >
          <motion.svg
            initial={{ pathLength: 0 }}
            animate={{ pathLength: 1 }}
            transition={{ duration: 0.5, delay: 0.2 }}
            className="w-10 h-10 text-green-600"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            strokeWidth={3}
          >
            <motion.path
              strokeLinecap="round"
              strokeLinejoin="round"
              d="M5 13l4 4L19 7"
            />
          </motion.svg>
        </motion.div>
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3 }}
        >
          <h1 className="text-2xl font-bold mb-2">{t('checkout.success')}</h1>
          <p className="text-text-secondary mb-8">
            {t('checkout.success_desc')}
          </p>

          <div className="bg-white p-6 rounded-[16px] shadow-lg inline-block mb-8">
            <QRCode value={confirmed.qrCode} size={200} />
            <p className="text-xs text-text-tertiary mt-3">
              {confirmed.qrCode}
            </p>
          </div>

          <div className="space-y-3">
            <Button
              className="w-full"
              onClick={() => navigate(`/reservations/${confirmed.id}`)}
            >
              {t('checkout.view_reservation')}
            </Button>
            <Button
              variant="outline"
              className="w-full"
              onClick={() => navigate('/')}
            >
              {t('checkout.back_home')}
            </Button>
          </div>
        </motion.div>
      </div>
    )
  }

  return (
    <div className="max-w-2xl mx-auto px-4 py-6">
      <div className="flex items-center gap-3 mb-6">
        <button
          onClick={() => navigate(-1)}
          className="w-10 h-10 rounded-full border border-border flex items-center justify-center hover:bg-surface transition-colors cursor-pointer"
        >
          <ArrowLeft size={20} />
        </button>
        <h1 className="text-xl font-bold">{t('checkout.title')}</h1>
      </div>

      <div className="space-y-6">
        {/* Reservation details */}
        <div className="p-4 rounded-[16px] border border-border-light">
          <h2 className="font-semibold mb-3">
            {t('checkout.reservation_details')}
          </h2>
          <div className="space-y-2 text-sm">
            <div className="flex items-center gap-2">
              <img
                src={currentReservation!.venueImage}
                alt=""
                className="w-12 h-12 rounded-[8px] object-cover"
              />
              <span className="font-medium">
                {currentReservation!.venueName}
              </span>
            </div>
            <div className="flex items-center gap-2 text-text-secondary">
              <CalendarDays size={14} />
              {currentReservation!.date}
            </div>
            <div className="flex items-center gap-2 text-text-secondary">
              <Clock size={14} />
              {currentReservation!.time}
            </div>
            <div className="flex items-center gap-2 text-text-secondary">
              <Users size={14} />
              {currentReservation!.partySize} {t('reserve.guests')} · Table{' '}
              {currentReservation!.tableLabel}
            </div>
          </div>
        </div>

        {/* Pre-order items */}
        {currentReservation!.preOrder.length > 0 && (
          <div className="p-4 rounded-[16px] border border-border-light">
            <h2 className="font-semibold mb-3">
              {t('checkout.pre_order_items')}
            </h2>
            <div className="space-y-2">
              {currentReservation!.preOrder.map((item) => (
                <div
                  key={item.menuItem.id}
                  className="flex items-center justify-between text-sm"
                >
                  <span>
                    {item.quantity}x{' '}
                    {item.menuItem.name[lang] || item.menuItem.name.en}
                  </span>
                  <span className="font-medium">
                    {formatPrice(item.menuItem.price * item.quantity)}
                  </span>
                </div>
              ))}
              <div className="flex items-center justify-between text-sm font-semibold pt-2 border-t border-border-light">
                <span>{t('checkout.subtotal')}</span>
                <span>{formatPrice(preOrderTotal)}</span>
              </div>
            </div>
          </div>
        )}

        {/* Payment method */}
        <div>
          <h2 className="font-semibold mb-3">{t('checkout.payment_method')}</h2>
          <div className="space-y-2">
            {[
              {
                id: 'card',
                label: t('checkout.card'),
                logos: (
                  <div className="flex items-center gap-1.5">
                    <VisaLogo />
                    <MastercardLogo />
                  </div>
                ),
              },
              { id: 'apple_pay', label: 'Apple Pay', logos: <ApplePayLogo /> },
              { id: 'google_pay', label: 'Google Pay', logos: <GooglePayLogo /> },
              { id: 'idram', label: 'Idram', logos: <IdramLogo /> },
              { id: 'telcell', label: 'Telcell Wallet', logos: <TelcellLogo /> },
              {
                id: 'cash',
                label: t('checkout.cash'),
                logos: <Banknote size={22} className="text-text-secondary" />,
              },
            ].map(({ id, label, logos }) => (
              <button
                key={id}
                onClick={() => setPaymentMethod(id)}
                className={cn(
                  'w-full flex items-center gap-3 p-4 rounded-[12px] border transition-colors cursor-pointer',
                  paymentMethod === id
                    ? 'border-primary bg-primary/5'
                    : 'border-border hover:border-text-secondary'
                )}
              >
                <div className="flex items-center justify-center min-w-[60px]">
                  {logos}
                </div>
                <span className="text-sm font-medium">{label}</span>
              </button>
            ))}
          </div>
        </div>

        {/* Total */}
        <div className="flex items-center justify-between py-4 border-t border-border">
          <span className="text-lg font-semibold">{t('checkout.total')}</span>
          <span className="text-lg font-bold text-primary">
            {preOrderTotal > 0 ? formatPrice(preOrderTotal) : 'Free'}
          </span>
        </div>

        <Button size="lg" className="w-full" onClick={handleConfirm} disabled={loading}>
          {loading ? '...' : t('checkout.confirm')}
        </Button>
      </div>
    </div>
  )
}
