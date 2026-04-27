import { Skeleton } from '@/components/ui/Skeleton'

export function VenueCardSkeleton() {
  return (
    <div className="block">
      {/* Image placeholder */}
      <Skeleton className="aspect-[4/3] rounded-[16px] mb-3" />
      {/* Title */}
      <div className="flex items-start justify-between gap-2">
        <Skeleton className="h-4 w-3/4" />
        <Skeleton className="h-4 w-8" />
      </div>
      {/* Address */}
      <Skeleton className="h-3 w-1/2 mt-2" />
      {/* Tags */}
      <div className="flex gap-1.5 mt-3">
        <Skeleton className="h-5 w-14 rounded-full" />
        <Skeleton className="h-5 w-16 rounded-full" />
        <Skeleton className="h-5 w-12 rounded-full" />
      </div>
    </div>
  )
}
