import { SiVisa, SiApplepay, SiGooglepay } from 'react-icons/si'

export function VisaLogo() {
  return (
    <SiVisa
      size={28}
      className="text-[#1A1F71] dark:text-white shrink-0"
      aria-label="Visa"
    />
  )
}

export function MastercardLogo() {
  return (
    <svg
      viewBox="0 0 32 20"
      className="h-5 w-8 shrink-0"
      xmlns="http://www.w3.org/2000/svg"
      aria-label="Mastercard"
    >
      <circle cx="13" cy="10" r="7" fill="#EB001B" />
      <circle cx="19" cy="10" r="7" fill="#F79E1B" />
      <path
        d="M16 5.5a7 7 0 0 1 0 9 7 7 0 0 1 0-9z"
        fill="#FF5F00"
      />
    </svg>
  )
}

export function ApplePayLogo() {
  return (
    <SiApplepay
      size={36}
      className="text-black dark:text-white shrink-0"
      aria-label="Apple Pay"
    />
  )
}

export function GooglePayLogo() {
  return (
    <SiGooglepay
      size={36}
      className="text-[#4285F4] shrink-0"
      aria-label="Google Pay"
    />
  )
}

export function IdramLogo() {
  return (
    <div
      className="h-5 px-1.5 rounded bg-[#6B1FA0] text-white text-[11px] font-bold flex items-center justify-center shrink-0"
      aria-label="Idram"
    >
      iDram
    </div>
  )
}

export function TelcellLogo() {
  return (
    <div
      className="h-5 px-1.5 rounded bg-[#F39200] text-white text-[11px] font-bold flex items-center justify-center shrink-0"
      aria-label="Telcell"
    >
      Telcell
    </div>
  )
}
