import { forwardRef, type InputHTMLAttributes } from 'react'
import { cn } from '@/lib/utils'

const Input = forwardRef<
  HTMLInputElement,
  InputHTMLAttributes<HTMLInputElement>
>(({ className, ...props }, ref) => {
  return (
    <input
      ref={ref}
      className={cn(
        'w-full px-4 py-3 rounded-lg border border-border bg-white text-text-primary placeholder:text-text-tertiary focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary transition-all',
        className
      )}
      {...props}
    />
  )
})

Input.displayName = 'Input'

export { Input }
