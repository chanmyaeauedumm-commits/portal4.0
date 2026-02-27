import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  optimizeDeps: {
    include: ['firebase/compat/app', 'firebase/compat/auth', 'firebase/compat/database']
  },
  build: {
    commonjsOptions: {
      include: [/firebase/, /node_modules/]
    }
  }
})
