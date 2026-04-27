import { useState } from 'react'
import { Star, Send } from 'lucide-react'
import { motion } from 'framer-motion'
import { apiFetch } from '@/lib/api'
import { Button } from '@/components/ui/button'

interface ReviewFormProps {
  venueId: string
  onSubmitted: () => void
}

export function ReviewForm({ venueId, onSubmitted }: ReviewFormProps) {
  const [rating, setRating] = useState(0)
  const [hoveredStar, setHoveredStar] = useState(0)
  const [comment, setComment] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [success, setSuccess] = useState(false)
  const [error, setError] = useState('')

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (rating === 0) {
      setError('Please select a rating')
      return
    }
    setSubmitting(true)
    setError('')
    try {
      await apiFetch(`/api/venues/${venueId}/reviews`, {
        method: 'POST',
        body: JSON.stringify({ rating, comment: { en: comment } }),
      })
      setSuccess(true)
      setRating(0)
      setComment('')
      onSubmitted()
      setTimeout(() => setSuccess(false), 3000)
    } catch {
      setError('Failed to submit review. Please try again.')
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <motion.form
      initial={{ opacity: 0, y: 10 }}
      animate={{ opacity: 1, y: 0 }}
      onSubmit={handleSubmit}
      className="p-4 rounded-[12px] border border-border-light bg-surface/50 mb-6"
    >
      <p className="font-medium text-sm mb-3">Leave a review</p>

      {/* Star rating */}
      <div className="flex items-center gap-1 mb-3">
        {Array.from({ length: 5 }).map((_, idx) => (
          <button
            key={idx}
            type="button"
            onClick={() => setRating(idx + 1)}
            onMouseEnter={() => setHoveredStar(idx + 1)}
            onMouseLeave={() => setHoveredStar(0)}
            className="cursor-pointer p-0.5"
          >
            <Star
              size={24}
              className={
                idx < (hoveredStar || rating)
                  ? 'fill-primary text-primary transition-colors'
                  : 'text-border transition-colors'
              }
            />
          </button>
        ))}
        {rating > 0 && (
          <span className="text-sm text-text-secondary ml-2">{rating}/5</span>
        )}
      </div>

      {/* Comment */}
      <textarea
        value={comment}
        onChange={(e) => setComment(e.target.value)}
        placeholder="Share your experience..."
        rows={3}
        className="w-full px-3 py-2 rounded-[8px] border border-border bg-white text-sm focus:outline-none focus:ring-2 focus:ring-primary/20 focus:border-primary resize-none mb-3"
      />

      {error && (
        <p className="text-sm text-red-500 mb-2">{error}</p>
      )}

      {success && (
        <p className="text-sm text-green-600 mb-2">Review submitted successfully!</p>
      )}

      <Button
        type="submit"
        size="sm"
        disabled={submitting || rating === 0}
        className="flex items-center gap-2"
      >
        <Send size={14} />
        {submitting ? 'Submitting...' : 'Submit review'}
      </Button>
    </motion.form>
  )
}
