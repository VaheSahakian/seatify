import { useEffect, useState, useRef } from 'react'
import { useNavigate } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import {
  Trophy,
  Star,
  CalendarDays,
  MessageSquare,
  ArrowLeft,
  Gift,
} from 'lucide-react'
import { motion, useMotionValue, useTransform, animate } from 'framer-motion'
import { useAuthStore } from '@/store/authStore'
import { apiFetch } from '@/lib/api'
import type { LoyaltyData, PointTransaction } from '@/types'
import { cn } from '@/lib/utils'

function AnimatedCounter({ value }: { value: number }) {
  const count = useMotionValue(0)
  const rounded = useTransform(count, (latest) => Math.round(latest))
  const [display, setDisplay] = useState(0)

  useEffect(() => {
    const controls = animate(count, value, {
      duration: 1.2,
      ease: 'easeOut',
    })
    const unsubscribe = rounded.on('change', (v) => setDisplay(v))
    return () => {
      controls.stop()
      unsubscribe()
    }
  }, [value, count, rounded])

  return <span>{display}</span>
}

const tierConfig: Record<string, { emoji: string; color: string; bg: string }> = {
  Bronze: { emoji: '\ud83e\udd49', color: 'text-amber-700', bg: 'bg-amber-50' },
  Silver: { emoji: '\ud83e\udd48', color: 'text-gray-500', bg: 'bg-gray-50' },
  Gold: { emoji: '\ud83e\udd47', color: 'text-yellow-500', bg: 'bg-yellow-50' },
}

const tierThresholds = [
  { name: 'Bronze', min: 0, max: 199 },
  { name: 'Silver', min: 200, max: 499 },
  { name: 'Gold', min: 500, max: Infinity },
]

function getProgress(points: number, tier: string) {
  if (tier === 'Gold') {
    return { progress: 100, nextTier: null, pointsToNext: 0 }
  }
  if (tier === 'Silver') {
    const progress = ((points - 200) / (500 - 200)) * 100
    return { progress: Math.min(progress, 100), nextTier: 'Gold', pointsToNext: 500 - points }
  }
  // Bronze
  const progress = (points / 200) * 100
  return { progress: Math.min(progress, 100), nextTier: 'Silver', pointsToNext: 200 - points }
}

function getTransactionIcon(type: string) {
  switch (type) {
    case 'reservation':
      return CalendarDays
    case 'review':
      return MessageSquare
    default:
      return Gift
  }
}

function formatDate(dateStr: string) {
  try {
    const date = new Date(dateStr)
    return date.toLocaleDateString(undefined, {
      month: 'short',
      day: 'numeric',
      year: 'numeric',
    })
  } catch {
    return dateStr
  }
}

