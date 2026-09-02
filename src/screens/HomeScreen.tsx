import { Avatar } from '../components/Navigation'
import {
  TrendingUpIcon, TrendingDownIcon, ChevronRightIcon,
  ZapIcon, CheckCircleIcon, BriefcaseIcon, ClockIcon, AwardIcon, LayersIcon
} from '../lib/icons'

const now = new Date()
const hours = now.getHours()
const greeting = hours < 12 ? 'Good morning' : hours < 18 ? 'Good afternoon' : 'Good evening'
const dateStr = now.toLocaleDateString('en-US', { weekday: 'long', month: 'long', day: 'numeric' })

const stats = [
  { label: 'Projects', value: '12', sub: '+3 this month', Icon: BriefcaseIcon, color: 'var(--sys-blue)', trend: 'up' },
  { label: 'Tasks', value: '48', sub: '8 due today', Icon: CheckCircleIcon, color: 'var(--sys-purple)', trend: 'neutral' },
  { label: 'Score', value: '94%', sub: '+2% this week', Icon: ZapIcon, color: 'var(--sys-green)', trend: 'up' },
  { label: 'Hours', value: '128h', sub: 'this month', Icon: ClockIcon, color: 'var(--sys-orange)', trend: 'neutral' },
]

const activities = [
  {
    id: 1,
    Icon: CheckCircleIcon,
    iconColor: 'var(--sys-green)',
    iconBg: 'rgba(52,199,89,0.18)',
    title: 'Project Alpha',
    sub: 'Milestone completed successfully',
    time: '2h ago',
    status: 'Completed',
    statusColor: 'var(--sys-green)',
    statusBg: 'rgba(52,199,89,0.18)',
  },
  {
    id: 2,
    Icon: TrendingUpIcon,
    iconColor: 'var(--sys-blue)',
    iconBg: 'rgba(0,122,255,0.18)',
    title: 'Payment Received',
    sub: '$2,450 from Acme Corp',
    time: '5h ago',
    status: 'Received',
    statusColor: 'var(--sys-blue)',
    statusBg: 'rgba(0,122,255,0.18)',
  },
  {
    id: 3,
    Icon: LayersIcon,
    iconColor: 'var(--sys-purple)',
    iconBg: 'rgba(175,82,222,0.18)',
    title: 'Design Review',
    sub: 'Feedback session scheduled',
    time: 'Yesterday',
    status: 'Pending',
    statusColor: 'var(--sys-orange)',
    statusBg: 'rgba(255,149,0,0.18)',
  },
  {
    id: 4,
    Icon: ZapIcon,
    iconColor: 'var(--sys-teal)',
    iconBg: 'rgba(90,200,250,0.18)',
    title: 'App Deployment',
    sub: 'v2.3.1 deployed to production',
    time: '2d ago',
    status: 'Success',
    statusColor: 'var(--sys-green)',
    statusBg: 'rgba(52,199,89,0.18)',
  },
]

