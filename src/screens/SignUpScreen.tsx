import { useState } from 'react'
import { PersonIcon, MailIcon, LockIcon, EyeIcon, EyeOffIcon } from '../lib/icons'

interface SignUpScreenProps {
  onSignUp: () => void
  onSignIn: () => void
}

function StrengthBar({ score }: { score: number }) {
  const levels = [
    { min: 0, label: '', color: 'rgba(255,255,255,0.1)' },
    { min: 1, label: 'Weak',    color: 'var(--sys-red)' },
    { min: 2, label: 'Fair',    color: 'var(--sys-orange)' },
    { min: 3, label: 'Strong',  color: 'var(--sys-yellow)' },
    { min: 4, label: 'Secure',  color: 'var(--sys-green)' },
  ]
  const current = levels.filter(l => score >= l.min).pop()!

  return (
    <div className="flex flex-col gap-1.5">
      <div className="flex gap-1.5">
        {[1, 2, 3, 4].map(i => (
          <div
            key={i}
            className="strength-bar flex-1"
            style={{
              background: score >= i ? current.color : 'rgba(255,255,255,0.1)',
              opacity: score >= i ? 1 : 0.5,
            }}
          />
        ))}
      </div>
      {score > 0 && (
        <span className="sf-caption1 font-medium" style={{ color: current.color }}>
          {current.label} password
        </span>
      )}
    </div>
  )
}

function getStrengthScore(pw: string): number {
  let score = 0
  if (pw.length >= 8) score++
  if (/[A-Z]/.test(pw)) score++
  if (/[0-9]/.test(pw)) score++
  if (/[^A-Za-z0-9]/.test(pw)) score++
  return score
}

