import { type ReactNode } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { X } from 'lucide-react'
import { cn } from '@/lib/utils'

interface DialogProps {
  open: boolean
  onClose: () => void
  children: ReactNode
  className?: string
}

function Dialog({ open, onClose, children, className }: DialogProps) {
  return (
    <AnimatePresence>
      {open && (
        <div className="fixed inset-0 z-50 flex items-center justify-center">
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            className="absolute inset-0 bg-black/40"
            onClick={onClose}
          />
          <motion.div
            initial={{ opacity: 0, scale: 0.95 }}
            animate={{ opacity: 1, scale: 1 }}
            exit={{ opacity: 0, scale: 0.95 }}
            className={cn(
              'relative bg-white rounded-[16px] shadow-xl p-6 m-4 max-w-md w-full max-h-[90vh] overflow-y-auto',
              className
            )}
          >
            <button
              onClick={onClose}
              className="absolute top-4 right-4 p-1 rounded-full hover:bg-surface transition-colors cursor-pointer"
            >
              <X size={20} />
            </button>
            {children}
          </motion.div>
        </div>
      )}
    </AnimatePresence>
  )
}

export { Dialog }