export default function HomeScreen() {
  return (
    <div className="absolute inset-0 overflow-y-auto no-scroll" style={{ paddingTop: 130, paddingBottom: 120 }}>
      <div className="px-4 flex flex-col gap-5 pb-4">

        {/* Greeting section */}
        <div className="flex items-start justify-between">
          <div>
            <p className="sf-footnote font-medium mb-0.5" style={{ color: 'var(--label3)' }}>{dateStr}</p>
            <h1 className="sf-title2 text-white">{greeting},</h1>
            <h1 className="sf-title2" style={{ background: 'linear-gradient(90deg, var(--sys-blue), var(--sys-purple))', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>
              Alex Johnson
            </h1>
          </div>
          <div className="flex flex-col items-end gap-2">
            <Avatar name="Alex Johnson" size={48} showStatus />
            <div
              className="rounded-full px-2.5 py-1 flex items-center gap-1.5"
              style={{ background: 'rgba(52,199,89,0.18)', border: '1px solid rgba(52,199,89,0.3)' }}
            >
              <span className="w-1.5 h-1.5 rounded-full pulse-glow" style={{ background: 'var(--sys-green)' }} />
              <span className="sf-caption2 font-semibold" style={{ color: 'var(--sys-green)' }}>Active</span>
            </div>
          </div>
        </div>

        {/* Primary highlight card */}
        <div
          className="relative rounded-3xl p-5 overflow-hidden glass-sheen"
          style={{
            background: 'linear-gradient(135deg, rgba(88,86,214,0.35) 0%, rgba(0,122,255,0.30) 50%, rgba(90,200,250,0.25) 100%)',
            backdropFilter: 'blur(32px) saturate(200%)',
            WebkitBackdropFilter: 'blur(32px) saturate(200%)',
            border: '1px solid rgba(255,255,255,0.22)',
            boxShadow: '0 8px 40px rgba(88,86,214,0.35), inset 0 1px 0 rgba(255,255,255,0.25)',
          }}
        >
          {/* Background glow */}
          <div className="absolute -top-8 -right-8 w-40 h-40 rounded-full opacity-20 pointer-events-none"
            style={{ background: 'radial-gradient(circle, var(--sys-blue), transparent)' }} />

          <div className="relative">
            <div className="flex items-start justify-between mb-4">
              <div>
                <p className="sf-footnote font-medium mb-1" style={{ color: 'rgba(255,255,255,0.65)' }}>Portfolio Overview</p>
                <p className="sf-large-title text-white font-bold">$124,850</p>
                <p className="sf-callout text-white/70">.40 USD</p>
              </div>
              <div
                className="flex items-center gap-1.5 rounded-2xl px-3 py-1.5"
                style={{ background: 'rgba(52,199,89,0.22)', border: '1px solid rgba(52,199,89,0.35)' }}
              >
                <TrendingUpIcon size={14} style={{ color: 'var(--sys-green)' } as React.CSSProperties} />
                <span className="sf-footnote font-semibold" style={{ color: 'var(--sys-green)' }}>+12.4%</span>
              </div>
            </div>

            <p className="sf-caption1 mb-4" style={{ color: 'rgba(255,255,255,0.50)' }}>
              ↑ $13,820 growth this month · 3 active positions
            </p>

            {/* Mini chart bars */}
            <div className="flex items-end gap-1.5 mb-5 h-10">
              {[40, 55, 45, 70, 60, 80, 65, 90, 75, 95, 85, 100].map((h, i) => (
                <div
                  key={i}
                  className="flex-1 rounded-sm transition-all"
                  style={{
                    height: `${h}%`,
                    background: i === 11
                      ? 'var(--sys-blue)'
                      : 'rgba(255,255,255,0.2)',
                    borderRadius: 3,
                  }}
                />
              ))}
            </div>

            <div className="flex gap-3">
              <button
                className="flex-1 h-11 rounded-2xl btn-press flex items-center justify-center sf-footnote font-semibold"
                style={{
                  background: 'rgba(255,255,255,0.15)',
                  border: '1px solid rgba(255,255,255,0.25)',
                  color: 'white',
                }}
              >
                View Details
              </button>
              <button
                className="flex-1 h-11 rounded-2xl btn-press flex items-center justify-center sf-footnote font-semibold glass-sheen"
                style={{
                  background: 'rgba(0,122,255,0.85)',
                  border: '1px solid rgba(0,122,255,0.5)',
                  color: 'white',
                  boxShadow: '0 4px 16px rgba(0,122,255,0.4)',
                }}
              >
                Invest Now
              </button>
            </div>
          </div>
        </div>

        {/* 2×2 Stats grid */}
        <div className="grid grid-cols-2 gap-3">
          {stats.map(({ label, value, sub, Icon, color, trend }) => (
            <div
              key={label}
              className="glass-regular relative rounded-3xl p-4 glass-sheen overflow-hidden"
            >
              <div className="absolute top-3 right-3">
                <div className="w-8 h-8 rounded-xl flex items-center justify-center"
                  style={{ background: `${color}22`, border: `1px solid ${color}33` }}>
                  <Icon size={16} style={{ color } as React.CSSProperties} />
                </div>
              </div>
              <div className="mb-1">
                <p className="sf-title2 text-white font-bold">{value}</p>
              </div>
              <p className="sf-footnote font-semibold mb-1" style={{ color: 'var(--label2)' }}>{label}</p>
              <div className="flex items-center gap-1">
                {trend === 'up' && <TrendingUpIcon size={11} style={{ color: 'var(--sys-green)' } as React.CSSProperties} />}
                <p className="sf-caption2" style={{ color: trend === 'up' ? 'var(--sys-green)' : 'var(--label3)' }}>{sub}</p>
              </div>
            </div>
          ))}
        </div>

        {/* Recent activity */}
        <div>
          <div className="flex items-center justify-between mb-3">
            <h2 className="sf-headline text-white">Recent Activity</h2>
            <button className="sf-callout btn-press" style={{ color: 'var(--sys-blue)' }}>See All</button>
          </div>

          <div className="glass-regular rounded-3xl overflow-hidden glass-sheen">
            {activities.map((item, i) => (
              <div key={item.id}>
                <div className="flex items-center gap-3.5 px-4 py-3.5">
                  <div
                    className="w-11 h-11 rounded-2xl flex items-center justify-center flex-shrink-0"
                    style={{ background: item.iconBg, border: `1px solid ${item.iconColor}33` }}
                  >
                    <item.Icon size={20} style={{ color: item.iconColor } as React.CSSProperties} />
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="sf-footnote font-semibold text-white truncate">{item.title}</p>
                    <p className="sf-caption1 truncate" style={{ color: 'var(--label3)' }}>{item.sub}</p>
                  </div>
                  <div className="flex flex-col items-end gap-1.5 flex-shrink-0">
                    <span
                      className="sf-caption2 font-semibold rounded-full px-2 py-0.5"
                      style={{ background: item.statusBg, color: item.statusColor }}
                    >
                      {item.status}
                    </span>
                    <span className="sf-caption2" style={{ color: 'var(--label4)' }}>{item.time}</span>
                  </div>
                  <ChevronRightIcon size={16} className="flex-shrink-0" style={{ color: 'var(--label4)' } as React.CSSProperties} />
                </div>
                {i < activities.length - 1 && (
                  <div className="mx-[70px] h-px" style={{ background: 'var(--separator)' }} />
                )}
              </div>
            ))}
          </div>
        </div>

        {/* Quick actions row */}
        <div>
          <h2 className="sf-headline text-white mb-3">Quick Actions</h2>
          <div className="flex gap-3 overflow-x-auto no-scroll pb-1">
            {[
              { label: 'New Task', Icon: CheckCircleIcon, color: 'var(--sys-blue)' },
              { label: 'Report', Icon: TrendingUpIcon, color: 'var(--sys-purple)' },
              { label: 'Schedule', Icon: ClockIcon, color: 'var(--sys-orange)' },
              { label: 'Award', Icon: AwardIcon, color: 'var(--sys-yellow)' },
            ].map(({ label, Icon, color }) => (
              <button
                key={label}
                className="flex flex-col items-center gap-2 flex-shrink-0 w-20 py-4 rounded-3xl glass-regular glass-sheen btn-press"
              >
                <Icon size={22} style={{ color } as React.CSSProperties} />
                <span className="sf-caption2 text-white/70 text-center">{label}</span>
              </button>
            ))}
          </div>
        </div>

      </div>
    </div>
  )
}
