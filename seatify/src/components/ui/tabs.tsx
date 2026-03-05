import { useState, type ReactNode } from 'react'
import { cn } from '@/lib/utils'

interface Tab {
  label: string
  value: string
  content: ReactNode
}

interface TabsProps {
  tabs: Tab[]
  defaultValue?: string
  className?: string
}

function Tabs({ tabs, defaultValue, className }: TabsProps) {
  const [active, setActive] = useState(defaultValue || tabs[0]?.value)

  return (
    <div className={className}>
      <div className="flex border-b border-border-light overflow-x-auto no-scrollbar">
        {tabs.map((tab) => (
          <button
            key={tab.value}
            onClick={() => setActive(tab.value)}
            className={cn(
              'px-4 py-3 text-sm font-medium whitespace-nowrap transition-colors relative cursor-pointer',
              active === tab.value
                ? 'text-primary'
                : 'text-text-secondary hover:text-text-primary'
            )}
          >
            {tab.label}
            {active === tab.value && (
              <div className="absolute bottom-0 left-0 right-0 h-0.5 bg-primary rounded-full" />
            )}
          </button>
        ))}
      </div>
      <div className="pt-4">
        {tabs.find((t) => t.value === active)?.content}
      </div>
    </div>
  )
}

export { Tabs }
