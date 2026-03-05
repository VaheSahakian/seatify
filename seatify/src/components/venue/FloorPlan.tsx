import { useState, useMemo } from 'react'
import { Stage, Layer, Rect, Circle, Text, Group } from 'react-konva'
import { useTranslation } from 'react-i18next'
import type { FloorPlan as FloorPlanType, FloorTable } from '@/types'

const STATUS_COLORS = {
  available: '#00A699',
  occupied: '#C13515',
  reserved: '#E07912',
  selected: '#FF385C',
}

interface FloorPlanProps {
  floorPlan: FloorPlanType
  selectedTableId?: string | null
  onSelectTable?: (table: FloorTable) => void
  selectable?: boolean
  partySize?: number
}

export function FloorPlan({
  floorPlan,
  selectedTableId,
  onSelectTable,
  selectable = false,
  partySize = 1,
}: FloorPlanProps) {
  const { t, i18n } = useTranslation()
  const lang = i18n.language
  const [hoveredId, setHoveredId] = useState<string | null>(null)

  const containerWidth = Math.min(floorPlan.width, typeof window !== 'undefined' ? window.innerWidth - 48 : 600)
  const scale = containerWidth / floorPlan.width
  const containerHeight = floorPlan.height * scale

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
            {floorPlan.zones.map((zone) => (
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
            ))}

            {tables.map((table) => {
              const isSelected = table.id === selectedTableId
              const isHovered = table.id === hoveredId
              const color = isSelected
                ? STATUS_COLORS.selected
                : STATUS_COLORS[table.status]
              const opacity =
                selectable && !table.canSelect && !isSelected ? 0.3 : 1

              return (
                <Group
                  key={table.id}
                  opacity={opacity}
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
                      opacity={0.15}
                      stroke={color}
                      strokeWidth={isSelected || isHovered ? 3 : 2}
                    />
                  ) : (
                    <Rect
                      x={table.x}
                      y={table.y}
                      width={table.width}
                      height={table.height}
                      fill={color}
                      opacity={0.15}
                      stroke={color}
                      strokeWidth={isSelected || isHovered ? 3 : 2}
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
                    fill={color}
                    fontFamily="Inter"
                  />
                  <Text
                    x={table.x}
                    y={table.y + table.height / 2 + 2}
                    width={table.width}
                    align="center"
                    text={`${table.seats} seats`}
                    fontSize={9}
                    fill={color}
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
