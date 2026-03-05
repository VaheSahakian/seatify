import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { useTranslation } from 'react-i18next'
import { Mail, ArrowLeft } from 'lucide-react'
import { motion } from 'framer-motion'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { useAuthStore } from '@/store/authStore'
import { toast } from 'sonner'

export default function Auth() {
  const navigate = useNavigate()
  const { t } = useTranslation()
  const { login, register } = useAuthStore()
  const [isLogin, setIsLogin] = useState(true)
  const [name, setName] = useState('')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [loading, setLoading] = useState(false)

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    if (!email.trim() || !password.trim()) return
    if (!isLogin && !name.trim()) return

    setLoading(true)
    try {
      if (isLogin) {
        await login(email, password)
        toast.success('Welcome back!')
      } else {
        await register(name, email, password)
        toast.success('Account created!')
      }
      navigate('/')
    } catch (err: any) {
      toast.error(err.message || 'Authentication failed')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="min-h-[80vh] flex items-center justify-center px-4">
      <motion.div
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        className="w-full max-w-md"
      >
        <button
          onClick={() => navigate(-1)}
          className="mb-6 w-10 h-10 rounded-full border border-border flex items-center justify-center hover:bg-surface transition-colors cursor-pointer"
        >
          <ArrowLeft size={20} />
        </button>

        <div className="mb-8">
          <div className="w-12 h-12 bg-primary rounded-xl flex items-center justify-center mb-4">
            <span className="text-white font-bold text-xl">S</span>
          </div>
          <h1 className="text-2xl font-bold mb-2">{t('auth.welcome')}</h1>
          <p className="text-text-secondary">{t('auth.subtitle')}</p>
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div className="flex gap-2 mb-4">
            <div className="flex-1 flex items-center justify-center gap-2 py-3 rounded-[12px] text-sm font-medium border border-primary bg-primary/5 text-primary">
              <Mail size={16} />
              {t('auth.continue_email')}
            </div>
          </div>

          {!isLogin && (
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
          />

          <Input
            type="password"
            placeholder={t('auth.password') || 'Password'}
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />

          <Button type="submit" size="lg" className="w-full" disabled={loading}>
            {loading ? '...' : isLogin ? t('auth.login') : t('auth.register')}
          </Button>
        </form>

        <p className="text-sm text-text-secondary text-center mt-6">
          {isLogin ? t('auth.no_account') : t('auth.have_account')}{' '}
          <button
            onClick={() => setIsLogin(!isLogin)}
            className="text-primary font-medium hover:underline cursor-pointer"
          >
            {isLogin ? t('auth.register') : t('auth.login')}
          </button>
        </p>
      </motion.div>
    </div>
  )
}