export default function SignUpScreen({ onSignUp, onSignIn }: SignUpScreenProps) {
  const [name, setName] = useState('')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [confirm, setConfirm] = useState('')
  const [showPw, setShowPw] = useState(false)
  const [showConfirm, setShowConfirm] = useState(false)
  const [agreed, setAgreed] = useState(false)
  const [loading, setLoading] = useState(false)

  const strengthScore = getStrengthScore(password)
  const canSubmit = name && email && password.length >= 8 && password === confirm && agreed

  const handleCreate = async () => {
    if (!canSubmit) return
    setLoading(true)
    await new Promise(r => setTimeout(r, 1100))
    setLoading(false)
    onSignUp()
  }

  return (
    <div className="absolute inset-0 flex flex-col anim-in overflow-y-auto no-scroll">
      <div className="h-16" />
      <div className="flex-1 flex flex-col px-5 pt-4 pb-10 gap-6">
        {/* Header */}
        <div>
          <div className="flex items-center gap-3 mb-4">
            <div className="w-12 h-12 rounded-2xl flex items-center justify-center"
              style={{ background: 'linear-gradient(135deg, var(--sys-purple), var(--sys-indigo))', boxShadow: '0 8px 24px rgba(175,82,222,0.4)' }}>
              <PersonIcon size={22} className="text-white" />
            </div>
            <div>
              <h1 className="sf-title2 text-white">Create Account</h1>
              <div className="flex items-center gap-1.5 mt-0.5">
                <span className="sf-footnote" style={{ color: 'var(--label3)' }}>Step 1 of 2</span>
                <div className="flex gap-1">
                  <div className="w-6 h-1 rounded-full" style={{ background: 'var(--sys-blue)' }} />
                  <div className="w-6 h-1 rounded-full" style={{ background: 'rgba(255,255,255,0.2)' }} />
                </div>
              </div>
            </div>
          </div>
          <p className="sf-callout" style={{ color: 'var(--label2)' }}>
            Join Nexus and start managing your work intelligently.
          </p>
        </div>

        {/* Form fields */}
        <div className="flex flex-col gap-3.5">
          {/* Full Name */}
          <div className="flex flex-col gap-1.5">
            <label className="sf-footnote font-medium text-white/60 ml-1">Full Name</label>
            <div className="relative">
              <PersonIcon size={18} className="absolute left-4 top-1/2 -translate-y-1/2 text-white/35 pointer-events-none" />
              <input
                type="text"
                value={name}
                onChange={e => setName(e.target.value)}
                placeholder="Alex Johnson"
                className="glass-input glass-regular w-full h-14 pl-11 pr-4 rounded-2xl sf-body text-white placeholder-white/25 bg-transparent"
                style={{ outline: 'none' }}
              />
            </div>
          </div>

          {/* Email */}
          <div className="flex flex-col gap-1.5">
            <label className="sf-footnote font-medium text-white/60 ml-1">Email Address</label>
            <div className="relative">
              <MailIcon size={18} className="absolute left-4 top-1/2 -translate-y-1/2 text-white/35 pointer-events-none" />
              <input
                type="email"
                value={email}
                onChange={e => setEmail(e.target.value)}
                placeholder="alex@example.com"
                className="glass-input glass-regular w-full h-14 pl-11 pr-4 rounded-2xl sf-body text-white placeholder-white/25 bg-transparent"
                style={{ outline: 'none' }}
                autoCapitalize="none"
              />
            </div>
          </div>

          {/* Password */}
          <div className="flex flex-col gap-1.5">
            <label className="sf-footnote font-medium text-white/60 ml-1">Password</label>
            <div className="relative">
              <LockIcon size={18} className="absolute left-4 top-1/2 -translate-y-1/2 text-white/35 pointer-events-none" />
              <input
                type={showPw ? 'text' : 'password'}
                value={password}
                onChange={e => setPassword(e.target.value)}
                placeholder="Minimum 8 characters"
                className="glass-input glass-regular w-full h-14 pl-11 pr-12 rounded-2xl sf-body text-white placeholder-white/25 bg-transparent"
                style={{ outline: 'none' }}
              />
              <button
                onClick={() => setShowPw(!showPw)}
                className="absolute right-4 top-1/2 -translate-y-1/2 text-white/40 btn-press"
                tabIndex={-1}
              >
                {showPw ? <EyeOffIcon size={20} /> : <EyeIcon size={20} />}
              </button>
            </div>
            {password && <StrengthBar score={strengthScore} />}
          </div>

          {/* Confirm Password */}
          <div className="flex flex-col gap-1.5">
            <label className="sf-footnote font-medium text-white/60 ml-1">Confirm Password</label>
            <div className="relative">
              <LockIcon size={18} className="absolute left-4 top-1/2 -translate-y-1/2 text-white/35 pointer-events-none" />
              <input
                type={showConfirm ? 'text' : 'password'}
                value={confirm}
                onChange={e => setConfirm(e.target.value)}
                placeholder="Re-enter password"
                className="glass-input glass-regular w-full h-14 pl-11 pr-12 rounded-2xl sf-body text-white placeholder-white/25 bg-transparent"
                style={{
                  outline: 'none',
                  borderColor: confirm && confirm !== password ? 'var(--sys-red)' : undefined,
                }}
              />
              <button
                onClick={() => setShowConfirm(!showConfirm)}
                className="absolute right-4 top-1/2 -translate-y-1/2 text-white/40 btn-press"
                tabIndex={-1}
              >
                {showConfirm ? <EyeOffIcon size={20} /> : <EyeIcon size={20} />}
              </button>
            </div>
            {confirm && password !== confirm && (
              <span className="sf-caption1 ml-1" style={{ color: 'var(--sys-red)' }}>⚠ Passwords do not match</span>
            )}
          </div>
        </div>

        {/* Terms checkbox */}
        <button
          onClick={() => setAgreed(!agreed)}
          className="flex items-start gap-3 btn-press"
        >
          <div
            className="w-5 h-5 rounded-md flex-shrink-0 mt-0.5 flex items-center justify-center transition-all duration-200"
            style={{
              background: agreed ? 'var(--sys-blue)' : 'rgba(255,255,255,0.08)',
              border: agreed ? '1px solid var(--sys-blue)' : '1px solid rgba(255,255,255,0.2)',
              boxShadow: agreed ? '0 2px 8px rgba(0,122,255,0.4)' : 'none',
            }}
          >
            {agreed && (
              <svg width={12} height={12} viewBox="0 0 24 24" fill="none" stroke="white" strokeWidth={3} strokeLinecap="round" strokeLinejoin="round">
                <path d="M20 6L9 17l-5-5"/>
              </svg>
            )}
          </div>
          <span className="sf-footnote text-left" style={{ color: 'var(--label2)' }}>
            I agree to the{' '}
            <span style={{ color: 'var(--sys-blue)' }}>Terms of Service</span>
            {' '}and{' '}
            <span style={{ color: 'var(--sys-blue)' }}>Privacy Policy</span>
          </span>
        </button>

        {/* Create Account button */}
        <button
          onClick={handleCreate}
          disabled={!canSubmit || loading}
          className="relative w-full h-14 rounded-2xl btn-press overflow-hidden glass-sheen flex items-center justify-center"
          style={{
            background: canSubmit && !loading
              ? 'linear-gradient(135deg, rgba(175,82,222,0.9), rgba(88,86,214,0.9))'
              : 'rgba(255,255,255,0.08)',
            boxShadow: canSubmit ? '0 8px 32px rgba(175,82,222,0.4), inset 0 1px 0 rgba(255,255,255,0.28)' : 'none',
            border: canSubmit ? '1px solid rgba(175,82,222,0.5)' : '1px solid rgba(255,255,255,0.12)',
            transition: 'all 0.3s ease',
          }}
        >
          {loading ? (
            <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
          ) : (
            <span className="sf-headline" style={{ color: canSubmit ? 'white' : 'rgba(255,255,255,0.35)' }}>Create Account</span>
          )}
        </button>

        {/* Sign in link */}
        <p className="text-center sf-callout" style={{ color: 'var(--label2)' }}>
          Already have an account?{' '}
          <button onClick={onSignIn} className="font-semibold btn-press" style={{ color: 'var(--sys-blue)' }}>
            Sign In
          </button>
        </p>
      </div>
    </div>
  )
}
