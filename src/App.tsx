import { useState } from 'react'
import { TopBar, BottomNav, type MainTab } from './components/Navigation'
import WelcomeScreen from './screens/WelcomeScreen'
import SignInScreen from './screens/SignInScreen'
import SignUpScreen from './screens/SignUpScreen'
import OTPScreen from './screens/OTPScreen'
import HomeScreen from './screens/HomeScreen'
import DiscoverScreen from './screens/DiscoverScreen'
import ActivityScreen from './screens/ActivityScreen'
import ProfileScreen from './screens/ProfileScreen'
import EditProfileScreen from './screens/EditProfileScreen'

type AuthStep = 'welcome' | 'signin' | 'signup' | 'otp'

export default function App() {
  const [authed, setAuthed] = useState(false)
  const [authStep, setAuthStep] = useState<AuthStep>('welcome')
  const [activeTab, setActiveTab] = useState<MainTab>('home')
  const [editingProfile, setEditingProfile] = useState(false)
  const [signupEmail] = useState('alex@example.com')

  const handleLogout = () => {
    setAuthed(false)
    setAuthStep('welcome')
    setActiveTab('home')
    setEditingProfile(false)
  }

  // Tab titles for top bar
  const tabTitles: Record<MainTab, string> = {
    home: 'Dashboard',
    discover: 'Discover',
    activity: 'Activity',
    profile: 'Profile',
  }

  return (
    <div className="size-full flex items-center justify-center app-wallpaper overflow-hidden p-4">
      <div className="phone-container app-wallpaper">
        {/* Dynamic Island */}
        <div className="dynamic-island" />

        {/* Status bar time */}
        <div className="absolute top-0 left-0 right-0 z-[60] flex items-center justify-between px-7 pt-[14px]">
          <span className="sf-caption2 font-semibold text-white tabular-nums">
            {new Date().toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit' })}
          </span>
          <div className="flex items-center gap-1">
            {/* Signal */}
            <svg width={17} height={12} viewBox="0 0 17 12" fill="white">
              <rect x="0" y="3" width="3" height="9" rx="1" opacity="1"/>
              <rect x="4.5" y="2" width="3" height="10" rx="1" opacity="1"/>
              <rect x="9" y="1" width="3" height="11" rx="1" opacity="1"/>
              <rect x="13.5" y="0" width="3" height="12" rx="1" opacity="0.35"/>
            </svg>
            {/* WiFi */}
            <svg width={16} height={12} viewBox="0 0 16 12" fill="none" stroke="white" strokeWidth={1.5} strokeLinecap="round">
              <path d="M1 4.5C3.89 1.83 7.76 1.83 10.65 4.5" opacity="0.4"/>
              <path d="M2.8 6.5C4.9 4.6 7.7 4.6 9.8 6.5" opacity="0.65"/>
              <path d="M4.6 8.5C5.8 7.4 7.2 7.4 8.4 8.5"/>
              <circle cx="6.5" cy="10.5" r="1" fill="white" stroke="none"/>
            </svg>
            {/* Battery */}
            <div className="flex items-center gap-0.5">
              <div className="relative w-[25px] h-[12px] rounded-[3px] border border-white/60 flex items-center px-[1.5px]">
                <div className="h-[7px] rounded-[1.5px] bg-white" style={{ width: '80%' }} />
              </div>
              <div className="w-[2px] h-[5px] rounded-r-sm bg-white/50" />
            </div>
          </div>
        </div>

        {/* Auth flow */}
        {!authed && (
          <div className="absolute inset-0">
            {authStep === 'welcome' && (
              <WelcomeScreen
                onGetStarted={() => setAuthStep('signup')}
                onSignIn={() => setAuthStep('signin')}
              />
            )}
            {authStep === 'signin' && (
              <SignInScreen
                onSignIn={() => setAuthStep('otp')}
                onSignUp={() => setAuthStep('signup')}
                onForgotPassword={() => setAuthStep('otp')}
              />
            )}
            {authStep === 'signup' && (
              <SignUpScreen
                onSignUp={() => setAuthStep('otp')}
                onSignIn={() => setAuthStep('signin')}
              />
            )}
            {authStep === 'otp' && (
              <OTPScreen
                email={signupEmail}
                onVerify={() => { setAuthed(true); setActiveTab('home') }}
                onBack={() => setAuthStep('signin')}
              />
            )}
          </div>
        )}

        {/* Main authenticated app */}
        {authed && (
          <div className="absolute inset-0">
            {/* Top navigation bar */}
            {editingProfile ? (
              // Edit profile has its own header — no global top bar
              null
            ) : (
              <TopBar
                tab={activeTab}
                title={tabTitles[activeTab]}
              />
            )}

            {/* Screen content */}
            {!editingProfile && activeTab === 'home'     && <HomeScreen />}
            {!editingProfile && activeTab === 'discover' && <DiscoverScreen />}
            {!editingProfile && activeTab === 'activity' && <ActivityScreen />}
            {!editingProfile && activeTab === 'profile'  && (
              <ProfileScreen
                onEditProfile={() => setEditingProfile(true)}
                onLogout={handleLogout}
              />
            )}
            {editingProfile && (
              <EditProfileScreen
                onSave={() => setEditingProfile(false)}
                onBack={() => setEditingProfile(false)}
              />
            )}

            {/* Bottom navigation — hidden on edit profile */}
            {!editingProfile && (
              <BottomNav activeTab={activeTab} onTabChange={setActiveTab} />
            )}
          </div>
        )}

        {/* Home indicator */}
        <div className="home-indicator" />
      </div>
    </div>
  )
}
