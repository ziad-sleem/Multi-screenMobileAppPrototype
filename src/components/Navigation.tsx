import { SparkleIcon, BellIcon, SearchIcon, HomeIcon, CompassIcon, ClockIcon, PersonIcon } from '../lib/icons'

export type MainTab = 'home' | 'discover' | 'activity' | 'profile'

const tabTitles: Record<MainTab, string> = {
  home: 'Dashboard',
  discover: 'Discover',
  activity: 'Activity',
  profile: 'Profile',
}

interface TopBarProps {
  title?: string
  showBack?: boolean
  onBack?: () => void
  rightAction?: React.ReactNode
  tab?: MainTab
}

export function TopBar({ title, showBack, onBack, rightAction, tab }: TopBarProps) {
  const displayTitle = title ?? (tab ? tabTitles[tab] : '')

  return (
    <div className="absolute top-0 left-0 right-0 z-50 px-4 pt-[54px]">
      <div
        className="glass-thin relative flex items-center justify-between h-14 px-4 glass-sheen"
        style={{ borderRadius: 20 }}
      >
        {/* Left: brand or back */}
        {showBack ? (
          <button
            onClick={onBack}
            className="flex items-center gap-1.5 text-[var(--sys-blue)] sf-callout font-medium btn-press"
          >
            <svg width={18} height={18} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2} strokeLinecap="round" strokeLinejoin="round">
              <path d="M15 18l-6-6 6-6"/>
            </svg>
            Back
          </button>
        ) : (
          <div className="flex items-center gap-2">
            <div
              className="w-7 h-7 rounded-lg flex items-center justify-center"
              style={{ background: 'linear-gradient(135deg, var(--sys-indigo), var(--sys-blue))' }}
            >
              <SparkleIcon size={15} className="text-white" />
            </div>
            <span className="sf-headline text-white/90 font-bold tracking-tight">Nexus</span>
          </div>
        )}

        {/* Center: context title */}
        <span className="absolute left-1/2 -translate-x-1/2 sf-headline text-white font-semibold">
          {displayTitle}
        </span>

        {/* Right: actions */}
        <div className="flex items-center gap-2">
          {rightAction ?? (
            <>
              <button className="w-9 h-9 rounded-full glass-ultra-thin flex items-center justify-center btn-press relative">
                <BellIcon size={18} className="text-white/80" />
                <span className="absolute top-1.5 right-1.5 w-2 h-2 rounded-full bg-[var(--sys-red)]" style={{ boxShadow: '0 0 6px var(--sys-red)' }} />
              </button>
              <button className="w-9 h-9 rounded-full glass-ultra-thin flex items-center justify-center btn-press">
                <SearchIcon size={18} className="text-white/80" />
              </button>
            </>
          )}
        </div>
      </div>
    </div>
  )
}

interface BottomNavProps {
  activeTab: MainTab
  onTabChange: (tab: MainTab) => void
}

const tabs: { id: MainTab; label: string; Icon: React.ComponentType<{ size?: number; className?: string; style?: React.CSSProperties }> }[] = [
  { id: 'home',     label: 'Home',     Icon: HomeIcon },
  { id: 'discover', label: 'Discover', Icon: CompassIcon },
  { id: 'activity', label: 'Activity', Icon: ClockIcon },
  { id: 'profile',  label: 'Profile',  Icon: PersonIcon },
]

export function BottomNav({ activeTab, onTabChange }: BottomNavProps) {
  return (
    <div className="absolute bottom-0 left-0 right-0 z-50 px-4 pb-8">
      <div
        className="glass-thin relative flex items-center justify-around h-[68px] px-2 glass-sheen"
        style={{ borderRadius: 26 }}
      >
        {tabs.map(({ id, label, Icon }) => {
          const active = activeTab === id
          return (
            <button
              key={id}
              onClick={() => onTabChange(id)}
              className="flex flex-col items-center gap-1 flex-1 h-full justify-center btn-press transition-all duration-200"
            >
              <div
                className="relative flex items-center justify-center w-10 h-8 rounded-xl transition-all duration-200"
                style={active ? {
                  background: 'rgba(0, 122, 255, 0.22)',
                  boxShadow: '0 2px 12px rgba(0, 122, 255, 0.25)',
                } : {}}
              >
                <Icon
                  size={22}
                  className="transition-all duration-200"
                  style={{ color: active ? 'var(--sys-blue)' : 'rgba(255,255,255,0.45)' } as React.CSSProperties}
                />
                {active && (
                  <span
                    className="absolute -bottom-0.5 left-1/2 -translate-x-1/2 w-1 h-1 rounded-full"
                    style={{ background: 'var(--sys-blue)' }}
                  />
                )}
              </div>
              <span
                className="sf-caption2 transition-all duration-200"
                style={{ color: active ? 'var(--sys-blue)' : 'rgba(255,255,255,0.40)', fontWeight: active ? 600 : 400 }}
              >
                {label}
              </span>
            </button>
          )
        })}
      </div>
    </div>
  )
}

interface AvatarProps {
  name: string
  size?: number
  showStatus?: boolean
  statusColor?: string
}

export function Avatar({ name, size = 44, showStatus, statusColor = 'var(--sys-green)' }: AvatarProps) {
  const initials = name.split(' ').map(n => n[0]).join('').slice(0, 2).toUpperCase()
  return (
    <div className="relative flex-shrink-0" style={{ width: size, height: size }}>
      <div
        className="w-full h-full rounded-full flex items-center justify-center text-white font-semibold select-none"
        style={{
          background: 'linear-gradient(135deg, var(--sys-indigo) 0%, var(--sys-blue) 50%, var(--sys-teal) 100%)',
          fontSize: size * 0.36,
          letterSpacing: '-0.02em',
        }}
      >
        {initials}
      </div>
      {showStatus && (
        <span
          className="absolute bottom-0 right-0 rounded-full border-2 border-[rgba(0,0,0,0.6)]"
          style={{
            width: size * 0.28,
            height: size * 0.28,
            background: statusColor,
            boxShadow: `0 0 8px ${statusColor}`,
          }}
        />
      )}
    </div>
  )
}
