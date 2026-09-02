import { useState } from 'react'
import { MailIcon, LockIcon, EyeIcon, EyeOffIcon, GoogleIcon, AppleIcon, GithubIcon } from '../lib/icons'

interface SignInScreenProps {
  onSignIn: () => void
  onSignUp: () => void
  onForgotPassword: () => void
}

export default function SignInScreen({ onSignIn, onSignUp, onForgotPassword }: SignInScreenProps) {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [showPw, setShowPw] = useState(false)
  const [emailError, setEmailError] = useState('')
  const [loading, setLoading] = useState(false)

  const validateEmail = (v: string) => {
    if (!v) return 'Email is required'
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v)) return 'Enter a valid email address'
    return ''
  }

  const handleSignIn = async () => {
    const err = validateEmail(email)
    if (err) { setEmailError(err); return }
    setLoading(true)
    await new Promise(r => setTimeout(r, 1200))
    setLoading(false)
    onSignIn()
  }

  return (
    <div className="absolute inset-0 flex flex-col anim-in overflow-y-auto no-scroll">
      {/* Top safe area */}
      <div className="h-16" />

      <div className="flex-1 flex flex-col px-5 pt-4 pb-10 gap-8">
        {/* Header */}
        <div>
          <div className="w-12 h-12 rounded-2xl mb-4 flex items-center justify-center"
            style={{ background: 'linear-gradient(135deg, var(--sys-indigo), var(--sys-blue))', boxShadow: '0 8px 24px rgba(0,122,255,0.4)' }}>
            <LockIcon size={22} className="text-white" />
          </div>
          <h1 className="sf-large-title text-white mb-1">Welcome Back</h1>
          <p className="sf-callout" style={{ color: 'var(--label2)' }}>Sign in to continue to Nexus</p>
        </div>

        {/* Form */}
        <div className="flex flex-col gap-4">
          {/* Email */}
          <div className="flex flex-col gap-1.5">
            <label className="sf-footnote font-medium text-white/60 ml-1">Email or Username</label>
            <div className="relative">
              <MailIcon size={18} className="absolute left-4 top-1/2 -translate-y-1/2 text-white/35 pointer-events-none" />
              <input
                type="email"
                value={email}
                onChange={e => { setEmail(e.target.value); setEmailError('') }}
                onBlur={() => setEmailError(validateEmail(email))}
                placeholder="alex@example.com"
                className="glass-input glass-regular w-full h-14 pl-11 pr-4 rounded-2xl sf-body text-white placeholder-white/25 bg-transparent"
                style={{ outline: 'none', border: emailError ? '1px solid var(--sys-red)' : undefined }}
                autoCapitalize="none"
                autoCorrect="off"
              />
            </div>
            {emailError && (
              <span className="sf-caption1 ml-1" style={{ color: 'var(--sys-red)' }}>⚠ {emailError}</span>
            )}
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
                placeholder="Enter your password"
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
          </div>

          {/* Forgot password */}
          <div className="text-right">
            <button onClick={onForgotPassword} className="sf-callout font-medium btn-press" style={{ color: 'var(--sys-blue)' }}>
              Forgot Password?
            </button>
          </div>
        </div>

        {/* Sign In button */}
        <button
          onClick={handleSignIn}
          disabled={loading}
          className="relative w-full h-14 rounded-2xl btn-press overflow-hidden glass-sheen flex items-center justify-center"
          style={{
            background: loading
              ? 'rgba(0,122,255,0.5)'
              : 'linear-gradient(135deg, rgba(88,86,214,0.9), rgba(0,122,255,0.9))',
            boxShadow: '0 8px 32px rgba(0,122,255,0.4), inset 0 1px 0 rgba(255,255,255,0.28)',
            border: '1px solid rgba(0,122,255,0.45)',
          }}
        >
          {loading ? (
            <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
          ) : (
            <span className="sf-headline text-white">Sign In</span>
          )}
        </button>

        {/* Divider */}
        <div className="flex items-center gap-4">
          <div className="flex-1 h-px" style={{ background: 'var(--separator)' }} />
          <span className="sf-caption1 font-medium" style={{ color: 'var(--label3)' }}>or continue with</span>
          <div className="flex-1 h-px" style={{ background: 'var(--separator)' }} />
        </div>

        {/* Social buttons */}
        <div className="flex gap-3">
          {[
            { Icon: GoogleIcon, label: 'Google' },
            { Icon: AppleIcon, label: 'Apple' },
            { Icon: GithubIcon, label: 'GitHub' },
          ].map(({ Icon, label }) => (
            <button
              key={label}
              onClick={onSignIn}
              className="flex-1 h-12 rounded-2xl glass-regular glass-sheen flex items-center justify-center gap-2 btn-press"
            >
              <Icon size={20} className="text-white" />
            </button>
          ))}
        </div>

        {/* Sign up link */}
        <p className="text-center sf-callout" style={{ color: 'var(--label2)' }}>
          Don&apos;t have an account?{' '}
          <button onClick={onSignUp} className="font-semibold btn-press" style={{ color: 'var(--sys-blue)' }}>
            Sign Up
          </button>
        </p>
      </div>
    </div>
  )
}
