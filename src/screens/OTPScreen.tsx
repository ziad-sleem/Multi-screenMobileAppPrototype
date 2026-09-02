import { useState, useRef, useEffect } from 'react'
import { ShieldIcon } from '../lib/icons'

interface OTPScreenProps {
  email: string
  onVerify: () => void
  onBack: () => void
}

export default function OTPScreen({ email, onVerify, onBack }: OTPScreenProps) {
  const [digits, setDigits] = useState(['', '', '', '', '', ''])
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const [resendCount, setResendCount] = useState(30)
  const inputRefs = useRef<(HTMLInputElement | null)[]>([])

  useEffect(() => {
    inputRefs.current[0]?.focus()
  }, [])

  useEffect(() => {
    if (resendCount <= 0) return
    const t = setTimeout(() => setResendCount(c => c - 1), 1000)
    return () => clearTimeout(t)
  }, [resendCount])

  const maskedEmail = email
    ? email.replace(/^(.{2})(.*)(@.*)$/, (_, a, b, c) => a + '*'.repeat(Math.min(b.length, 4)) + c)
    : 'al***@example.com'

  const handleDigit = (i: number, val: string) => {
    const v = val.replace(/\D/g, '').slice(-1)
    const next = [...digits]
    next[i] = v
    setDigits(next)
    setError('')
    if (v && i < 5) {
      inputRefs.current[i + 1]?.focus()
    }
    if (i === 5 && v && next.every(d => d)) {
      handleVerify(next.join(''))
    }
  }

  const handleKeyDown = (i: number, e: React.KeyboardEvent) => {
    if (e.key === 'Backspace' && !digits[i] && i > 0) {
      inputRefs.current[i - 1]?.focus()
    }
  }

  const handlePaste = (e: React.ClipboardEvent) => {
    e.preventDefault()
    const text = e.clipboardData.getData('text').replace(/\D/g, '').slice(0, 6)
    const next = [...digits]
    text.split('').forEach((c, i) => { if (i < 6) next[i] = c })
    setDigits(next)
    if (text.length === 6) {
      inputRefs.current[5]?.focus()
      handleVerify(text)
    }
  }

  const handleVerify = async (code: string) => {
    setLoading(true)
    await new Promise(r => setTimeout(r, 1100))
    setLoading(false)
    // Demo: any 6-digit code works
    if (code.length === 6) {
      onVerify()
    } else {
      setError('Invalid code. Please try again.')
      setDigits(['', '', '', '', '', ''])
      inputRefs.current[0]?.focus()
    }
  }

  const allFilled = digits.every(d => d !== '')

  return (
    <div className="absolute inset-0 flex flex-col anim-up overflow-hidden">
      <div className="h-16" />
      <div className="flex-1 flex flex-col px-5 pt-4 pb-10 gap-8">
        {/* Header */}
        <div>
          <div className="w-14 h-14 rounded-2xl mb-5 flex items-center justify-center"
            style={{
              background: 'linear-gradient(135deg, rgba(0,122,255,0.3), rgba(88,86,214,0.3))',
              boxShadow: '0 8px 32px rgba(0,122,255,0.3)',
              border: '1px solid rgba(0,122,255,0.3)',
            }}>
            <ShieldIcon size={28} className="text-white" />
          </div>
          <h1 className="sf-large-title text-white mb-2">Enter Verification Code</h1>
          <p className="sf-callout" style={{ color: 'var(--label2)' }}>
            We sent a 6-digit code to
          </p>
          <p className="sf-callout font-semibold text-white mt-0.5">{maskedEmail}</p>
        </div>

        {/* OTP digit inputs */}
        <div>
          <div className="flex gap-3 justify-between" onPaste={handlePaste}>
            {digits.map((d, i) => (
              <input
                key={i}
                ref={el => { inputRefs.current[i] = el }}
                type="text"
                inputMode="numeric"
                pattern="[0-9]*"
                maxLength={1}
                value={d}
                onChange={e => handleDigit(i, e.target.value)}
                onKeyDown={e => handleKeyDown(i, e)}
                className="otp-input glass-regular glass-input rounded-2xl bg-transparent flex-1"
                style={{
                  caretColor: 'var(--sys-blue)',
                  borderColor: error ? 'var(--sys-red)' : d ? 'rgba(0,122,255,0.6)' : undefined,
                  boxShadow: d ? '0 0 0 3px rgba(0,122,255,0.15), 0 8px 32px rgba(0,0,0,0.28), inset 0 1px 0 rgba(255,255,255,0.20)' : undefined,
                }}
              />
            ))}
          </div>
          {error && (
            <p className="sf-caption1 text-center mt-3" style={{ color: 'var(--sys-red)' }}>
              ⚠ {error}
            </p>
          )}
        </div>

        {/* Verify button */}
        <button
          onClick={() => allFilled && handleVerify(digits.join(''))}
          disabled={!allFilled || loading}
          className="relative w-full h-14 rounded-2xl btn-press overflow-hidden glass-sheen flex items-center justify-center"
          style={{
            background: allFilled && !loading
              ? 'linear-gradient(135deg, rgba(0,122,255,0.9), rgba(88,86,214,0.9))'
              : 'rgba(255,255,255,0.08)',
            boxShadow: allFilled ? '0 8px 32px rgba(0,122,255,0.4), inset 0 1px 0 rgba(255,255,255,0.28)' : 'none',
            border: allFilled ? '1px solid rgba(0,122,255,0.45)' : '1px solid rgba(255,255,255,0.12)',
            transition: 'all 0.3s ease',
          }}
        >
          {loading ? (
            <div className="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin" />
          ) : (
            <span className="sf-headline" style={{ color: allFilled ? 'white' : 'rgba(255,255,255,0.35)' }}>
              Verify & Proceed
            </span>
          )}
        </button>

        {/* Resend */}
        <div className="text-center">
          {resendCount > 0 ? (
            <p className="sf-callout" style={{ color: 'var(--label3)' }}>
              Resend code in{' '}
              <span className="font-semibold tabular-nums" style={{ color: 'var(--label2)' }}>
                0:{String(resendCount).padStart(2, '0')}
              </span>
            </p>
          ) : (
            <button
              onClick={() => setResendCount(30)}
              className="sf-callout font-semibold btn-press"
              style={{ color: 'var(--sys-blue)' }}
            >
              Resend Code
            </button>
          )}
        </div>

        {/* Back link */}
        <div className="text-center">
          <button onClick={onBack} className="sf-callout btn-press" style={{ color: 'var(--label3)' }}>
            ← Back to Sign In
          </button>
        </div>

        {/* Security note */}
        <div className="glass-ultra-thin rounded-2xl p-4 flex gap-3 items-start">
          <ShieldIcon size={16} className="mt-0.5 flex-shrink-0" style={{ color: 'var(--sys-green)' }} />
          <p className="sf-caption1" style={{ color: 'var(--label3)' }}>
            This code expires in 10 minutes. Never share your verification code with anyone.
          </p>
        </div>
      </div>
    </div>
  )
}
