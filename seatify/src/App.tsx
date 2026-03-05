import { useEffect } from 'react'
import { BrowserRouter, Routes, Route } from 'react-router-dom'
import { Layout } from '@/components/layout/Layout'
import Home from '@/pages/Home'
import SearchPage from '@/pages/SearchPage'
import VenueDetail from '@/pages/VenueDetail'
import Reserve from '@/pages/Reserve'
import Checkout from '@/pages/Checkout'
import Reservations from '@/pages/Reservations'
import ReservationDetail from '@/pages/ReservationDetail'
import Orders from '@/pages/Orders'
import Profile from '@/pages/Profile'
import Auth from '@/pages/Auth'
import NotFound from '@/pages/NotFound'
import { useAuthStore } from '@/store/authStore'

import AdminLogin from '@/pages/admin/AdminLogin'
import { AdminGuard } from '@/components/admin/AdminGuard'
import { AdminLayout } from '@/components/admin/AdminLayout'
import AdminDashboard from '@/pages/admin/AdminDashboard'
import AdminVenueInfo from '@/pages/admin/AdminVenueInfo'
import AdminMenu from '@/pages/admin/AdminMenu'
import AdminFloorPlan from '@/pages/admin/AdminFloorPlan'
import AdminHours from '@/pages/admin/AdminHours'
import AdminImages from '@/pages/admin/AdminImages'
import AdminReservations from '@/pages/admin/AdminReservations'

export default function App() {
  const initialize = useAuthStore((s) => s.initialize)

  useEffect(() => {
    initialize()
  }, [initialize])

  return (
    <BrowserRouter>
      <Routes>
        {/* Customer routes */}
        <Route element={<Layout />}>
          <Route path="/" element={<Home />} />
          <Route path="/search" element={<SearchPage />} />
          <Route path="/venue/:slug" element={<VenueDetail />} />
          <Route path="/reserve/:venueId" element={<Reserve />} />
          <Route path="/checkout" element={<Checkout />} />
          <Route path="/reservations" element={<Reservations />} />
          <Route path="/reservations/:id" element={<ReservationDetail />} />
          <Route path="/orders" element={<Orders />} />
          <Route path="/profile" element={<Profile />} />
          <Route path="/auth" element={<Auth />} />
        </Route>

        {/* Admin routes */}
        <Route path="/admin/login" element={<AdminLogin />} />
        <Route element={<AdminGuard />}>
          <Route element={<AdminLayout />}>
            <Route path="/admin" element={<AdminDashboard />} />
            <Route path="/admin/venue" element={<AdminVenueInfo />} />
            <Route path="/admin/menu" element={<AdminMenu />} />
            <Route path="/admin/floor-plan" element={<AdminFloorPlan />} />
            <Route path="/admin/hours" element={<AdminHours />} />
            <Route path="/admin/images" element={<AdminImages />} />
            <Route path="/admin/reservations" element={<AdminReservations />} />
          </Route>
        </Route>

        <Route path="*" element={<NotFound />} />
      </Routes>
    </BrowserRouter>
  )
}
