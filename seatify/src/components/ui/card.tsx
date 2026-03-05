import type { HTMLAttributes } from 'react'
import { cn } from '@/lib/utils'

function Card({ className, ...props }: HTMLAttributes<HTMLDivElement>) {
  return (
    <div
      className={cn(
        'bg-white rounded-[16px] shadow-md overflow-hidden',
        className
      )}
      {...props}
    />
  )
}

function CardContent({ className, ...props }: HTMLAttributes<HTMLDivElement>) {
  return <div className={cn('p-4', className)} {...props} />
}

export { Card, CardContent }
