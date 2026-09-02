import { Avatar } from '../components/Navigation'
import {
  EditIcon, SettingsIcon, ShieldIcon, LinkIcon, BellIcon, GlobeIcon,
  LockIcon, HelpCircleIcon, FileTextIcon, TrashIcon, LogOutIcon,
  ChevronRightIcon, AwardIcon, ZapIcon, BriefcaseIcon
} from '../lib/icons'

interface ProfileScreenProps {
  onEditProfile: () => void
  onLogout: () => void
}

interface SettingRowProps {
  Icon: React.ComponentType<{ size?: number; className?: string; style?: React.CSSProperties }>
  label: string
  sub?: string
  iconColor?: string
  iconBg?: string
  danger?: boolean
  onPress?: () => void
  rightEl?: React.ReactNode
}

function SettingRow({ Icon, label, sub, iconColor = 'rgba(255,255,255,0.6)', iconBg = 'rgba(255,255,255,0.08)', danger, onPress, rightEl }: SettingRowProps) {
  return (
    <button onClick={onPress} className="flex items-center gap-3.5 px-4 py-3.5 w-full text-left btn-press">
      <div
        className="w-10 h-10 rounded-xl flex items-center justify-center flex-shrink-0"
        style={{ background: iconBg, border: `1px solid ${iconColor}25` }}
      >
        <Icon size={18} style={{ color: iconColor } as React.CSSProperties} />
      </div>
      <div className="flex-1 min-w-0">
        <p className="sf-callout font-medium" style={{ color: danger ? 'var(--sys-red)' : 'white' }}>{label}</p>
        {sub && <p className="sf-caption1" style={{ color: 'var(--label3)' }}>{sub}</p>}
      </div>
      {rightEl ?? <ChevronRightIcon size={16} style={{ color: 'var(--label4)' } as React.CSSProperties} />}
    </button>
  )
}