export default function Loyalty() {
  const { t } = useTranslation()
  const navigate = useNavigate()
  const { user, isAuthenticated } = useAuthStore()
  const [loyaltyData, setLoyaltyData] = useState<LoyaltyData | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    if (!isAuthenticated) return

    apiFetch<LoyaltyData>('/api/loyalty')
      .then((data) => setLoyaltyData(data))
      .catch(console.error)
      .finally(() => setLoading(false))
  }, [isAuthenticated])

  if (!isAuthenticated || !user) {
    return (
      <div className="max-w-md mx-auto px-4 py-12 text-center">
        <Trophy size={48} className="text-text-tertiary mx-auto mb-4" />
        <h2 className="text-xl font-bold mb-2">Loyalty Program</h2>
        <p className="text-text-secondary mb-6">Sign in to view your loyalty points</p>
        <button
          onClick={() => navigate('/auth')}
          className="px-6 py-2.5 bg-primary text-white rounded-[12px] font-medium"
        >
          Sign In
        </button>
      </div>
    )
  }

  if (loading) {
    return (
      <div className="max-w-md mx-auto px-4 py-12 text-center">
        <div className="animate-pulse space-y-4">
          <div className="h-32 bg-surface rounded-[16px]" />
          <div className="h-20 bg-surface rounded-[16px]" />
          <div className="h-40 bg-surface rounded-[16px]" />
        </div>
      </div>
    )
  }

  const points = loyaltyData?.points ?? user.loyaltyPoints
  const tier = loyaltyData?.tier ?? user.loyaltyTier ?? 'Bronze'
  const history = loyaltyData?.history ?? []
  const tierInfo = tierConfig[tier] ?? tierConfig.Bronze
  const { progress, nextTier, pointsToNext } = getProgress(points, tier)

  return (
    <div className="max-w-md mx-auto px-4 py-6 pb-24">
      {/* Header */}
      <div className="flex items-center gap-3 mb-6">
        <button
          onClick={() => navigate(-1)}
          className="p-2 -ml-2 rounded-full hover:bg-surface transition-colors"
        >
          <ArrowLeft size={20} />
        </button>
        <h1 className="text-2xl font-bold">Loyalty Program</h1>
      </div>

      {/* Points card */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="relative overflow-hidden rounded-[20px] bg-gradient-to-br from-primary to-primary/80 text-white p-6 mb-6"
      >
        <div className="absolute top-0 right-0 w-32 h-32 bg-white/10 rounded-full -translate-y-8 translate-x-8" />
        <div className="absolute bottom-0 left-0 w-24 h-24 bg-white/5 rounded-full translate-y-6 -translate-x-6" />

        <p className="text-white/80 text-sm font-medium mb-1">Your Points</p>
        <div className="text-5xl font-bold mb-2">
          <AnimatedCounter value={points} />
        </div>

        <div className="flex items-center gap-2">
          <span
            className={cn(
              'inline-flex items-center gap-1 px-3 py-1 rounded-full text-sm font-medium',
              'bg-white/20 text-white'
            )}
          >
            <span>{tierInfo.emoji}</span>
            {tier} Tier
          </span>
        </div>
      </motion.div>

      {/* Progress to next tier */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.1 }}
        className="rounded-[16px] border border-border-light p-4 mb-6"
      >
        <div className="flex items-center justify-between mb-3">
          <span className="text-sm font-medium">Tier Progress</span>
          {nextTier ? (
            <span className="text-xs text-text-secondary">
              {pointsToNext} pts to {tierConfig[nextTier]?.emoji} {nextTier}
            </span>
          ) : (
            <span className="text-xs text-yellow-600 font-medium">Max tier reached!</span>
          )}
        </div>

        {/* Tier badges */}
        <div className="flex justify-between mb-2">
          {tierThresholds.map((t) => (
            <div
              key={t.name}
              className={cn(
                'text-center',
                tier === t.name ? 'opacity-100' : 'opacity-40'
              )}
            >
              <span className="text-lg">{tierConfig[t.name]?.emoji}</span>
              <p className="text-[10px] font-medium">{t.name}</p>
            </div>
          ))}
        </div>

        {/* Progress bar */}
        <div className="h-2.5 bg-gray-100 dark:bg-gray-800 rounded-full overflow-hidden">
          <motion.div
            initial={{ width: 0 }}
            animate={{ width: `${progress}%` }}
            transition={{ duration: 1, ease: 'easeOut', delay: 0.3 }}
            className="h-full bg-gradient-to-r from-primary to-primary/70 rounded-full"
          />
        </div>

        <div className="flex justify-between mt-1">
          <span className="text-[10px] text-text-tertiary">0</span>
          <span className="text-[10px] text-text-tertiary">200</span>
          <span className="text-[10px] text-text-tertiary">500</span>
        </div>
      </motion.div>

      {/* How to earn */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.2 }}
        className="rounded-[16px] border border-border-light p-4 mb-6"
      >
        <h3 className="font-semibold mb-3">How to Earn Points</h3>
        <div className="space-y-3">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center flex-shrink-0">
              <CalendarDays size={18} className="text-primary" />
            </div>
            <div className="flex-1">
              <p className="text-sm font-medium">Make a Reservation</p>
              <p className="text-xs text-text-secondary">Book a table at any restaurant</p>
            </div>
            <span className="text-sm font-bold text-primary">+50 pts</span>
          </div>
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-full bg-secondary/10 flex items-center justify-center flex-shrink-0">
              <MessageSquare size={18} className="text-secondary" />
            </div>
            <div className="flex-1">
              <p className="text-sm font-medium">Write a Review</p>
              <p className="text-xs text-text-secondary">Share your experience</p>
            </div>
            <span className="text-sm font-bold text-secondary">+20 pts</span>
          </div>
        </div>
      </motion.div>

      {/* Points history */}
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ delay: 0.3 }}
      >
        <h3 className="font-semibold mb-3">Points History</h3>
        {history.length === 0 ? (
          <div className="text-center py-8 text-text-secondary">
            <Star size={32} className="mx-auto mb-2 opacity-30" />
            <p className="text-sm">No points earned yet</p>
            <p className="text-xs mt-1">Start making reservations to earn points!</p>
          </div>
        ) : (
          <div className="space-y-2">
            {history.map((tx) => {
              const Icon = getTransactionIcon(tx.type)
              return (
                <motion.div
                  key={tx.id}
                  initial={{ opacity: 0, x: -10 }}
                  animate={{ opacity: 1, x: 0 }}
                  className="flex items-center gap-3 p-3 rounded-[12px] bg-surface"
                >
                  <div
                    className={cn(
                      'w-9 h-9 rounded-full flex items-center justify-center flex-shrink-0',
                      tx.type === 'reservation' ? 'bg-primary/10' : 'bg-secondary/10'
                    )}
                  >
                    <Icon
                      size={16}
                      className={
                        tx.type === 'reservation' ? 'text-primary' : 'text-secondary'
                      }
                    />
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="text-sm font-medium truncate">{tx.description}</p>
                    <p className="text-xs text-text-secondary">{formatDate(tx.createdAt)}</p>
                  </div>
                  <span className="text-sm font-bold text-green-600">+{tx.points}</span>
                </motion.div>
              )
            })}
          </div>
        )}
      </motion.div>
    </div>
  )
}
