import { SparkleIcon } from '../lib/icons'

interface WelcomeScreenProps {
  onGetStarted: () => void
  onSignIn: () => void
}

export default function WelcomeScreen({ onGetStarted, onSignIn }: WelcomeScreenProps) {
  return (
    <div className="absolute inset-0 flex flex-col anim-up overflow-hidden">
      {/* Hero illustration area */}
      <div className="flex-1 relative flex items-center justify-center px-8 pt-16">
        {/* Ambient glow orbs */}
        <div className="absolute inset-0 pointer-events-none">
          <div className="absolute top-12 left-1/2 -translate-x-1/2 w-64 h-64 rounded-full opacity-30"
            style={{ background: 'radial-gradient(circle, var(--sys-indigo), transparent 70%)' }} />
          <div className="absolute top-20 left-1/4 w-40 h-40 rounded-full opacity-20"
            style={{ background: 'radial-gradient(circle, var(--sys-purple), transparent 70%)' }} />
          <div className="absolute top-28 right-1/4 w-36 h-36 rounded-full opacity-25"
            style={{ background: 'radial-gradient(circle, var(--sys-blue), transparent 70%)' }} />
        </div>

        {/* Central illustration: glass orb cluster */}
        <div className="relative w-72 h-72">
          {/* Outer ring */}
          <div className="absolute inset-0 rounded-full glass-ultra-thin glass-sheen"
            style={{ animation: 'none', border: '1px solid rgba(255,255,255,0.12)' }} />

          {/* Middle orb */}
          <div className="absolute inset-6 rounded-full glass-thin glass-sheen" />

          {/* Inner core */}
          <div className="absolute inset-12 rounded-full flex items-center justify-center"
            style={{
              background: 'radial-gradient(circle at 35% 35%, rgba(88,86,214,0.8), rgba(0,122,255,0.6))',
              boxShadow: '0 0 40px rgba(88,86,214,0.5), inset 0 1px 0 rgba(255,255,255,0.4)',
            }}>
            <SparkleIcon size={40} className="text-white" strokeWidth={1.5} />
          </div>

          {/* Floating orbs */}
          {[
            { top: '8%', left: '10%', size: 40, color: 'var(--sys-purple)', delay: '0s' },
            { top: '12%', right: '8%', size: 36, color: 'var(--sys-teal)', delay: '0.5s' },
            { bottom: '10%', left: '8%', size: 32, color: 'var(--sys-green)', delay: '1s' },
            { bottom: '14%', right: '10%', size: 38, color: 'var(--sys-orange)', delay: '0.25s' },
          ].map((orb, i) => (
            <div
              key={i}
              className="absolute rounded-full glass-regular glass-sheen"
              style={{
                width: orb.size,
                height: orb.size,
                top: orb.top,
                left: (orb as { left?: string }).left,
                right: (orb as { right?: string }).right,
                bottom: orb.bottom,
                boxShadow: `0 4px 20px ${orb.color}55`,
                border: `1px solid ${orb.color}30`,
                animationDelay: orb.delay,
              }}
            />
          ))}

          {/* Mini floating badges */}
          <div className="absolute -top-2 left-1/2 -translate-x-1/2 glass-regular rounded-2xl px-3 py-1.5 glass-sheen"
            style={{ boxShadow: '0 4px 20px rgba(0,122,255,0.3)' }}>
            <span className="sf-caption1 text-white/80 font-medium">✦ AI-Powered</span>
          </div>
          <div className="absolute -bottom-2 right-6 glass-regular rounded-2xl px-3 py-1.5 glass-sheen"
            style={{ boxShadow: '0 4px 20px rgba(52,199,89,0.3)' }}>
            <span className="sf-caption1 font-medium" style={{ color: 'var(--sys-green)' }}>● Live</span>
          </div>
        </div>
      </div>

      {/* Bottom content sheet */}
      <div className="px-5 pb-10 pt-2 flex flex-col gap-6">
        {/* Headline */}
        <div className="text-center">
          <h1 className="sf-large-title text-white mb-2">
            Your Life,<br />
            <span style={{ background: 'linear-gradient(90deg, var(--sys-blue), var(--sys-purple))', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent' }}>
              Elevated
            </span>
          </h1>
          <p className="sf-callout text-center mx-auto max-w-xs" style={{ color: 'var(--label2)' }}>
            One intelligent workspace to manage projects, track progress, and connect with what matters.
          </p>
        </div>

        {/* Feature chips */}
        <div className="flex items-center justify-center gap-3">
          {['Dashboard', 'Analytics', 'Teams', 'Secure'].map(f => (
            <div key={f} className="glass-ultra-thin rounded-full px-3 py-1">
              <span className="sf-caption1 text-white/60">{f}</span>
            </div>
          ))}
        </div>

        {/* CTAs */}
        <div className="flex flex-col gap-3">
          <button
            onClick={onGetStarted}
            className="relative w-full h-14 rounded-2xl btn-press overflow-hidden flex items-center justify-center gap-2 glass-sheen"
            style={{
              background: 'linear-gradient(135deg, rgba(88,86,214,0.9) 0%, rgba(0,122,255,0.9) 100%)',
              boxShadow: '0 8px 32px rgba(0,122,255,0.45), inset 0 1px 0 rgba(255,255,255,0.3)',
              border: '1px solid rgba(0,122,255,0.5)',
            }}
          >
            <SparkleIcon size={18} className="text-white" />
            <span className="sf-headline text-white">Get Started</span>
          </button>

          <button
            onClick={onGetStarted}
            className="w-full h-14 rounded-2xl btn-press glass-thin glass-sheen flex items-center justify-center"
          >
            <span className="sf-headline text-white/80">Create Account</span>
          </button>

          <div className="text-center">
            <button onClick={onSignIn} className="sf-callout btn-press" style={{ color: 'var(--sys-blue)' }}>
              Already have an account?{' '}
              <span className="font-semibold">Log In</span>
            </button>
          </div>
        </div>
      </div>
    </div>
  )
}
