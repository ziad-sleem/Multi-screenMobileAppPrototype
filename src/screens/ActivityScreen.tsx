import { useState } from 'react'
import { CheckCircleIcon, TrendingUpIcon, ZapIcon, LayersIcon, BriefcaseIcon, AwardIcon, ClockIcon, ChevronRightIcon } from '../lib/icons'

const filters = ['All', 'Transactions', 'Projects', 'System']

const timeline = [
  {
    date: 'Today',
    items: [
      { id: 1, Icon: CheckCircleIcon, color: 'var(--sys-green)', bg: 'rgba(52,199,89,0.18)', title: 'Project Alpha — Milestone 3', sub: 'All deliverables approved by stakeholders', time: '2:14 PM', type: 'Projects', status: 'Completed', statusColor: 'var(--sys-green)', statusBg: 'rgba(52,199,89,0.18)' },
      { id: 2, Icon: TrendingUpIcon, color: 'var(--sys-blue)', bg: 'rgba(0,122,255,0.18)', title: 'Payment Received', sub: '$2,450.00 from Acme Corp', time: '10:32 AM', type: 'Transactions', status: 'Received', statusColor: 'var(--sys-blue)', statusBg: 'rgba(0,122,255,0.18)' },
      { id: 3, Icon: AwardIcon, color: 'var(--sys-yellow)', bg: 'rgba(255,214,10,0.18)', title: 'Achievement Unlocked', sub: '100 tasks completed this quarter', time: '9:05 AM', type: 'System', status: 'New', statusColor: 'var(--sys-yellow)', statusBg: 'rgba(255,214,10,0.18)' },
    ]
  },
  {
    date: 'Yesterday',
    items: [
      { id: 4, Icon: LayersIcon, color: 'var(--sys-purple)', bg: 'rgba(175,82,222,0.18)', title: 'Design System v3', sub: 'Component library published', time: '4:45 PM', type: 'Projects', status: 'Published', statusColor: 'var(--sys-purple)', statusBg: 'rgba(175,82,222,0.18)' },
      { id: 5, Icon: ZapIcon, color: 'var(--sys-teal)', bg: 'rgba(90,200,250,0.18)', title: 'App Deployment', sub: 'v2.3.1 deployed to production', time: '2:30 PM', type: 'System', status: 'Success', statusColor: 'var(--sys-green)', statusBg: 'rgba(52,199,89,0.18)' },
      { id: 6, Icon: TrendingUpIcon, color: 'var(--sys-orange)', bg: 'rgba(255,149,0,0.18)', title: 'Invoice Sent', sub: '$5,800 to GlobalTech Solutions', time: '11:15 AM', type: 'Transactions', status: 'Pending', statusColor: 'var(--sys-orange)', statusBg: 'rgba(255,149,0,0.18)' },
    ]
  },
  {
    date: 'Sep 1',
    items: [
      { id: 7, Icon: BriefcaseIcon, color: 'var(--sys-indigo)', bg: 'rgba(88,86,214,0.18)', title: 'New Project Started', sub: 'Beta Platform Redesign — Q4 2026', time: '3:20 PM', type: 'Projects', status: 'Active', statusColor: 'var(--sys-blue)', statusBg: 'rgba(0,122,255,0.18)' },
      { id: 8, Icon: ClockIcon, color: 'var(--sys-gray)', bg: 'rgba(142,142,147,0.18)', title: 'Weekly Review', sub: 'Completed 34 tasks, 8h logged', time: '9:00 AM', type: 'System', status: 'Done', statusColor: 'var(--sys-green)', statusBg: 'rgba(52,199,89,0.18)' },
    ]
  }
]

export default function ActivityScreen() {
  const [activeFilter, setActiveFilter] = useState('All')

  const filtered = timeline.map(group => ({
    ...group,
    items: group.items.filter(item =>
      activeFilter === 'All' || item.type === activeFilter
    )
  })).filter(g => g.items.length > 0)

  return (
    <div className="absolute inset-0 overflow-y-auto no-scroll" style={{ paddingTop: 130, paddingBottom: 120 }}>
      <div className="px-4 flex flex-col gap-5 pb-4">

        {/* Filter pills */}
        <div className="flex gap-2 overflow-x-auto no-scroll pb-1">
          {filters.map(f => (
            <button
              key={f}
              onClick={() => setActiveFilter(f)}
              className="flex-shrink-0 h-9 px-4 rounded-full btn-press sf-footnote font-medium transition-all duration-200"
              style={activeFilter === f ? {
                background: 'rgba(0,122,255,0.22)',
                color: 'var(--sys-blue)',
                border: '1px solid rgba(0,122,255,0.45)',
                boxShadow: '0 2px 12px rgba(0,122,255,0.25)',
              } : {
                background: 'rgba(255,255,255,0.07)',
                color: 'rgba(255,255,255,0.55)',
                border: '1px solid rgba(255,255,255,0.12)',
              }}
            >
              {f}
            </button>
          ))}
        </div>

        {/* Summary stats */}
        <div className="flex gap-3">
          {[
            { label: 'This Week', value: '24', sub: 'events', color: 'var(--sys-blue)' },
            { label: 'Revenue', value: '$8.2k', sub: 'received', color: 'var(--sys-green)' },
            { label: 'Streak', value: '14d', sub: 'active', color: 'var(--sys-orange)' },
          ].map(s => (
            <div key={s.label} className="flex-1 glass-regular rounded-2xl p-3 glass-sheen text-center">
              <p className="sf-title3 font-bold text-white">{s.value}</p>
              <p className="sf-caption2" style={{ color: s.color }}>{s.sub}</p>
              <p className="sf-caption2 mt-0.5" style={{ color: 'var(--label3)' }}>{s.label}</p>
            </div>
          ))}
        </div>

        {/* Timeline */}
        {filtered.length === 0 ? (
          <div className="glass-regular rounded-3xl p-8 text-center glass-sheen">
            <ClockIcon size={32} className="mx-auto mb-3" style={{ color: 'var(--label3)' } as React.CSSProperties} />
            <p className="sf-callout" style={{ color: 'var(--label2)' }}>No {activeFilter.toLowerCase()} activity</p>
            <p className="sf-footnote mt-1" style={{ color: 'var(--label3)' }}>Activity will appear here as it happens</p>
          </div>
        ) : (
          filtered.map(group => (
            <div key={group.date}>
              <div className="flex items-center gap-3 mb-2.5">
                <span className="sf-footnote font-semibold" style={{ color: 'var(--label2)' }}>{group.date}</span>
                <div className="flex-1 h-px" style={{ background: 'var(--separator)' }} />
                <span className="sf-caption2" style={{ color: 'var(--label4)' }}>{group.items.length} events</span>
              </div>

              <div className="glass-regular rounded-3xl overflow-hidden glass-sheen">
                {group.items.map((item, i) => (
                  <div key={item.id}>
                    <div className="flex items-center gap-3.5 px-4 py-3.5 btn-press cursor-pointer">
                      <div
                        className="w-11 h-11 rounded-2xl flex items-center justify-center flex-shrink-0"
                        style={{ background: item.bg, border: `1px solid ${item.color}33` }}
                      >
                        <item.Icon size={20} style={{ color: item.color } as React.CSSProperties} />
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
                      <ChevronRightIcon size={16} style={{ color: 'var(--label4)' } as React.CSSProperties} />
                    </div>
                    {i < group.items.length - 1 && (
                      <div className="mx-[70px] h-px" style={{ background: 'var(--separator)' }} />
                    )}
                  </div>
                ))}
              </div>
            </div>
          ))
        )}

      </div>
    </div>
  )
}
