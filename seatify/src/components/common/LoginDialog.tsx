import { useEffect, useState } from 'react'
import { Mail } from 'lucide-react'
import { useTranslation } from 'react-i18next'
import { toast } from 'sonner'
import { Dialog } from '@/components/ui/dialog'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { useAuthStore } from '@/store/authStore'
import { useLoginPrompt } from '@/store/loginPromptStore'

export function LoginDialog() {
  const { t } = useTranslation()
  const { isOpen, onSuccess, close } = useLoginPrompt()
  const login = useAuthStore((s) => s.login)
  const register = useAuthStore((s) => s.register)

  const [isLoginMode, setIsLoginMode] = useState(true)
  const [name, setName] = useState('')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [loading, setLoading] = useState(false)

  useEffect(() => {
    if (!isOpen) {
      setName('')
      setEmail('')
      setPassword('')
      setIsLoginMode(true)
      setLoading(false)
    }
  }, [isOpen])

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    if (!email.trim() || !password.trim()) return
    if (!isLoginMode && !name.trim()) return

    setLoading(true)
    try {
      if (isLoginMode) {
        await login(email, password)
        toast.success('Welcome back!')
      } else {
        await register(name, email, password)
        toast.success('Account created!')
      }
      const cb = onSuccess
      close()
      if (cb) cb()
    } catch (err: unknown) {
      const msg = err instanceof Error ? err.message : 'Authentication failed'
      toast.error(msg)
    } finally {
      setLoading(false)
    }
  }

  return (
    <Dialog open={isOpen} onClose={close}>
      <div className="mb-6">
        <div className="w-12 h-12 bg-primary rounded-xl flex items-center justify-center mb-4">
          <span className="text-white font-bold text-xl">S</span>
        </div>
        <h2 className="text-xl font-bold mb-1">{t('auth.welcome')}</h2>
        <p className="text-sm text-text-secondary">{t('auth.subtitle')}</p>
      </div>

      <form onSubmit={handleSubmit} className="space-y-3">
        <div className="flex items-center justify-center gap-2 py-2.5 rounded-[12px] text-sm font-medium border border-primary bg-primary/5 text-primary">
          <Mail size={16} />
          {t('auth.continue_email')}
        </div>

        {!isLoginMode && (
          <Input
            type="text"
            placeholder={t('auth.name') || 'Full Name'}
            value={name}
            onChange={(e) => setName(e.target.value)}
          />
        )}

        <Input
          type="email"
          placeholder={t('auth.email')}
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          autoFocus
        />

        <Input
          type="password"
          placeholder={t('auth.password') || 'Password'}
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />

        <Button type="submit" size="lg" className="w-full" disabled={loading}>
          {loading ? '...' : isLoginMode ? t('auth.login') : t('auth.register')}
        </Button>
      </form>

      <p className="text-sm text-text-secondary text-center mt-4">
        {isLoginMode ? t('auth.no_account') : t('auth.have_account')}{' '}
        <button
          onClick={() => setIsLoginMode((v) => !v)}
          className="text-primary font-medium hover:underline cursor-pointer"
          type="button"
        >
          {isLoginMode ? t('auth.register') : t('auth.login')}
        </button>
      </p>
    </Dialog>
  )
}
