import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  optimizeDeps: {
    include: [
      'firebase/app', 
      'firebase/auth', 
      'firebase/database',
      'firebase/storage'
    ],
    exclude: []
  },
  build: {
    commonjsOptions: {
      include: [/firebase/, /node_modules/],
      transformMixedEsModules: true
    },
    rollupOptions: {
      external: [],
      output: {
        manualChunks: {
          firebase: ['firebase/app', 'firebase/auth', 'firebase/database']
        }
      }
    }
  },
  resolve: {
    alias: {
      // Add any aliases here if needed
    }
  }
})
