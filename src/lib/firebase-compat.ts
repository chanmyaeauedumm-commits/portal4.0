// Firebase Compatibility Layer - Fixes Vite build issues
import { initializeApp } from 'firebase/app';
import { getAuth, signInWithEmailAndPassword, signOut } from 'firebase/auth';
import { getDatabase, ref, get, child } from 'firebase/database';

// Export everything needed
export {
  initializeApp,
  getAuth,
  signInWithEmailAndPassword,
  signOut,
  getDatabase,
  ref,
  get,
  child
};

// Re-export types
export type { User } from 'firebase/auth';
