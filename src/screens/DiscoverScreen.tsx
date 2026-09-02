import { useState } from 'react'
import { SearchIcon, StarIcon, ZapIcon, GridIcon, LayersIcon, BriefcaseIcon, TrendingUpIcon, ChevronRightIcon } from '../lib/icons'

const categories = [
  { label: 'Design', color: 'var(--sys-purple)', bg: 'rgba(175,82,222,0.2)' },
  { label: 'Dev', color: 'var(--sys-blue)', bg: 'rgba(0,122,255,0.2)' },
  { label: 'Analytics', color: 'var(--sys-teal)', bg: 'rgba(90,200,250,0.2)' },
  { label: 'Finance', color: 'var(--sys-green)', bg: 'rgba(52,199,89,0.2)' },
  { label: 'Marketing', color: 'var(--sys-orange)', bg: 'rgba(255,149,0,0.2)' },
]

const featured = [
  { name: 'Nexus AI', desc: 'Intelligent task automation with machine learning', Icon: ZapIcon, color: 'var(--sys-blue)', rating: '4.9', users: '24k' },
  { name: 'FlowBoard', desc: 'Visual project management for modern teams', Icon: GridIcon, color: 'var(--sys-purple)', rating: '4.8', users: '18k' },
  { name: 'DataPulse', desc: 'Real-time analytics and business intelligence', Icon: TrendingUpIcon, color: 'var(--sys-green)', rating: '4.7', users: '31k' },
]

const trending = [
  { name: 'Workspace Pro', Icon: BriefcaseIcon, color: 'var(--sys-orange)', tag: 'New', users: '5.2k' },
  { name: 'LayerStack', Icon: LayersIcon, color: 'var(--sys-indigo)', tag: 'Popular', users: '12k' },
  { name: 'StarTrack', Icon: StarIcon, color: 'var(--sys-yellow)', tag: 'Trending', users: '9.8k' },
  { name: 'ZapFlow', Icon: ZapIcon, color: 'var(--sys-teal)', tag: 'Hot', users: '7.3k' },
]

