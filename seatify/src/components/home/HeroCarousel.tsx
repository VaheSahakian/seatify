import { useState, useEffect, useCallback } from 'react'
import { useNavigate } from 'react-router-dom'
import { motion, AnimatePresence } from 'framer-motion'
import { ChevronLeft, ChevronRight } from 'lucide-react'

const SLIDES = [
  { name: 'Kamancha Restaurant', slug: 'kamancha', image: '/venues/kamancha.jpg', cuisines: ['Armenian', 'Traditional'] },
  { name: 'InTempo', slug: 'intempo', image: '/venues/intempo.webp', cuisines: ['European', 'Fine Dining'] },
  { name: 'Dragon Garden', slug: 'dragon-garden', image: '/venues/dragon-garden.jpg', cuisines: ['Chinese', 'Asian'] },
  { name: 'Ktoor', slug: 'ktoor', image: '/venues/ktoor.jpg', cuisines: ['Seafood', 'Mediterranean'] },
  { name: 'Black Angus', slug: 'black-angus', image: '/venues/black-angus.jpg', cuisines: ['Burgers', 'American'] },
  { name: 'De Angelo', slug: 'de-angelo', image: '/venues/de-angelo.jpeg', cuisines: ['Italian', 'Pasta'] },
]

const variants = {
  enter: (dir: number) => ({ x: dir > 0 ? '100%' : '-100%', opacity: 0 }),
  center: { x: 0, opacity: 1 },
  exit: (dir: number) => ({ x: dir > 0 ? '-100%' : '100%', opacity: 0 }),
}

export function HeroCarousel() {
  const navigate = useNavigate()
  const [[current, direction], setCurrent] = useState([0, 0])

  const paginate = useCallback((dir: number) => {
    setCurrent(([prev]) => {
      const next = (prev + dir + SLIDES.length) % SLIDES.length
      return [next, dir]
    })
  }, [])

  // Auto-rotate every 4 seconds
  useEffect(() => {
    const timer = setInterval(() => paginate(1), 4000)
    return () => clearInterval(timer)
  }, [paginate])

  const slide = SLIDES[current]

  return (
    <div className="relative rounded-2xl overflow-hidden h-[200px] sm:h-[280px] group">
      <AnimatePresence initial={false} custom={direction} mode="popLayout">
        <motion.div
          key={current}
          custom={direction}
          variants={variants}
          initial="enter"
          animate="center"
          exit="exit"
          transition={{ duration: 0.4, ease: 'easeInOut' }}
          className="absolute inset-0 cursor-pointer"
          onClick={() => navigate(`/venue/${slide.slug}`)}
        >
          <img
            src={slide.image}
            alt={slide.name}
            className="w-full h-full object-cover"
          />
          {/* Gradient overlay */}
          <div className="absolute inset-0 bg-gradient-to-t from-black/70 via-black/20 to-transparent" />

          {/* Text overlay */}
          <div className="absolute bottom-6 left-5 right-5">
            <h3 className="text-white text-xl sm:text-2xl font-bold mb-2 drop-shadow-lg">
              {slide.name}
            </h3>
            <div className="flex gap-2">
              {slide.cuisines.map((c) => (
                <span
                  key={c}
                  className="text-xs px-2.5 py-1 rounded-full bg-white/20 text-white backdrop-blur-sm"
                >
                  {c}
                </span>
              ))}
            </div>
          </div>
        </motion.div>
      </AnimatePresence>

      {/* Nav arrows */}
      <button
        onClick={(e) => { e.stopPropagation(); paginate(-1) }}
        className="absolute left-3 top-1/2 -translate-y-1/2 w-8 h-8 rounded-full bg-white/30 backdrop-blur-sm flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity cursor-pointer"
      >
        <ChevronLeft size={18} className="text-white" />
      </button>
      <button
        onClick={(e) => { e.stopPropagation(); paginate(1) }}
        className="absolute right-3 top-1/2 -translate-y-1/2 w-8 h-8 rounded-full bg-white/30 backdrop-blur-sm flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity cursor-pointer"
      >
        <ChevronRight size={18} className="text-white" />
      </button>

      {/* Dots */}
      <div className="absolute bottom-2 left-1/2 -translate-x-1/2 flex gap-1.5">
        {SLIDES.map((_, i) => (
          <button
            key={i}
            onClick={(e) => {
              e.stopPropagation()
              setCurrent([i, i > current ? 1 : -1])
            }}
            className={`w-2 h-2 rounded-full transition-all cursor-pointer ${
              i === current ? 'bg-white w-4' : 'bg-white/50'
            }`}
          />
        ))}
      </div>
    </div>
  )
}
