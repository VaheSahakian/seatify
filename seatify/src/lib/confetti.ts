import confetti from 'canvas-confetti'

export function fireConfetti() {
  // First burst
  confetti({
    particleCount: 100,
    spread: 70,
    origin: { y: 0.6 },
    colors: ['#E63946', '#457B9D', '#F1FAEE', '#A8DADC', '#1D3557'],
  })
  // Second burst delayed
  setTimeout(() => {
    confetti({
      particleCount: 50,
      angle: 60,
      spread: 55,
      origin: { x: 0 },
      colors: ['#E63946', '#457B9D', '#F1FAEE'],
    })
    confetti({
      particleCount: 50,
      angle: 120,
      spread: 55,
      origin: { x: 1 },
      colors: ['#A8DADC', '#1D3557', '#E63946'],
    })
  }, 250)
}