export default function DiscoverScreen() {
  const [activeCategory, setActiveCategory] = useState('Design')
  const [searchQuery, setSearchQuery] = useState('')

  return (
    <div className="absolute inset-0 overflow-y-auto no-scroll" style={{ paddingTop: 130, paddingBottom: 120 }}>
      <div className="px-4 flex flex-col gap-6 pb-4">

        {/* Search bar */}
        <div className="relative">
          <SearchIcon size={18} className="absolute left-4 top-1/2 -translate-y-1/2 text-white/35 pointer-events-none" />
          <input
            type="search"
            value={searchQuery}
            onChange={e => setSearchQuery(e.target.value)}
            placeholder="Search tools, templates, integrations…"
            className="glass-input glass-regular w-full h-12 pl-11 pr-4 rounded-2xl sf-callout text-white placeholder-white/25 bg-transparent"
            style={{ outline: 'none' }}
          />
        </div>

        {/* Categories */}
        <div>
          <div className="flex gap-2 overflow-x-auto no-scroll pb-1">
            {categories.map(cat => (
              <button
                key={cat.label}
                onClick={() => setActiveCategory(cat.label)}
                className="flex-shrink-0 h-9 px-4 rounded-full btn-press sf-footnote font-medium transition-all duration-200"
                style={activeCategory === cat.label ? {
                  background: cat.bg,
                  color: cat.color,
                  border: `1px solid ${cat.color}50`,
                  boxShadow: `0 2px 12px ${cat.color}30`,
                } : {
                  background: 'rgba(255,255,255,0.07)',
                  color: 'rgba(255,255,255,0.55)',
                  border: '1px solid rgba(255,255,255,0.12)',
                }}
              >
                {cat.label}
              </button>
            ))}
          </div>
        </div>

        {/* Featured section */}
        <div>
          <div className="flex items-center justify-between mb-3">
            <h2 className="sf-headline text-white">Featured</h2>
            <button className="sf-callout btn-press" style={{ color: 'var(--sys-blue)' }}>See All</button>
          </div>
          <div className="flex gap-3 overflow-x-auto no-scroll pb-1">
            {featured.map(item => (
              <div
                key={item.name}
                className="flex-shrink-0 w-56 glass-regular rounded-3xl p-4 glass-sheen btn-press cursor-pointer overflow-hidden relative"
              >
                <div className="absolute -top-4 -right-4 w-24 h-24 rounded-full opacity-15 pointer-events-none"
                  style={{ background: `radial-gradient(circle, ${item.color}, transparent)` }} />
                <div className="relative">
                  <div
                    className="w-12 h-12 rounded-2xl mb-3 flex items-center justify-center"
                    style={{ background: `${item.color}25`, border: `1px solid ${item.color}40`, boxShadow: `0 4px 16px ${item.color}30` }}
                  >
                    <item.Icon size={24} style={{ color: item.color } as React.CSSProperties} />
                  </div>
                  <p className="sf-footnote font-semibold text-white mb-1">{item.name}</p>
                  <p className="sf-caption1 mb-3" style={{ color: 'var(--label3)' }}>{item.desc}</p>
                  <div className="flex items-center justify-between">
                    <div className="flex items-center gap-1">
                      <StarIcon size={12} fill="var(--sys-yellow)" stroke="var(--sys-yellow)" strokeWidth={0} />
                      <span className="sf-caption2 font-semibold text-white">{item.rating}</span>
                    </div>
                    <span className="sf-caption2" style={{ color: 'var(--label3)' }}>{item.users} users</span>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Trending */}
        <div>
          <div className="flex items-center justify-between mb-3">
            <h2 className="sf-headline text-white">Trending Now</h2>
            <TrendingUpIcon size={18} style={{ color: 'var(--sys-orange)' } as React.CSSProperties} />
          </div>
          <div className="glass-regular rounded-3xl overflow-hidden glass-sheen">
            {trending.map((item, i) => (
              <div key={item.name}>
                <div className="flex items-center gap-3.5 px-4 py-3.5 btn-press cursor-pointer">
                  <div
                    className="w-11 h-11 rounded-2xl flex items-center justify-center flex-shrink-0"
                    style={{ background: `${item.color}22`, border: `1px solid ${item.color}33` }}
                  >
                    <item.Icon size={20} style={{ color: item.color } as React.CSSProperties} />
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="sf-footnote font-semibold text-white">{item.name}</p>
                    <p className="sf-caption2" style={{ color: 'var(--label3)' }}>{item.users} active users</p>
                  </div>
                  <span
                    className="sf-caption2 font-semibold rounded-full px-2.5 py-1"
                    style={{
                      background: item.tag === 'New' ? 'rgba(52,199,89,0.2)' :
                                  item.tag === 'Hot' ? 'rgba(255,59,48,0.2)' :
                                  'rgba(0,122,255,0.2)',
                      color: item.tag === 'New' ? 'var(--sys-green)' :
                             item.tag === 'Hot' ? 'var(--sys-red)' :
                             'var(--sys-blue)',
                    }}
                  >
                    {item.tag}
                  </span>
                  <ChevronRightIcon size={16} style={{ color: 'var(--label4)' } as React.CSSProperties} />
                </div>
                {i < trending.length - 1 && (
                  <div className="mx-[70px] h-px" style={{ background: 'var(--separator)' }} />
                )}
              </div>
            ))}
          </div>
        </div>

        {/* Collections grid */}
        <div>
          <h2 className="sf-headline text-white mb-3">Collections</h2>
          <div className="grid grid-cols-2 gap-3">
            {[
              { name: 'Starter Pack', items: '12 tools', color: 'var(--sys-blue)' },
              { name: 'Pro Bundle', items: '28 tools', color: 'var(--sys-purple)' },
              { name: 'Analytics Suite', items: '9 tools', color: 'var(--sys-green)' },
              { name: 'Creative Kit', items: '15 tools', color: 'var(--sys-orange)' },
            ].map(col => (
              <div
                key={col.name}
                className="glass-regular rounded-3xl p-4 glass-sheen btn-press cursor-pointer relative overflow-hidden"
              >
                <div className="absolute -bottom-4 -right-4 w-20 h-20 rounded-full opacity-20"
                  style={{ background: `radial-gradient(circle, ${col.color}, transparent)` }} />
                <p className="sf-footnote font-semibold text-white mb-1">{col.name}</p>
                <p className="sf-caption1" style={{ color: 'var(--label3)' }}>{col.items}</p>
                <div className="mt-3 h-1 rounded-full" style={{ background: `${col.color}40` }}>
                  <div className="h-full rounded-full" style={{ width: '60%', background: col.color }} />
                </div>
              </div>
            ))}
          </div>
        </div>

      </div>
    </div>
  )
}
