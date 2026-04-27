import { useState } from 'react'
import { User } from 'lucide-react'

interface UserAvatarProps {
  name?: string
  avatar?: string
  size?: 'sm' | 'md' | 'lg' | 'xl'
  className?: string
}

const sizeMap = {
  sm: 'w-8 h-8 text-sm',
  md: 'w-12 h-12 text-lg',
  lg: 'w-16 h-16 text-2xl',
  xl: 'w-24 h-24 text-4xl',
}

const iconSizeMap = { sm: 14, md: 20, lg: 28, xl: 40 }

// Generate a consistent color from a name
function nameToColor(name: string): string {
  const colors = [
    'bg-rose-500', 'bg-orange-500', 'bg-amber-500', 'bg-emerald-500',
    'bg-teal-500', 'bg-cyan-500', 'bg-blue-500', 'bg-indigo-500',
    'bg-violet-500', 'bg-purple-500', 'bg-pink-500', 'bg-red-500',
  ]
  let hash = 0
  for (let i = 0; i < name.length; i++) {
    hash = name.charCodeAt(i) + ((hash << 5) - hash)
  }
  return colors[Math.abs(hash) % colors.length]
}

export function UserAvatar({ name, avatar, size = 'sm', className = '' }: UserAvatarProps) {
  const [imgFailed, setImgFailed] = useState(false)
  const sizeClass = sizeMap[size]
  const showImage = avatar && !imgFailed

  if (showImage) {
    return (
      <img
        src={avatar}
        alt={name || 'User'}
        onError={() => setImgFailed(true)}
        className={`${sizeClass} rounded-full object-cover border border-border-light ${className}`}
      />
    )
  }

  if (name) {
    const color = nameToColor(name)
    return (
      <div className={`${sizeClass} ${color} rounded-full flex items-center justify-center text-white font-semibold ${className}`}>
        {name.charAt(0).toUpperCase()}
      </div>
    )
  }

  return (
    <div className={`${sizeClass} rounded-full bg-gray-200 flex items-center justify-center text-gray-500 ${className}`}>
      <User size={iconSizeMap[size]} />
    </div>
  )
}
