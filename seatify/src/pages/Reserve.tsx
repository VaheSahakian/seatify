import { useState, useMemo, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import { ArrowLeft, CalendarDays, Clock, Users, Check } from 'lucide-react'
import { motion, AnimatePresence } from 'framer-motion'
import { format, addDays } from 'date-fns'
import { Button } from '@/components/ui/button'
import { FloorPlan } from '@/components/venue/FloorPlan'
import { VenueMenu } from '@/components/venue/VenueMenu'
import { useVenueStore } from '@/store/venueStore'
import { useReservationStore } from '@/store/reservationStore'
import { useCartStore } from '@/store/cartStore'
import type { FloorTable } from '@/types'
import { intempoFloor2, floor2Walls } from '@/data/intempoFloor2'
import { cn } from '@/lib/utils'


const timeSlots = [
  '11:00', '11:30', '12:00', '12:30', '13:00', '13:30',
  '14:00', '18:00', '18:30', '19:00', '19:30', '20:00',
  '20:30', '21:00', '21:30',
]

const steps = ['step_datetime', 'step_table', 'step_preorder', 'step_checkout'] as const

export default function Reserve() {
  const { venueId } = useParams<{ venueId: string }>()
  const navigate = useNavigate()
  const { t } = useTranslation()
  const { venues, fetchVenues } = useVenueStore()
  const { setCurrentReservation } = useReservationStore()
  const { items: cartItems, clearCart } = useCartStore()

  useEffect(() => {
    fetchVenues()
  }, [fetchVenues])

  const venue = venues.find((v) => v.id === venueId)
  const [step, setStep] = useState(0)
  const [date, setDate] = useState(format(addDays(new Date(), 1), 'yyyy-MM-dd'))
  const [time, setTime] = useState('')
  const [partySize, setPartySize] = useState(2)
  const [selectedTable, setSelectedTable] = useState<FloorTable | null>(null)
  const [selectedFloor, setSelectedFloor] = useState(1)

  const dates = useMemo(
    () => Array.from({ length: 7 }, (_, i) => addDays(new Date(), i + 1)),
    []
  )

  if (!venue) {
    return (
      <div className="flex items-center justify-center min-h-[50vh]">
        <p className="text-text-secondary">Venue not found</p>
      </div>
    )
  }

  const autoAssignTable = () => {
    if (!venue.floorPlan) return null
    const suitable = venue.floorPlan.tables
      .filter((t) => t.seats >= partySize && t.status === 'available')
      .sort((a, b) => a.seats - b.seats)
    return suitable[0] || venue.floorPlan.tables[0] || null
  }

  const canProceed = () => {
    switch (step) {
      case 0:
        return date && time && partySize > 0
      case 1:
        return true // table is now optional
      case 2:
        return true
      default:
        return false
    }
  }

  const handleNext = () => {
    if (step === 1 && !selectedTable) {
      // Auto-assign a table if user skipped selection
      const auto = autoAssignTable()
      if (auto) setSelectedTable(auto)
    }
    if (step === 2) {
      const table = selectedTable || autoAssignTable()
      setCurrentReservation({
        venueId: venue.id,
        venueName: venue.name,
        venueImage: venue.images[0],
        date,
        time,
        partySize,
        tableId: table?.id || '',
        tableLabel: table?.label || 'Auto',
        preOrder: cartItems.filter((i) => i.venueId === venue.id),
      })
      navigate('/checkout')
      return
    }
    setStep((s) => s + 1)
  }

  return (
    <div className="max-w-2xl mx-auto px-4 py-6">
      {/* Header */}
      <div className="flex items-center gap-3 mb-6">
        <button
          onClick={() => (step > 0 ? setStep((s) => s - 1) : navigate(-1))}
          className="w-10 h-10 rounded-full border border-border flex items-center justify-center hover:bg-surface transition-colors cursor-pointer"
        >
          <ArrowLeft size={20} />
        </button>
        <div>
          <h1 className="text-xl font-bold">{t('reserve.title')}</h1>
          <p className="text-sm text-text-secondary">{venue.name}</p>
        </div>
      </div>

      {/* Steps indicator */}
      <div className="flex items-center gap-1 mb-8">
        {steps.map((s, i) => (
          <div key={s} className="flex items-center flex-1">
            <div
              className={cn(
                'flex items-center gap-2 text-xs font-medium',
                i <= step ? 'text-primary' : 'text-text-tertiary'
              )}
            >
              <div
                className={cn(
                  'w-6 h-6 rounded-full flex items-center justify-center text-[10px] font-bold',
                  i < step
                    ? 'bg-primary text-white'
                    : i === step
                    ? 'bg-primary/10 text-primary border-2 border-primary'
                    : 'bg-surface text-text-tertiary'
                )}
              >
                {i < step ? <Check size={12} /> : i + 1}
              </div>
              <span className="hidden sm:block">{t(`reserve.${s}`)}</span>
            </div>
            {i < steps.length - 1 && (
              <div
                className={cn(
                  'flex-1 h-0.5 mx-2',
                  i < step ? 'bg-primary' : 'bg-border-light'
                )}
              />
            )}
          </div>
        ))}
      </div>

      {/* Step content */}
      <AnimatePresence mode="wait">
        <motion.div
          key={step}
          initial={{ opacity: 0, x: 20 }}
          animate={{ opacity: 1, x: 0 }}
          exit={{ opacity: 0, x: -20 }}
          transition={{ duration: 0.2 }}
        >
          {step === 0 && (
            <div className="space-y-6">
              {/* Date */}
              <div>
                <label className="flex items-center gap-2 text-sm font-medium text-text-secondary mb-3">
                  <CalendarDays size={16} />
                  {t('reserve.date')}
                </label>
                <div className="flex gap-2 overflow-x-auto no-scrollbar pb-2">
                  {dates.map((d) => {
                    const val = format(d, 'yyyy-MM-dd')
                    return (
                      <button
                        key={val}
                        onClick={() => setDate(val)}
                        className={cn(
                          'flex flex-col items-center px-4 py-3 rounded-[12px] border min-w-[72px] transition-colors cursor-pointer',
                          date === val
                            ? 'border-primary bg-primary/5 text-primary'
                            : 'border-border text-text-secondary hover:border-text-primary'
                        )}
                      >
                        <span className="text-xs">{format(d, 'EEE')}</span>
                        <span className="text-lg font-semibold">{format(d, 'd')}</span>
                        <span className="text-xs">{format(d, 'MMM')}</span>
                      </button>
                    )
                  })}
                </div>
              </div>

              {/* Time */}
              <div>
                <label className="flex items-center gap-2 text-sm font-medium text-text-secondary mb-3">
                  <Clock size={16} />
                  {t('reserve.time')}
                </label>
                <div className="flex flex-wrap gap-2">
                  {timeSlots.map((slot) => (
                    <button
                      key={slot}
                      onClick={() => setTime(slot)}
                      className={cn(
                        'px-4 py-2 rounded-full text-sm border transition-colors cursor-pointer',
                        time === slot
                          ? 'border-primary bg-primary/5 text-primary font-medium'
                          : 'border-border text-text-secondary hover:border-text-primary'
                      )}
                    >
                      {slot}
                    </button>
                  ))}
                </div>
              </div>

              {/* Party Size */}
              <div>
                <label className="flex items-center gap-2 text-sm font-medium text-text-secondary mb-3">
                  <Users size={16} />
                  {t('reserve.party_size')}
                </label>
                <div className="flex items-center gap-4">
                  <button
                    onClick={() => setPartySize((p) => Math.max(1, p - 1))}
                    className="w-10 h-10 rounded-full border border-border flex items-center justify-center text-lg hover:bg-surface cursor-pointer"
                  >
                    -
                  </button>
                  <span className="text-xl font-semibold w-8 text-center">
                    {partySize}
                  </span>
                  <button
                    onClick={() => setPartySize((p) => Math.min(20, p + 1))}
                    className="w-10 h-10 rounded-full border border-border flex items-center justify-center text-lg hover:bg-surface cursor-pointer"
                  >
                    +
                  </button>
                  <span className="text-sm text-text-secondary">
                    {t('reserve.guests')}
                  </span>
                </div>
              </div>
            </div>
          )}

          {step === 1 && (
            <div>
              <h2 className="font-semibold mb-2">{t('reserve.select_table')}</h2>
              <p className="text-sm text-text-secondary mb-4">
                Choose a table or let us assign one for you
              </p>

              {/* Auto-assign option */}
              <button
                onClick={() => { setSelectedTable(null); handleNext() }}
                className="w-full mb-4 p-3 rounded-[12px] border-2 border-dashed border-primary/30 bg-primary/5 text-primary text-sm font-medium hover:bg-primary/10 transition-colors cursor-pointer"
              >
                Assign me a table automatically (based on party size)
              </button>

              <p className="text-xs text-text-tertiary text-center mb-4">— or pick one yourself —</p>

              {venue.slug === 'intempo' && (
                <div className="flex gap-1 p-1 bg-gray-100 rounded-full w-fit mb-4">
                  <button
                    onClick={() => setSelectedFloor(1)}
                    className={`px-4 py-1.5 rounded-full text-sm font-medium transition-colors cursor-pointer ${selectedFloor === 1 ? 'bg-primary text-white' : 'text-text-secondary hover:text-text-primary'}`}
                  >1st Floor</button>
                  <button
                    onClick={() => setSelectedFloor(2)}
                    className={`px-4 py-1.5 rounded-full text-sm font-medium transition-colors cursor-pointer ${selectedFloor === 2 ? 'bg-primary text-white' : 'text-text-secondary hover:text-text-primary'}`}
                  >2nd Floor</button>
                </div>
              )}

              <FloorPlan
                floorPlan={venue.slug === 'intempo' && selectedFloor === 2 ? intempoFloor2 : venue.floorPlan}
                walls={venue.slug === 'intempo' && selectedFloor === 2 ? floor2Walls : undefined}
                selectedTableId={selectedTable?.id}
                onSelectTable={setSelectedTable}
                selectable
                partySize={partySize}
              />
              {selectedTable && (
                <div className="mt-4 p-3 bg-primary/5 border border-primary/20 rounded-[12px]">
                  <p className="text-sm font-medium text-primary">
                    Table {selectedTable.label} selected ({selectedTable.seats}{' '}
                    seats)
                  </p>
                </div>
              )}
            </div>
          )}

          {step === 2 && (
            <div>
              {/* Sticky action buttons at top for pre-order step */}
              <div className="sticky top-0 z-10 bg-white pb-3 pt-1 -mx-4 px-4 border-b border-border-light mb-4">
                <div className="flex gap-3">
                  <Button variant="outline" className="flex-1" onClick={() => { clearCart(); handleNext() }}>
                    {t('reserve.skip')}
                  </Button>
                  <Button className="flex-1" onClick={handleNext}>
                    {t('reserve.continue')}
                  </Button>
                </div>
              </div>
              <h2 className="font-semibold mb-2">{t('reserve.pre_order')}</h2>
              <p className="text-sm text-text-secondary mb-6">
                {t('reserve.pre_order_desc')}
              </p>
              <VenueMenu venue={venue} />
            </div>
          )}
        </motion.div>
      </AnimatePresence>

      {/* Bottom actions (hidden on pre-order step — buttons are sticky at top there) */}
      {step !== 2 && (
        <div className="flex gap-3 mt-8">
          <Button
            className="flex-1"
            disabled={!canProceed()}
            onClick={handleNext}
          >
            {t('reserve.continue')}
          </Button>
        </div>
      )}
    </div>
  )
}
