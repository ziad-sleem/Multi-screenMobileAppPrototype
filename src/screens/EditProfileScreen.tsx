import { useState } from 'react'
import { Avatar } from '../components/Navigation'
import { CameraIcon, AtSignIcon, MailIcon, PhoneIcon, CheckCircleIcon } from '../lib/icons'

interface EditProfileScreenProps {
  onSave: () => void
  onBack: () => void
}

export default function EditProfileScreen({ onSave, onBack }: EditProfileScreenProps) {
  const [firstName, setFirstName] = useState('Alex')
  const [lastName, setLastName] = useState('Johnson')
  const [username, setUsername] = useState('alexjohnson')
  const [bio, setBio] = useState('Senior Product Designer crafting digital experiences that matter. Building the future of work at Nexus.')
  const [phone, setPhone] = useState('555-012-3456')
  const [loading, setLoading] = useState(false)
  const [saved, setSaved] = useState(false)

  const bioLength = bio.length

  const handleSave = async () => {
    setLoading(true)
    await new Promise(r => setTimeout(r, 1200))
    setLoading(false)
    setSaved(true)
    await new Promise(r => setTimeout(r, 600))
    onSave()
  }

  return (
    <div className="absolute inset-0 flex flex-col anim-back">
      {/* Custom top bar */}
      <div className="px-4 pt-[54px] pb-2 flex-shrink-0">
        <div className="glass-thin relative flex items-center justify-between h-14 px-4 glass-sheen" style={{ borderRadius: 20 }}>
          <button onClick={onBack} className="sf-callout font-medium btn-press" style={{ color: 'var(--sys-blue)' }}>
            <span className="flex items-center gap-1">
              <svg width={16} height={16} viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth={2.5} strokeLinecap="round" strokeLinejoin="round">
                <path d="M15 18l-6-6 6-6"/>
              </svg>
              Back
            </span>
          </button>
          <span className="absolute left-1/2 -translate-x-1/2 sf-headline text-white font-semibold">Edit Profile</span>
          <button
            onClick={handleSave}
            disabled={loading}
            className="sf-callout font-semibold btn-press"
            style={{ color: loading ? 'rgba(0,122,255,0.5)' : 'var(--sys-blue)' }}
          >
            Save
          </button>
        </div>
      </div>

      {/* Scrollable content */}
      <div className="flex-1 overflow-y-auto no-scroll">
        <div className="px-4 flex flex-col gap-5 pb-36 pt-3">

          {/* Avatar picker */}
          <div className="flex flex-col items-center gap-3 py-4">
            <div className="relative">
              <Avatar name={`${firstName} ${lastName}`} size={88} />
              <button
                className="absolute -bottom-1 -right-1 w-8 h-8 rounded-full flex items-center justify-center glass-sheen"
                style={{
                  background: 'var(--sys-blue)',
                  boxShadow: '0 4px 16px rgba(0,122,255,0.5)',
                  border: '2px solid rgba(0,0,0,0.4)',
                }}
              >
                <CameraIcon size={14} className="text-white" />
              </button>
            </div>
            <button className="sf-callout font-semibold btn-press" style={{ color: 'var(--sys-blue)' }}>
              Change Photo
            </button>
          </div>

          {/* Name fields */}
          <div className="glass-regular rounded-3xl overflow-hidden glass-sheen">
            <div className="px-4 py-3.5 flex items-center gap-3">
              <span className="sf-footnote font-medium w-20 flex-shrink-0" style={{ color: 'var(--label2)' }}>First Name</span>
              <input
                type="text"
                value={firstName}
                onChange={e => setFirstName(e.target.value)}
                className="flex-1 bg-transparent sf-callout text-white outline-none"
                placeholder="First name"
                style={{ caretColor: 'var(--sys-blue)' }}
              />
            </div>
            <div className="mx-4 h-px" style={{ background: 'var(--separator)' }} />
            <div className="px-4 py-3.5 flex items-center gap-3">
              <span className="sf-footnote font-medium w-20 flex-shrink-0" style={{ color: 'var(--label2)' }}>Last Name</span>
              <input
                type="text"
                value={lastName}
                onChange={e => setLastName(e.target.value)}
                className="flex-1 bg-transparent sf-callout text-white outline-none"
                placeholder="Last name"
                style={{ caretColor: 'var(--sys-blue)' }}
              />
            </div>
          </div>

          {/* Username */}
          <div className="glass-regular rounded-3xl overflow-hidden glass-sheen">
            <div className="px-4 py-3.5 flex items-center gap-3">
              <div className="flex items-center gap-1.5 w-20 flex-shrink-0">
                <AtSignIcon size={15} style={{ color: 'var(--label2)' } as React.CSSProperties} />
                <span className="sf-footnote font-medium" style={{ color: 'var(--label2)' }}>Username</span>
              </div>
              <div className="flex items-center flex-1 gap-1">
                <span className="sf-callout" style={{ color: 'var(--label3)' }}>@</span>
                <input
                  type="text"
                  value={username}
                  onChange={e => setUsername(e.target.value.toLowerCase().replace(/[^a-z0-9_]/g, ''))}
                  className="flex-1 bg-transparent sf-callout text-white outline-none"
                  placeholder="username"
                  autoCapitalize="none"
                  style={{ caretColor: 'var(--sys-blue)' }}
                />
              </div>
            </div>
          </div>

          {/* Bio */}
          <div className="glass-regular rounded-3xl p-4 glass-sheen">
            <div className="flex items-center justify-between mb-2">
              <span className="sf-footnote font-medium" style={{ color: 'var(--label2)' }}>Bio</span>
              <span
                className="sf-caption2 tabular-nums"
                style={{ color: bioLength > 140 ? 'var(--sys-orange)' : bioLength >= 150 ? 'var(--sys-red)' : 'var(--label3)' }}
              >
                {bioLength}/150
              </span>
            </div>
            <textarea
              value={bio}
              onChange={e => e.target.value.length <= 150 && setBio(e.target.value)}
              rows={4}
              className="w-full bg-transparent sf-callout text-white outline-none resize-none"
              placeholder="Tell people about yourself…"
              style={{ caretColor: 'var(--sys-blue)', lineHeight: '1.5' }}
            />
            {/* Bio char progress */}
            <div className="mt-2 h-0.5 rounded-full overflow-hidden" style={{ background: 'var(--separator)' }}>
              <div
                className="h-full rounded-full transition-all duration-200"
                style={{
                  width: `${(bioLength / 150) * 100}%`,
                  background: bioLength > 140 ? 'var(--sys-orange)' : 'var(--sys-blue)',
                }}
              />
            </div>
          </div>

          {/* Contact info */}
          <div className="glass-regular rounded-3xl overflow-hidden glass-sheen">
            {/* Email — verified, not editable */}
            <div className="px-4 py-3.5 flex items-center gap-3">
              <MailIcon size={17} style={{ color: 'var(--label3)' } as React.CSSProperties} className="flex-shrink-0" />
              <div className="flex-1 min-w-0">
                <p className="sf-caption2 mb-0.5" style={{ color: 'var(--label3)' }}>Email</p>
                <p className="sf-callout text-white/70">alex@example.com</p>
              </div>
              <div className="flex items-center gap-1.5 rounded-full px-2 py-0.5"
                style={{ background: 'rgba(52,199,89,0.18)', border: '1px solid rgba(52,199,89,0.3)' }}>
                <CheckCircleIcon size={12} style={{ color: 'var(--sys-green)' } as React.CSSProperties} />
                <span className="sf-caption2 font-semibold" style={{ color: 'var(--sys-green)' }}>Verified</span>
              </div>
            </div>

            <div className="mx-4 h-px" style={{ background: 'var(--separator)' }} />

            {/* Phone */}
            <div className="px-4 py-3.5 flex items-center gap-3">
              <PhoneIcon size={17} style={{ color: 'var(--label3)' } as React.CSSProperties} className="flex-shrink-0" />
              <div className="flex items-center flex-1 gap-2">
                <button className="sf-callout font-medium flex-shrink-0 glass-ultra-thin rounded-lg px-2 py-0.5"
                  style={{ color: 'var(--label2)', border: '1px solid var(--separator)' }}>
                  +1
                </button>
                <input
                  type="tel"
                  value={phone}
                  onChange={e => setPhone(e.target.value)}
                  className="flex-1 bg-transparent sf-callout text-white outline-none"
                  placeholder="Phone number"
                  style={{ caretColor: 'var(--sys-blue)' }}
                />
              </div>
            </div>
          </div>

        </div>
      </div>

      {/* Sticky Save Changes */}
      <div
        className="absolute bottom-0 left-0 right-0 px-4 pb-10 pt-4"
        style={{
          background: 'linear-gradient(to top, rgba(5,5,16,0.95) 60%, transparent)',
        }}
      >
        <button
          onClick={handleSave}
          disabled={loading}
          className="relative w-full h-14 rounded-2xl btn-press overflow-hidden glass-sheen flex items-center justify-center gap-2"
          style={{
            background: saved
              ? 'linear-gradient(135deg, rgba(52,199,89,0.9), rgba(52,199,89,0.7))'
              : 'linear-gradient(135deg, rgba(88,86,214,0.9), rgba(0,122,255,0.9))',
            boxShadow: '0 8px 32px rgba(0,122,255,0.4), inset 0 1px 0 rgba(255,255,255,0.28)',
            border: '1px solid rgba(0,122,255,0.45)',
            transition: 'background 0.3s ease',
          }}
        >
          {loading ? (
            <>
              <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
              <span className="sf-headline text-white">Saving…</span>
            </>
          ) : saved ? (
            <>
              <CheckCircleIcon size={20} className="text-white" />
              <span className="sf-headline text-white">Saved!</span>
            </>
          ) : (
            <span className="sf-headline text-white">Save Changes</span>
          )}
        </button>
      </div>
    </div>
  )
}
