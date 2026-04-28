import { create } from 'zustand'

interface LoginPromptState {
  isOpen: boolean
  onSuccess?: () => void
  open: (onSuccess?: () => void) => void
  close: () => void
}

export const useLoginPrompt = create<LoginPromptState>((set) => ({
  isOpen: false,
  open: (onSuccess) => set({ isOpen: true, onSuccess }),
  close: () => set({ isOpen: false, onSuccess: undefined }),
}))
