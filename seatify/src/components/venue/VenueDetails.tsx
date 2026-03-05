import { useTranslation } from 'react-i18next'
import { Clock, Wifi, Music, Car, Wine, Utensils, Leaf, TreePine, Plug, Gamepad2, Truck, Flame } from 'lucide-react'
import type { Venue } from '@/types'

const featureIcons: Record<string, typeof Wifi> = {
  WiFi: Wifi,
  'Live Music': Music,
  Parking: Car,
  'Valet Parking': Car,
  Terrace: TreePine,
  'Wine Cellar': Wine,
  'Private Rooms': Utensils,
  'Private Dining': Utensils,
  'Sake Bar': Wine,
  'Outdoor Seating': TreePine,
  Hookah: Flame,
  'Power Outlets': Plug,
  'Quiet Zone': Leaf,
  'Board Games': Gamepad2,
  Delivery: Truck,
  'Vegetarian Menu': Leaf,
  'Spice Level Options': Flame,
}

interface VenueDetailsProps {
  venue: Venue
}

export function VenueDetails({ venue }: VenueDetailsProps) {
  const { t, i18n } = useTranslation()
  const lang = i18n.language

  return (
    <div className="space-y-6">
      <div>
        <h3 className="font-semibold mb-3">{t('venue.hours')}</h3>
        <div className="space-y-2">
          {venue.hours.map((h, i) => (
            <div key={i} className="flex items-center gap-3 text-sm">
              <Clock size={16} className="text-text-tertiary shrink-0" />
              <span className="font-medium w-20">{h.day}</span>
              <span className="text-text-secondary">
                {h.open} - {h.close}
              </span>
            </div>
          ))}
        </div>
      </div>

      <div>
        <h3 className="font-semibold mb-3">{t('venue.features')}</h3>
        <div className="flex flex-wrap gap-2">
          {venue.features.map((f) => {
            const Icon = featureIcons[f] || Utensils
            return (
              <span
                key={f}
                className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full bg-surface text-sm text-text-secondary"
              >
                <Icon size={14} />
                {f}
              </span>
            )
          })}
        </div>
      </div>

      <div>
        <h3 className="font-semibold mb-3">{t('venue.policies')}</h3>
        <p className="text-sm text-text-secondary leading-relaxed">
          {typeof venue.policies === 'string'
            ? venue.policies
            : venue.policies[lang] || venue.policies.en}
        </p>
      </div>

      <div>
        <h3 className="font-semibold mb-3">{t('venue.price_range')}</h3>
        <div className="flex items-center gap-1">
          {[1, 2, 3, 4].map((p) => (
            <span
              key={p}
              className={
                p <= venue.priceRange
                  ? 'text-text-primary font-semibold'
                  : 'text-text-tertiary'
              }
            >
              $
            </span>
          ))}
        </div>
      </div>
    </div>
  )
}