export default function ProfileScreen({ onEditProfile, onLogout }: ProfileScreenProps) {
  return (
    <div className="absolute inset-0 overflow-y-auto no-scroll" style={{ paddingTop: 130, paddingBottom: 120 }}>
      <div className="px-4 flex flex-col gap-5 pb-4">

        {/* Profile hero */}
        <div className="glass-regular rounded-3xl p-5 glass-sheen relative overflow-hidden">
          <div className="absolute -top-8 -right-8 w-40 h-40 rounded-full opacity-15 pointer-events-none"
            style={{ background: 'radial-gradient(circle, var(--sys-indigo), transparent)' }} />
          <div className="relative flex flex-col items-center text-center gap-3">
            <Avatar name="Alex Johnson" size={80} showStatus />

            <div>
              <h2 className="sf-title2 text-white font-bold">Alex Johnson</h2>
              <p className="sf-callout" style={{ color: 'var(--label2)' }}>@alexjohnson</p>
              <div className="flex items-center justify-center gap-2 mt-1.5">
                <div
                  className="rounded-full px-2.5 py-1"
                  style={{ background: 'rgba(0,122,255,0.2)', border: '1px solid rgba(0,122,255,0.35)' }}
                >
                  <span className="sf-caption2 font-semibold" style={{ color: 'var(--sys-blue)' }}>Senior Product Designer</span>
                </div>
              </div>
            </div>

            {/* Stats row */}
            <div className="flex w-full mt-1">
              {[
                { value: '12', label: 'Projects', Icon: BriefcaseIcon, color: 'var(--sys-blue)' },
                { value: '94', label: 'Activity Score', Icon: ZapIcon, color: 'var(--sys-green)' },
                { value: 'Pro', label: 'Membership', Icon: AwardIcon, color: 'var(--sys-yellow)' },
              ].map((stat, i) => (
                <div key={stat.label} className="flex-1 flex flex-col items-center gap-1 py-2">
                  {i > 0 && <div className="absolute" />}
                  <p className="sf-title3 text-white font-bold">{stat.value}</p>
                  <p className="sf-caption2" style={{ color: 'var(--label3)' }}>{stat.label}</p>
                  <stat.Icon size={12} style={{ color: stat.color } as React.CSSProperties} />
                  {i < 2 && (
                    <div className="absolute" style={{ width: 1, height: 40, background: 'var(--separator)', top: '50%', transform: 'translateY(-50%)', right: 0 }} />
                  )}
                </div>
              ))}
            </div>

            {/* Edit profile button */}
            <button
              onClick={onEditProfile}
              className="flex items-center gap-2 h-11 px-6 rounded-2xl btn-press glass-sheen"
              style={{
                background: 'rgba(0,122,255,0.22)',
                border: '1px solid rgba(0,122,255,0.4)',
                boxShadow: '0 4px 16px rgba(0,122,255,0.25)',
              }}
            >
              <EditIcon size={16} style={{ color: 'var(--sys-blue)' } as React.CSSProperties} />
              <span className="sf-callout font-semibold" style={{ color: 'var(--sys-blue)' }}>Edit Profile</span>
            </button>
          </div>
        </div>

        {/* Account Settings */}
        <div>
          <p className="sf-footnote font-semibold text-white/50 uppercase tracking-wider mb-2 ml-1">Account Settings</p>
          <div className="glass-regular rounded-3xl overflow-hidden glass-sheen">
            <SettingRow
              Icon={SettingsIcon}
              label="Personal Info"
              sub="Name, email, location"
              iconColor="var(--sys-blue)"
              iconBg="rgba(0,122,255,0.18)"
            />
            <div className="mx-[62px] h-px" style={{ background: 'var(--separator)' }} />
            <SettingRow
              Icon={ShieldIcon}
              label="Security & Password"
              sub="Two-factor, biometrics"
              iconColor="var(--sys-green)"
              iconBg="rgba(52,199,89,0.18)"
            />
            <div className="mx-[62px] h-px" style={{ background: 'var(--separator)' }} />
            <SettingRow
              Icon={LinkIcon}
              label="Linked Accounts"
              sub="Google, Apple, GitHub"
              iconColor="var(--sys-purple)"
              iconBg="rgba(175,82,222,0.18)"
            />
          </div>
        </div>

        {/* Preferences */}
        <div>
          <p className="sf-footnote font-semibold text-white/50 uppercase tracking-wider mb-2 ml-1">Preferences</p>
          <div className="glass-regular rounded-3xl overflow-hidden glass-sheen">
            <SettingRow
              Icon={BellIcon}
              label="Push Notifications"
              sub="Alerts, reminders, updates"
              iconColor="var(--sys-orange)"
              iconBg="rgba(255,149,0,0.18)"
              rightEl={
                <div className="w-11 h-6 rounded-full flex items-center px-0.5 transition-all duration-200"
                  style={{ background: 'var(--sys-green)', boxShadow: '0 2px 8px rgba(52,199,89,0.4)' }}>
                  <div className="w-5 h-5 rounded-full bg-white ml-auto shadow" />
                </div>
              }
            />
            <div className="mx-[62px] h-px" style={{ background: 'var(--separator)' }} />
            <SettingRow
              Icon={GlobeIcon}
              label="App Language"
              sub="English (US)"
              iconColor="var(--sys-teal)"
              iconBg="rgba(90,200,250,0.18)"
            />
            <div className="mx-[62px] h-px" style={{ background: 'var(--separator)' }} />
            <SettingRow
              Icon={LockIcon}
              label="Privacy Controls"
              sub="Data sharing, visibility"
              iconColor="var(--sys-indigo)"
              iconBg="rgba(88,86,214,0.18)"
            />
          </div>
        </div>

        {/* System & Support */}
        <div>
          <p className="sf-footnote font-semibold text-white/50 uppercase tracking-wider mb-2 ml-1">System & Support</p>
          <div className="glass-regular rounded-3xl overflow-hidden glass-sheen">
            <SettingRow
              Icon={HelpCircleIcon}
              label="Help Center"
              sub="Guides, FAQs, contact"
              iconColor="var(--sys-blue)"
              iconBg="rgba(0,122,255,0.18)"
            />
            <div className="mx-[62px] h-px" style={{ background: 'var(--separator)' }} />
            <SettingRow
              Icon={FileTextIcon}
              label="Terms of Service"
              sub="Legal & privacy"
              iconColor="var(--sys-gray)"
              iconBg="rgba(142,142,147,0.18)"
            />
            <div className="mx-[62px] h-px" style={{ background: 'var(--separator)' }} />
            <SettingRow
              Icon={TrashIcon}
              label="Clear Cache"
              sub="Frees up 24.6 MB"
              iconColor="var(--sys-orange)"
              iconBg="rgba(255,149,0,0.18)"
            />
          </div>
        </div>

        {/* Log Out */}
        <div className="glass-regular rounded-3xl overflow-hidden glass-sheen">
          <SettingRow
            Icon={LogOutIcon}
            label="Sign Out"
            iconColor="var(--sys-red)"
            iconBg="rgba(255,59,48,0.18)"
            danger
            onPress={onLogout}
            rightEl={<span />}
          />
        </div>

        {/* Version */}
        <p className="text-center sf-caption2 pb-2" style={{ color: 'var(--label4)' }}>
          Nexus v2.3.1 · Build 2026.09.02
        </p>

      </div>
    </div>
  )
}
