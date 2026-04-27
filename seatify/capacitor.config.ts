import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.seatify.app',
  appName: 'Seatify',
  webDir: 'dist',
  server: {
    // Load from Vite dev server so hot reload works + images resolve correctly
    url: 'http://192.168.10.45:5173',
    cleartext: true,
  },
  ios: {
    contentInset: 'automatic',
  },
};

export default config;
