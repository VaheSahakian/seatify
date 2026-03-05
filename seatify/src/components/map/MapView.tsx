import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet'
import { Icon } from 'leaflet'
import { Link } from 'react-router-dom'
import { Star } from 'lucide-react'
import type { Venue } from '@/types'
import 'leaflet/dist/leaflet.css'

const markerIcon = new Icon({
  iconUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png',
  iconRetinaUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon-2x.png',
  shadowUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png',
  iconSize: [25, 41],
  iconAnchor: [12, 41],
  popupAnchor: [1, -34],
})

interface MapViewProps {
  venues: Venue[]
  center?: [number, number]
  zoom?: number
  className?: string
}

export function MapView({
  venues,
  center = [40.1811, 44.5136],
  zoom = 14,
  className = 'h-[400px] rounded-[16px] overflow-hidden',
}: MapViewProps) {
  return (
    <div className={className}>
      <MapContainer center={center} zoom={zoom} className="h-full w-full" scrollWheelZoom={false}>
        <TileLayer
          attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>'
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        />
        {venues.map((venue) => (
          <Marker
            key={venue.id}
            position={[venue.coordinates.lat, venue.coordinates.lng]}
            icon={markerIcon}
          >
            <Popup>
              <Link to={`/venue/${venue.slug}`} className="block">
                <div className="min-w-[180px]">
                  <img
                    src={venue.images[0]}
                    alt={venue.name}
                    className="w-full h-24 object-cover rounded-md mb-2"
                  />
                  <h3 className="font-semibold text-sm">{venue.name}</h3>
                  <div className="flex items-center gap-1 mt-1">
                    <Star size={12} className="fill-primary text-primary" />
                    <span className="text-xs">{venue.rating}</span>
                    <span className="text-xs text-text-tertiary">
                      ({venue.reviewCount})
                    </span>
                  </div>
                  <p className="text-xs text-text-secondary mt-1">
                    {venue.cuisine.join(' · ')}
                  </p>
                </div>
              </Link>
            </Popup>
          </Marker>
        ))}
      </MapContainer>
    </div>
  )
}
