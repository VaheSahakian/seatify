import type { FloorPlan } from '@/types'

// Wall segments for the 2nd floor L-shaped layout
// viewBox: 0 0 800 1000
export const floor2Walls = {
  solidWalls: [
    // Top wall
    [{ x: 80, y: 40 }, { x: 640, y: 40 }],
    // Left wall of Upper Hall
    [{ x: 80, y: 40 }, { x: 80, y: 560 }],
    // Partition wall: Upper→Lower step (left side)
    [{ x: 80, y: 560 }, { x: 280, y: 560 }],
    // Partition step down
    [{ x: 280, y: 560 }, { x: 280, y: 640 }],
    // Partition step across
    [{ x: 280, y: 640 }, { x: 420, y: 640 }],
    // Left wall of Lower Hall
    [{ x: 80, y: 560 }, { x: 80, y: 920 }],
    // Diagonal notch at bottom-left
    [{ x: 80, y: 920 }, { x: 140, y: 980 }],
    // Bottom wall of Lower Hall
    [{ x: 140, y: 980 }, { x: 620, y: 980 }],
    // Right wall of Lower Hall
    [{ x: 620, y: 980 }, { x: 620, y: 780 }],
    // Internal partition in Lower Hall (nook)
    [{ x: 420, y: 640 }, { x: 420, y: 780 }],
    [{ x: 420, y: 780 }, { x: 620, y: 780 }],
  ],
  windowWalls: [
    // Upper Hall right side window with outward zigzag alcove
    [
      { x: 640, y: 40 },
      { x: 640, y: 340 },
      { x: 720, y: 420 },   // outward bulge
      { x: 640, y: 500 },   // back inward
      { x: 640, y: 560 },
    ],
    // Lower Hall right side window (upper portion)
    [{ x: 640, y: 560 }, { x: 640, y: 780 }],
    // Bottom-right window segment
    [{ x: 620, y: 980 }, { x: 740, y: 980 }, { x: 740, y: 900 }],
  ],
}

export const intempoFloor2: FloorPlan = {
  width: 800,
  height: 1000,
  zones: [
    {
      id: 'v11-f2-z1',
      name: { en: 'Upper Hall', ru: 'Верхний зал' },
      x: 85, y: 45,
      width: 550, height: 510,
      color: '#FFF8E1',
    },
    {
      id: 'v11-f2-z2',
      name: { en: 'Lower Hall', ru: 'Нижний зал' },
      x: 85, y: 565,
      width: 330, height: 410,
      color: '#FFF3E0',
    },
    {
      id: 'v11-f2-z3',
      name: { en: 'Window Nook', ru: 'У окна' },
      x: 425, y: 645,
      width: 190, height: 130,
      color: '#E3F2FD',
    },
  ],
  tables: [
    // === Upper Hall ===
    // Row 1: top center
    { id: 'v11-f2-t1', zoneId: 'v11-f2-z1', x: 290, y: 70, width: 120, height: 65, shape: 'rect', seats: 4, label: 'T1', status: 'available' },
    // Row 2: left tall + right wide
    { id: 'v11-f2-t2', zoneId: 'v11-f2-z1', x: 130, y: 160, width: 75, height: 110, shape: 'rect', seats: 4, label: 'T2', status: 'available' },
    { id: 'v11-f2-t3', zoneId: 'v11-f2-z1', x: 340, y: 170, width: 140, height: 75, shape: 'rect', seats: 4, label: 'T3', status: 'available' },
    // Row 3: left tall + center circle + T6 in alcove (rotated)
    { id: 'v11-f2-t4', zoneId: 'v11-f2-z1', x: 130, y: 310, width: 75, height: 110, shape: 'rect', seats: 4, label: 'T4', status: 'available' },
    { id: 'v11-f2-t5', zoneId: 'v11-f2-z1', x: 310, y: 340, width: 70, height: 70, shape: 'circle', seats: 2, label: 'T5', status: 'available' },
    // T6: rotated ~20° inside the outward window alcove
    { id: 'v11-f2-t6', zoneId: 'v11-f2-z1', x: 640, y: 395, width: 90, height: 65, shape: 'rect', seats: 4, label: 'T6', status: 'available', rotation: 20 },
    // Middle row (transition area)
    { id: 'v11-f2-t7', zoneId: 'v11-f2-z1', x: 390, y: 480, width: 140, height: 65, shape: 'rect', seats: 4, label: 'T7', status: 'available' },
    // === Between halls ===
    { id: 'v11-f2-t8', zoneId: 'v11-f2-z2', x: 390, y: 580, width: 140, height: 70, shape: 'rect', seats: 4, label: 'T8', status: 'available' },
    // === Lower Hall ===
    // T9: tall rect, left side
    { id: 'v11-f2-t9', zoneId: 'v11-f2-z2', x: 175, y: 610, width: 75, height: 110, shape: 'rect', seats: 4, label: 'T9', status: 'available' },
    // Row: three tables across
    { id: 'v11-f2-t10', zoneId: 'v11-f2-z2', x: 100, y: 780, width: 110, height: 75, shape: 'rect', seats: 2, label: 'T10', status: 'available' },
    { id: 'v11-f2-t11', zoneId: 'v11-f2-z2', x: 230, y: 775, width: 80, height: 90, shape: 'rect', seats: 4, label: 'T11', status: 'available' },
    { id: 'v11-f2-t12', zoneId: 'v11-f2-z2', x: 340, y: 775, width: 85, height: 90, shape: 'rect', seats: 4, label: 'T12', status: 'available' },
    // Bottom-left circle
    { id: 'v11-f2-t13', zoneId: 'v11-f2-z2', x: 100, y: 895, width: 70, height: 70, shape: 'circle', seats: 2, label: 'T13', status: 'available' },
  ],
}
