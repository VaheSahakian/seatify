import type { FloorPlan } from '@/types'

// 2nd floor for InTempo.
// Layout: Upper Hall (top, larger, L-shaped) + Lower Hall (bottom-left, L-shaped).
// The "Window Nook" alcove and its bay window have been removed; the dividing
// wall between Upper and Lower Hall is now a clean perpendicular Z-step.
export const floor2Walls = {
  solidWalls: [
    // Top wall (exterior)
    [{ x: 56, y: 28 }, { x: 448, y: 28 }],
    // Left wall full height (exterior)
    [{ x: 56, y: 28 }, { x: 56, y: 645 }],
    // Diagonal cut at bottom-left (entrance/doorway)
    [{ x: 56, y: 645 }, { x: 98, y: 687 }],
    // Bottom wall (exterior)
    [{ x: 98, y: 687 }, { x: 294, y: 687 }],
    // Right wall of Lower Hall (exterior)
    [{ x: 294, y: 687 }, { x: 294, y: 449 }],
    // Interior partition between Upper Hall and Lower Hall — clean Z-step
    [{ x: 56, y: 392 }, { x: 196, y: 392 }],
    [{ x: 196, y: 392 }, { x: 196, y: 449 }],
    [{ x: 196, y: 449 }, { x: 294, y: 449 }],
  ],
  windowWalls: [
    // Right side of Upper Hall — bay window zigzag (extended down to y=449)
    [
      { x: 448, y: 28 },
      { x: 448, y: 238 },
      { x: 504, y: 294 },
      { x: 448, y: 350 },
      { x: 448, y: 449 },
    ],
    // Bottom-right edge — south exterior wall of Upper Hall right portion
    [{ x: 448, y: 449 }, { x: 294, y: 449 }],
  ],
}

export const intempoFloor2: FloorPlan = {
  width: 560,
  height: 701,
  zones: [
    {
      id: 'v11-f2-z1',
      name: { en: 'Upper Hall', ru: 'Верхний зал', hy: 'Վերին սրահ' },
      x: 60, y: 32,
      width: 385, height: 415,
      color: '#FFF8E1',
    },
    {
      id: 'v11-f2-z2',
      name: { en: 'Lower Hall', ru: 'Нижний зал', hy: 'Ստորին սրահ' },
      x: 60, y: 395,
      width: 230, height: 288,
      color: '#FFF3E0',
    },
  ],
  tables: [
    // T1: rect, 2 seats — top of Upper Hall, centered along top wall
    { id: 'v11-f2-t1', zoneId: 'v11-f2-z1', x: 223, y: 0, width: 60, height: 50, shape: 'rect', seats: 2, label: 'T1', status: 'available' },
    // T2: round, 4 seats (was rect rotated -90)
    { id: 'v11-f2-t2', zoneId: 'v11-f2-z1', x: 135, y: 75, width: 60, height: 60, shape: 'circle', seats: 4, label: 'T2', status: 'available' },
    // T3: horizontal rect, 4 seats
    { id: 'v11-f2-t3', zoneId: 'v11-f2-z1', x: 286, y: 80, width: 90, height: 50, shape: 'rect', seats: 4, label: 'T3', status: 'available' },
    // T4: vertical rect, 4 seats
    { id: 'v11-f2-t4', zoneId: 'v11-f2-z1', x: 120, y: 190, width: 90, height: 50, shape: 'rect', seats: 4, label: 'T4', status: 'available', rotation: -90 },
    // T5: round, 2 seats
    { id: 'v11-f2-t5', zoneId: 'v11-f2-z1', x: 268, y: 190, width: 50, height: 50, shape: 'circle', seats: 2, label: 'T5', status: 'available' },
    // T6: angled rect ~30°, 4 seats
    { id: 'v11-f2-t6', zoneId: 'v11-f2-z1', x: 368, y: 200, width: 60, height: 50, shape: 'rect', seats: 4, label: 'T6', status: 'available', rotation: -30 },
    // T7: horizontal rect, 4 seats
    { id: 'v11-f2-t7', zoneId: 'v11-f2-z1', x: 286, y: 290, width: 90, height: 50, shape: 'rect', seats: 4, label: 'T7', status: 'available' },
    // T8: horizontal rect, 4 seats — sits inside Upper Hall right extension
    { id: 'v11-f2-t8', zoneId: 'v11-f2-z1', x: 286, y: 375, width: 90, height: 50, shape: 'rect', seats: 4, label: 'T8', status: 'available' },
    // T9: tall vertical rect, 4 seats — moved into Upper Hall, slightly right of T4 column
    { id: 'v11-f2-t9', zoneId: 'v11-f2-z1', x: 200, y: 325, width: 120, height: 50, shape: 'rect', seats: 4, label: 'T9', status: 'available', rotation: -90 },
    // T10: round, 2 seats (was rect)
    { id: 'v11-f2-t10', zoneId: 'v11-f2-z2', x: 78, y: 457, width: 60, height: 60, shape: 'circle', seats: 2, label: 'T10', status: 'available' },
    // T11: vertical rect, 4 seats — shifted left to make room for T12
    { id: 'v11-f2-t11', zoneId: 'v11-f2-z2', x: 128, y: 480, width: 90, height: 50, shape: 'rect', seats: 4, label: 'T11', status: 'available', rotation: 90 },
    // T12: vertical rect, 4 seats — along right wall of Lower Hall (was inside nook)
    { id: 'v11-f2-t12', zoneId: 'v11-f2-z2', x: 220, y: 480, width: 90, height: 50, shape: 'rect', seats: 4, label: 'T12', status: 'available', rotation: 90 },
    // T13: rect, 2 seats — bottom-left corner of Lower Hall (was circle)
    { id: 'v11-f2-t13', zoneId: 'v11-f2-z2', x: 65, y: 585, width: 60, height: 50, shape: 'rect', seats: 2, label: 'T13', status: 'available' },
  ],
}
