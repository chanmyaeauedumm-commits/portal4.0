import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { auth } from '../lib/firebase';
import '@fontsource/poppins/400.css';

const SimpleLogin = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    try {
      await auth.signInWithEmailAndPassword(email, password);
      localStorage.setItem('studentEmail', email);
      navigate('/dashboard');
    } catch (err: any) {
      setError('Invalid email or password. Please try again.');
      console.error('Login error:', err);
    } finally {
      setLoading(false);
    }
  };

  // For demo purposes
  const demoLogin = (demoEmail: string) => {
    setEmail(demoEmail);
    setPassword('password123');
  };

  return (
    <div style={{ 
      minHeight: '100vh',
      background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      padding: '1rem',
      fontFamily: 'Poppins, sans-serif'
    }}>
      <div style={{
        backgroundColor: 'white',
        borderRadius: '24px',
        boxShadow: '0 20px 60px rgba(0,0,0,0.3)',
        padding: '2rem',
        width: '100%',
        maxWidth: '400px'
      }}>
        <h1 style={{
          fontSize: '2rem',
          textAlign: 'center',
          color: '#111827',
          marginBottom: '0.5rem',
          fontWeight: 400
        }}>
          Student Portal
        </h1>
        <p style={{
          textAlign: 'center',
          color: '#6B7280',
          marginBottom: '2rem',
          fontSize: '0.9rem',
          fontWeight: 400
        }}>
          enter your credentials to continue
        </p>
        
        <form onSubmit={handleSubmit}>
          <div style={{ marginBottom: '1rem' }}>
            <input
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="Email"
              style={{
                width: '100%',
                padding: '0.75rem 1rem',
                backgroundColor: '#F9FAFB',
                border: '1px solid #E5E7EB',
                borderRadius: '12px',
                fontSize: '0.95rem',
                fontFamily: 'Poppins, sans-serif',
                fontWeight: 400,
                outline: 'none',
                transition: 'all 0.2s'
              }}
              required
            />
          </div>

          <div style={{ marginBottom: '1.5rem' }}>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Password"
              style={{
                width: '100%',
                padding: '0.75rem 1rem',
                backgroundColor: '#F9FAFB',
                border: '1px solid #E5E7EB',
                borderRadius: '12px',
                fontSize: '0.95rem',
                fontFamily: 'Poppins, sans-serif',
                fontWeight: 400,
                outline: 'none',
                transition: 'all 0.2s'
              }}
              required
            />
          </div>

          {error && (
            <div style={{
              backgroundColor: '#FEF2F2',
              color: '#DC2626',
              padding: '0.75rem',
              borderRadius: '12px',
              marginBottom: '1.5rem',
              fontSize: '0.9rem',
              border: '1px solid #FECACA',
              fontWeight: 400
            }}>
              {error}
            </div>
          )}

          <button
            type="submit"
            disabled={loading}
            style={{
              width: '100%',
              padding: '0.75rem 1.5rem',
              backgroundColor: '#4F46E5',
              color: 'white',
              border: 'none',
              borderRadius: '12px',
              fontSize: '1rem',
              fontFamily: 'Poppins, sans-serif',
              fontWeight: 400,
              cursor: loading ? 'not-allowed' : 'pointer',
              opacity: loading ? 0.7 : 1,
              boxShadow: '0 4px 6px rgba(79,70,229,0.25)',
              transition: 'all 0.2s'
            }}
          >
            {loading ? 'Signing in...' : 'Sign In'}
          </button>
        </form>

        <div style={{ marginTop: '2rem', textAlign: 'center' }}>
          <p style={{ fontSize: '0.8rem', color: '#9CA3AF', marginBottom: '0.5rem', fontWeight: 400 }}>
            Demo accounts (password: password123)
          </p>
          <div style={{ display: 'flex', flexDirection: 'column', gap: '0.25rem' }}>
            <button
              onClick={() => demoLogin('aung.khant.phyo@student.au.edu.mm')}
              style={{
                background: 'none',
                border: 'none',
                color: '#6B7280',
                fontSize: '0.85rem',
                cursor: 'pointer',
                padding: '0.25rem',
                fontFamily: 'Poppins, sans-serif',
                fontWeight: 400,
                transition: 'color 0.2s'
              }}
              onMouseEnter={(e) => e.currentTarget.style.color = '#4F46E5'}
              onMouseLeave={(e) => e.currentTarget.style.color = '#6B7280'}
            >
              aung.khant.phyo@student.au.edu.mm
            </button>
            <button
              onClick={() => demoLogin('hsu.eain.htet@student.au.edu.mm')}
              style={{
                background: 'none',
                border: 'none',
                color: '#6B7280',
                fontSize: '0.85rem',
                cursor: 'pointer',
                padding: '0.25rem',
                fontFamily: 'Poppins, sans-serif',
                fontWeight: 400,
                transition: 'color 0.2s'
              }}
              onMouseEnter={(e) => e.currentTarget.style.color = '#4F46E5'}
              onMouseLeave={(e) => e.currentTarget.style.color = '#6B7280'}
            >
              hsu.eain.htet@student.au.edu.mm
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default SimpleLogin;
