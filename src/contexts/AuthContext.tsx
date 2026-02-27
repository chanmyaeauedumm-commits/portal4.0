import React, { createContext, useContext, useEffect, useState } from 'react';
import { User, onAuthStateChanged, signInWithRedirect, getRedirectResult, signOut } from 'firebase/auth';
import { auth, provider } from '../lib/firebase';

interface AuthContextType {
  user: User | null;
  loading: boolean;
  logout: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType>({ user: null, loading: true, logout: async () => {} });

export const useAuth = () => useContext(AuthContext);

export const AuthProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let isRedirecting = false;

    const initAuth = async () => {
      try {
        const result = await getRedirectResult(auth);
        if (result?.user) {
          setUser(result.user);
          setLoading(false);
          return;
        }
      } catch (error) {
        console.error("Error during redirect sign in:", error);
        setLoading(false);
      }

      return onAuthStateChanged(auth, (currentUser) => {
        if (currentUser) {
          setUser(currentUser);
          setLoading(false);
        } else if (!isRedirecting) {
          if (import.meta.env.VITE_FIREBASE_API_KEY && import.meta.env.VITE_FIREBASE_API_KEY !== "mock-api-key") {
            isRedirecting = true;
            signInWithRedirect(auth, provider).catch((error) => {
              console.error("Sign in with redirect failed", error);
              setLoading(false);
            });
          } else {
            console.warn("No Firebase API Key provided, using mock authentication.");
            setUser({ email: "student@auy.edu", displayName: "Jane Doe", uid: "mock-uid" } as User);
            setLoading(false);
          }
        }
      });
    };

    let unsubscribe: () => void;
    initAuth().then((unsub) => {
      if (unsub) unsubscribe = unsub;
    });

    return () => {
      if (unsubscribe) unsubscribe();
    };
  }, []);

  const logout = async () => {
    try {
      await signOut(auth);
    } catch (error) {
      console.error("Logout failed:", error);
    }
  };

  return (
    <AuthContext.Provider value={{ user, loading, logout }}>
      {/* We can render children immediately if loading is true, but we might want a loading spinner instead */}
      {loading ? (
        <div className="min-h-screen bg-emerald-950 flex items-center justify-center text-white">
          <div className="animate-pulse flex flex-col items-center">
            <div className="w-12 h-12 border-4 border-emerald-400 border-t-transparent rounded-full animate-spin"></div>
            <p className="mt-4 text-emerald-100/70">Authenticating...</p>
          </div>
        </div>
      ) : (
        children
      )}
    </AuthContext.Provider>
  );
};
