export interface User {
  id: string
  name: string
  email: string
  phone?: string
  avatar?: string
  loyaltyPoints: number
  cashback: number
  language: 'en' | 'hy' | 'ru'
}

export interface Venue {
  id: string
  name: string
  slug: string
  description: Record<string, string>
  cuisine: string[]
  priceRange: 1 | 2 | 3 | 4
  rating: number
  reviewCount: number
  address: string
  coordinates: { lat: number; lng: number }
  phone: string
  images: string[]
  hours: DayHours[]
  features: string[]
  policies: Record<string, string>
  floorPlan: FloorPlan
  menu: MenuCategory[]
}

export interface DayHours {
  day: string
  open: string
  close: string
}

export interface FloorPlan {
  width: number
  height: number
  zones: FloorZone[]
  tables: FloorTable[]
}

export interface FloorZone {
  id: string
  name: Record<string, string>
  x: number
  y: number
  width: number
  height: number
  color: string
}

export interface FloorTable {
  id: string
  zoneId: string
  x: number
  y: number
  width: number
  height: number
  shape: 'rect' | 'circle'
  seats: number
  label: string
  status: 'available' | 'occupied' | 'reserved'
}

export interface MenuCategory {
  id: string
  name: Record<string, string>
  items: MenuItem[]
}

export interface MenuItem {
  id: string
  name: Record<string, string>
  description: Record<string, string>
  price: number
  image?: string
  tags: string[]
}

export interface CartItem {
  menuItem: MenuItem
  quantity: number
  venueId: string
}

export interface Reservation {
  id: string
  venueId: string
  venueName: string
  venueImage: string
  date: string
  time: string
  partySize: number
  tableId: string
  tableLabel: string
  status: 'upcoming' | 'completed' | 'cancelled'
  preOrder: CartItem[]
  totalAmount: number
  qrCode: string
  createdAt: string
}

export interface Review {
  id: string
  venueId: string
  userId: string
  userName: string
  userAvatar: string
  rating: number
  comment: Record<string, string>
  date: string
}

export interface SearchFilters {
  query: string
  cuisine: string[]
  priceRange: number[]
  minRating: number
  sortBy: 'rating' | 'distance' | 'price'
}

// ── Admin types ──────────────────────────────────────────────

export interface AdminUser {
  id: string
  venueId: string
  name: string
  email: string
  phone?: string
  role: string
}

export interface AdminDashboard {
  totalReservations: number
  upcomingReservations: number
  todayReservations: number
  averageRating: number
  reviewCount: number
  revenue: number
}

export interface AdminReservation {
  id: string
  customerName: string
  customerPhone: string
  date: string
  time: string
  partySize: number
  tableId: string
  tableLabel: string
  status: string
  totalAmount: number
  paymentMethod: string
  paymentStatus: string
  createdAt: string
}
