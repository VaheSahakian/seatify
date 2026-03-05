import { forwardRef, type ButtonHTMLAttributes } from 'react'
import { cn } from '@/lib/utils'

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'primary' | 'secondary' | 'outline' | 'ghost' | 'link'
  size?: 'sm' | 'md' | 'lg'
}

const Button = forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant = 'primary', size = 'md', ...props }, ref) => {
    return (
      <button
        ref={ref}
        className={cn(
          'inline-flex items-center justify-center font-medium rounded-lg transition-all duration-200 disabled:opacity-50 disabled:pointer-events-none cursor-pointer',
          {
            'bg-primary text-white hover:bg-primary-dark active:scale-[0.98] shadow-sm':
              variant === 'primary',
            'bg-surface text-text-primary hover:bg-surface-hover':
              variant === 'secondary',
            'border border-border text-text-primary hover:bg-surface':
              variant === 'outline',
            'text-text-primary hover:bg-surface': variant === 'ghost',
            'text-primary hover:underline p-0': variant === 'link',
          },
          {
            'text-sm px-3 py-1.5': size === 'sm',
            'text-sm px-4 py-2.5': size === 'md',
            'text-base px-6 py-3': size === 'lg',
          },
          className
        )}
        {...props}
      />
    )
  }
)

Button.displayName = 'Button'

export { Button }
