import { useState, useMemo, useEffect, useRef } from 'react'
import { Stage, Layer, Rect, Circle, Text, Group, Image as KonvaImage, Line } from 'react-konva'
import { useTranslation } from 'react-i18next'
import type { FloorPlan as FloorPlanType, FloorTable } from '@/types'

const STATUS_COLORS = {
  available: '#00A699',
  occupied: '#C13515',
  reserved: '#E07912',
  selected: '#FF385C',
}

interface WallData {
  solidWalls: Array<Array<{ x: number; y: number }>>
  windowWalls: Array<Array<{ x: number; y: number }>>
}

interface FloorPlanProps {
  floorPlan: FloorPlanType
  selectedTableId?: string | null
  onSelectTable?: (table: FloorTable) => void
  selectable?: boolean
  partySize?: number
  backgroundImage?: string
  walls?: WallData
}

export function FloorPlan({
  floorPlan,
  selectedTableId,
  onSelectTable,
  selectable = false,
  partySize = 1,
  backgroundImage,
  walls,
}: FloorPlanProps) {
  const { t, i18n } = useTranslation()
  const lang = i18n.language
  const [hoveredId, setHoveredId] = useState<string | null>(null)
  const [bgImg, setBgImg] = useState<HTMLImageElement | null>(null)

  const containerWidth = Math.min(floorPlan.width, typeof window !== 'undefined' ? window.innerWidth - 48 : 600)
  const scale = containerWidth / floorPlan.width
  const containerHeight = floorPlan.height * scale

  // Load background image if provided
  useEffect(() => {
    if (!backgroundImage) return
    const img = new window.Image()
    img.src = backgroundImage
    img.onload = () => setBgImg(img)
  }, [backgroundImage])

  const tables = useMemo(() => {
    return floorPlan.tables.map((table) => ({
      ...table,
      canSelect:
        selectable && table.status === 'available' && table.seats >= partySize,
    }))
  }, [floorPlan.tables, selectable, partySize])

  return (
    <div>
      <div className="border border-border-light rounded-[12px] overflow-hidden bg-white">
        <Stage width={containerWidth} height={containerHeight} scaleX={scale} scaleY={scale}>
          <Layer>
            {/* Background: either image or zone rectangles */}
            {bgImg ? (
              <KonvaImage
                image={bgImg}
                x={0}
                y={0}
                width={floorPlan.width}
                height={floorPlan.height}
              />
            ) : (
              floorPlan.zones.map((zone) => (
                <Group key={zone.id}>
                  <Rect
                    x={zone.x}
                    y={zone.y}
                    width={zone.width}
                    height={zone.height}
                    fill={zone.color}
                    stroke="#EBEBEB"
                    strokeWidth={1}
                  />
                  <Text
                    x={zone.x + 8}
                    y={zone.y + 8}
                    text={zone.name[lang] || zone.name.en}
                    fontSize={11}
                    fill="#717171"
                    fontFamily="Inter"
                  />
                </Group>
              ))
            )}

            {/* Wall segments */}
            {walls && (
              <>
                {/* Solid walls */}
                {walls.solidWalls.map((segment, i) => (
                  <Line
                    key={`solid-wall-${i}`}
                    points={segment.flatMap((p) => [p.x, p.y])}
                    stroke="#9CA3AF"
                    strokeWidth={3}
                    lineCap="round"
                    lineJoin="round"
                  />
                ))}
                {/* Window walls - background glow line */}
                {walls.windowWalls.map((segment, i) => (
                  <Line
                    key={`window-wall-bg-${i}`}
                    points={segment.flatMap((p) => [p.x, p.y])}
                    stroke="#DBEAFE"
                    strokeWidth={6}
                    lineCap="round"
                    lineJoin="round"
                  />
                ))}
                {/* Window walls - dashed foreground line */}
                {walls.windowWalls.map((segment, i) => (
                  <Line
                    key={`window-wall-fg-${i}`}
                    points={segment.flatMap((p) => [p.x, p.y])}
                    stroke="#93C5FD"
                    strokeWidth={4}
                    dash={[8, 4]}
                    lineCap="round"
                    lineJoin="round"
                  />
                ))}
              </>
            )}

            {/* Clickable tables */}
            {tables.map((table) => {
              const isSelected = table.id === selectedTableId
              const isHovered = table.id === hoveredId
              const color = isSelected
                ? STATUS_COLORS.selected
                : STATUS_COLORS[table.status]
              const opacity =
                selectable && !table.canSelect && !isSelected ? 0.3 : 1

              // When using background image, use semi-transparent overlays so tables are visible but image shows through
              const fillOpacity = bgImg ? 0.4 : 0.15
              const strokeW = isSelected || isHovered ? 3 : 2
              const textColor = bgImg ? '#FFFFFF' : color

              const rot = (table as any).rotation || 0
              const cx = table.x + table.width / 2
              const cy = table.y + table.height / 2

              return (
                <Group
                  key={table.id}
                  opacity={opacity}
                  rotation={rot}
                  offsetX={rot ? cx : 0}
                  offsetY={rot ? cy : 0}
                  x={rot ? cx : 0}
                  y={rot ? cy : 0}
                  onMouseEnter={() => setHoveredId(table.id)}
                  onMouseLeave={() => setHoveredId(null)}
                  onClick={() => {
                    if (table.canSelect && onSelectTable) {
                      onSelectTable(table)
                    }
                  }}
                  onTap={() => {
                    if (table.canSelect && onSelectTable) {
                      onSelectTable(table)
                    }
                  }}
                >
                  {table.shape === 'circle' ? (
                    <Circle
                      x={table.x + table.width / 2}
                      y={table.y + table.height / 2}
                      radius={table.width / 2}
                      fill={color}
                      opacity={fillOpacity}
                      stroke={color}
                      strokeWidth={strokeW}
                    />
                  ) : (
                    <Rect
                      x={table.x}
                      y={table.y}
                      width={table.width}
                      height={table.height}
                      fill={color}
                      opacity={fillOpacity}
                      stroke={color}
                      strokeWidth={strokeW}
                      cornerRadius={6}
                    />
                  )}
                  <Text
                    x={table.x}
                    y={table.y + table.height / 2 - 12}
                    width={table.width}
                    align="center"
                    text={table.label}
                    fontSize={13}
                    fontStyle="bold"
                    fill={textColor}
                    fontFamily="Inter"
                  />
                  <Text
                    x={table.x}
                    y={table.y + table.height / 2 + 2}
                    width={table.width}
                    align="center"
                    text={`${table.seats} seats`}
                    fontSize={9}
                    fill={textColor}
                    fontFamily="Inter"
                  />
                </Group>
              )
            })}
          </Layer>
        </Stage>
      </div>

      {selectable && (
        <div className="flex items-center gap-4 mt-4 px-1">
          {(
            [
              ['available', t('reserve.available')],
              ['occupied', t('reserve.occupied')],
              ['reserved', t('reserve.reserved')],
              ['selected', t('reserve.selected')],
            ] as const
          ).map(([status, label]) => (
            <div key={status} className="flex items-center gap-1.5 text-xs text-text-secondary">
              <div
                className="w-3 h-3 rounded-full"
                style={{ backgroundColor: STATUS_COLORS[status] }}
              />
              {label}
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
