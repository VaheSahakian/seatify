const BASE_URL = import.meta.env.VITE_API_URL || 'http://localhost:8080'

function getAccessToken(): string | null {
  return localStorage.getItem('admin_access_token')
}

function getRefreshToken(): string | null {
  return localStorage.getItem('admin_refresh_token')
}

export function setAdminTokens(accessToken: string, refreshToken: string) {
  localStorage.setItem('admin_access_token', accessToken)
  localStorage.setItem('admin_refresh_token', refreshToken)
}

export function clearAdminTokens() {
  localStorage.removeItem('admin_access_token')
  localStorage.removeItem('admin_refresh_token')
}

async function refreshAccessToken(): Promise<string | null> {
  const refreshToken = getRefreshToken()
  if (!refreshToken) return null

  try {
    const res = await fetch(`${BASE_URL}/api/admin/auth/refresh`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ refreshToken }),
    })
    if (!res.ok) {
      clearAdminTokens()
      return null
    }
    const data = await res.json()
    setAdminTokens(data.accessToken, data.refreshToken)
    return data.accessToken
  } catch {
    clearAdminTokens()
    return null
  }
}

export async function adminFetch<T>(
  path: string,
  options: RequestInit = {},
): Promise<T> {
  const headers: Record<string, string> = {
    'Content-Type': 'application/json',
    ...(options.headers as Record<string, string>),
  }

  const token = getAccessToken()
  if (token) {
    headers['Authorization'] = `Bearer ${token}`
  }

  let res = await fetch(`${BASE_URL}${path}`, { ...options, headers })

  if (res.status === 401 && getRefreshToken()) {
    const newToken = await refreshAccessToken()
    if (newToken) {
      headers['Authorization'] = `Bearer ${newToken}`
      res = await fetch(`${BASE_URL}${path}`, { ...options, headers })
    }
  }

  if (!res.ok) {
    const error = await res.json().catch(() => ({ message: res.statusText }))
    throw new Error(error.message || `API error: ${res.status}`)
  }

  if (res.status === 204) return undefined as T

  return res.json()
}
