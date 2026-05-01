import { useEffect, useMemo, useRef } from 'react'
import {
  Stage,
  Layer,
  Rect,
  Circle,
  Text,
  Group,
  Transformer,
} from 'react-konva'
import Konva from 'konva'
import type { FloorZone, FloorTable } from '@/types'

const STATUS_COLORS: Record<string, string> = {
  available: '#10B981',
  occupied: '#EF4444',
  reserved: '#F59E0B',
}

const SELECTED_COLOR = '#6366F1'
const MIN_TABLE_SIZE = 24

interface FloorPlanEditorProps {
  width: number
  height: number
  zones: FloorZone[]
  tables: FloorTable[]
  selectedTableId: string | null
  onSelect: (id: string | null) => void
  onTableChange: (
    id: string,
    patch: Partial<Pick<FloorTable, 'x' | 'y' | 'width' | 'height' | 'rotation'>>
  ) => void
  maxWidth?: number
  lang?: string
}

export function FloorPlanEditor({
  width,
  height,
  zones,
  tables,
  selectedTableId,
  onSelect,
  onTableChange,
  maxWidth = 900,
  lang = 'en',
}: FloorPlanEditorProps) {
  const stageRef = useRef<Konva.Stage>(null)
  const transformerRef = useRef<Konva.Transformer>(null)

  const scale = useMemo(() => {
    if (width <= maxWidth) return 1
    return maxWidth / width
  }, [width, maxWidth])

  // Attach Transformer to selected table node
  useEffect(() => {
    const tr = transformerRef.current
    const stage = stageRef.current
    if (!tr || !stage) return
    if (!selectedTableId) {
      tr.nodes([])
      tr.getLayer()?.batchDraw()
      return
    }
    const node = stage.findOne(`#table-${selectedTableId}`)
    if (node) {
      tr.nodes([node])
      tr.getLayer()?.batchDraw()
    } else {
      tr.nodes([])
    }
  }, [selectedTableId, tables])

  function handleStageMouseDown(
    e: Konva.KonvaEventObject<MouseEvent | TouchEvent>
  ) {
    if (e.target === e.target.getStage()) {
      onSelect(null)
    }
  }

  return (
    <Stage
      ref={stageRef}
      width={width * scale}
      height={height * scale}
      scaleX={scale}
      scaleY={scale}
      onMouseDown={(e) => handleStageMouseDown(e)}
      onTouchStart={(e) => handleStageMouseDown(e)}
    >
      {/* Zones (read-only background) */}
      <Layer listening={false}>
        {zones.map((z) => (
          <Group key={z.id}>
            <Rect
              x={z.x}
              y={z.y}
              width={z.width}
              height={z.height}
              fill={z.color || '#F3F4F6'}
              stroke="#E5E7EB"
              strokeWidth={1}
              dash={[6, 4]}
              cornerRadius={6}
            />
            <Text
              x={z.x + 8}
              y={z.y + 8}
              text={z.name[lang] || z.name.en || ''}
              fontSize={11}
              fill="#6B7280"
              fontFamily="Inter"
            />
          </Group>
        ))}
      </Layer>

      {/* Tables (interactive) */}
      <Layer>
        {tables.map((t) => (
          <EditorTable
            key={t.id}
            table={t}
            isSelected={t.id === selectedTableId}
            onSelect={() => onSelect(t.id)}
            onChange={(patch) => onTableChange(t.id, patch)}
          />
        ))}
        <Transformer
          ref={transformerRef}
          rotateEnabled
          rotationSnaps={[0, 15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 180, 195, 210, 225, 240, 255, 270, 285, 300, 315, 330, 345]}
          rotationSnapTolerance={5}
          enabledAnchors={[
            'top-left',
            'top-right',
            'bottom-left',
            'bottom-right',
            'middle-left',
            'middle-right',
            'top-center',
            'bottom-center',
          ]}
          boundBoxFunc={(oldBox, newBox) => {
            if (newBox.width < MIN_TABLE_SIZE || newBox.height < MIN_TABLE_SIZE) {
              return oldBox
            }
            return newBox
          }}
          anchorStroke={SELECTED_COLOR}
          anchorFill="#FFFFFF"
          anchorSize={9}
          borderStroke={SELECTED_COLOR}
          borderStrokeWidth={1.5}
        />
      </Layer>
    </Stage>
  )
}

interface EditorTableProps {
  table: FloorTable
  isSelected: boolean
  onSelect: () => void
  onChange: (
    patch: Partial<Pick<FloorTable, 'x' | 'y' | 'width' | 'height' | 'rotation'>>
  ) => void
}

function EditorTable({ table, isSelected, onSelect, onChange }: EditorTableProps) {
  const groupRef = useRef<Konva.Group>(null)

  const cx = table.x + table.width / 2
  const cy = table.y + table.height / 2
  const rotation = table.rotation || 0
  const status = table.status || 'available'
  const color = isSelected ? SELECTED_COLOR : STATUS_COLORS[status] || STATUS_COLORS.available

  function handleDragEnd(e: Konva.KonvaEventObject<DragEvent>) {
    const node = e.target
    onChange({
      x: Math.round(node.x() - table.width / 2),
      y: Math.round(node.y() - table.height / 2),
    })
  }

  function handleTransformEnd() {
    const node = groupRef.current
    if (!node) return
    const scaleX = node.scaleX()
    const scaleY = node.scaleY()
    const newWidth = Math.max(MIN_TABLE_SIZE, Math.round(table.width * scaleX))
    const newHeight = Math.max(MIN_TABLE_SIZE, Math.round(table.height * scaleY))
    const newRotation = ((Math.round(node.rotation()) % 360) + 360) % 360
    const newCx = node.x()
    const newCy = node.y()

    // Reset scale; React will re-render with the new width/height
    node.scaleX(1)
    node.scaleY(1)

    onChange({
      x: Math.round(newCx - newWidth / 2),
      y: Math.round(newCy - newHeight / 2),
      width: newWidth,
      height: newHeight,
      rotation: newRotation,
    })
  }

  return (
    <Group
      ref={groupRef}
      id={`table-${table.id}`}
      x={cx}
      y={cy}
      offsetX={table.width / 2}
      offsetY={table.height / 2}
      rotation={rotation}
      draggable
      onMouseDown={(e) => {
        e.cancelBubble = true
        onSelect()
      }}
      onTouchStart={(e) => {
        e.cancelBubble = true
        onSelect()
      }}
      onDragEnd={handleDragEnd}
      onTransformEnd={handleTransformEnd}
    >
      {table.shape === 'circle' ? (
        <Circle
          x={table.width / 2}
          y={table.height / 2}
          radius={table.width / 2}
          fill={color}
          opacity={0.18}
          stroke={color}
          strokeWidth={isSelected ? 2.5 : 2}
        />
      ) : (
        <Rect
          x={0}
          y={0}
          width={table.width}
          height={table.height}
          fill={color}
          opacity={0.18}
          stroke={color}
          strokeWidth={isSelected ? 2.5 : 2}
          cornerRadius={6}
        />
      )}
      <Text
        x={0}
        y={table.height / 2 - 12}
        width={table.width}
        align="center"
        text={table.label || ''}
        fontSize={13}
        fontStyle="bold"
        fill={color}
        fontFamily="Inter"
        listening={false}
      />
      <Text
        x={0}
        y={table.height / 2 + 2}
        width={table.width}
        align="center"
        text={`${table.seats} seats`}
        fontSize={9}
        fill={color}
        fontFamily="Inter"
        listening={false}
      />
    </Group>
  )
}
