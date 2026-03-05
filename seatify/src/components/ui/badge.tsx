import type { HTMLAttributes } from 'react'
import { cn } from '@/lib/utils'

interface BadgeProps extends HTMLAttributes<HTMLSpanElement> {
  variant?: 'default' | 'success' | 'warning' | 'error'
}

function Badge({ className, variant = 'default', ...props }: BadgeProps) {
  return (
    <span
      className={cn(
        'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium',
        {
          'bg-surface text-text-secondary': variant === 'default',
          'bg-green-50 text-success': variant === 'success',
          'bg-orange-50 text-warning': variant === 'warning',
          'bg-red-50 text-error': variant === 'error',
        },
        className
      )}
      {...props}
    />
  )
}

export { Badge }
