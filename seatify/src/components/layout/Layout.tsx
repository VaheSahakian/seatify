import { Outlet } from 'react-router-dom'
import { Navbar } from './Navbar'
import { BottomNav } from './BottomNav'
import { Toaster } from 'sonner'

export function Layout() {
  return (
    <div className="min-h-screen min-h-dvh flex flex-col bg-background">
      <Navbar />
      <main className="flex-1 pb-20 md:pb-0">
        <Outlet />
      </main>
      <BottomNav />
      <Toaster position="top-center" richColors />
    </div>
  )
}
