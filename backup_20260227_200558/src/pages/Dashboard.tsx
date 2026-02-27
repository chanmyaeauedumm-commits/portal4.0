import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import '@fontsource/poppins/400.css';

const Dashboard = () => {
  const [user, setUser] = useState<any>(null);
  const navigate = useNavigate();

  useEffect(() => {
    const userData = localStorage.getItem('currentUser');
    if (!userData) {
      navigate('/');
      return;
    }
    setUser(JSON.parse(userData));
  }, [navigate]);

  const handleLogout = () => {
    localStorage.removeItem('currentUser');
    navigate('/');
  };

  if (!user) return null;

  return (
    <div className="min-h-screen" style={{ backgroundColor: '#f9fafb' }}>
      {/* Header with subtle shadow */}
      <div style={{
        backgroundColor: 'rgba(255, 255, 255, 0.9)',
        backdropFilter: 'blur(10px)',
        borderBottom: '1px solid #f3f4f6',
        boxShadow: '0 2px 8px rgba(0, 0, 0, 0.02)',
        position: 'sticky',
        top: 0,
        zIndex: 10
      }}>
        <div style={{ maxWidth: '1280px', margin: '0 auto', padding: '1rem 2rem' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <div>
              <h1 style={{ fontSize: '1.25rem', color: '#111827', margin: 0, fontFamily: 'Poppins', fontWeight: 400 }}>
                welcome back, <span style={{ color: '#4f46e5' }}>{user.name}</span>
              </h1>
              <p style={{ fontSize: '0.75rem', color: '#9ca3af', marginTop: '0.25rem', fontFamily: 'Poppins', fontWeight: 400 }}>
                {user.id} • {user.email}
              </p>
            </div>
            <button
              onClick={handleLogout}
              style={{
                padding: '0.5rem 1rem',
                backgroundColor: 'white',
                color: '#4b5563',
                border: '1px solid #e5e7eb',
                borderRadius: '0.75rem',
                fontFamily: 'Poppins',
                fontWeight: 400,
                fontSize: '0.875rem',
                cursor: 'pointer',
                boxShadow: '0 2px 8px rgba(0, 0, 0, 0.05)',
                transition: 'all 0.3s ease'
              }}
              onMouseEnter={(e) => {
                e.currentTarget.style.boxShadow = '0 4px 12px rgba(0, 0, 0, 0.1)';
                e.currentTarget.style.backgroundColor = '#f9fafb';
              }}
              onMouseLeave={(e) => {
                e.currentTarget.style.boxShadow = '0 2px 8px rgba(0, 0, 0, 0.05)';
                e.currentTarget.style.backgroundColor = 'white';
              }}
            >
              sign out
            </button>
          </div>
        </div>
      </div>

      {/* Main content */}
      <div style={{ maxWidth: '1280px', margin: '0 auto', padding: '2rem' }}>
        {/* Stats cards */}
        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))', gap: '1.5rem', marginBottom: '2rem' }}>
          {[
            { label: 'courses enrolled', value: '6' },
            { label: 'attendance avg', value: '91%' },
            { label: 'current gpa', value: '3.4' },
          ].map((stat, i) => (
            <div
              key={i}
              style={{
                backgroundColor: 'white',
                borderRadius: '0.75rem',
                padding: '1.5rem',
                border: '1px solid #f3f4f6',
                boxShadow: '0 4px 20px -8px rgba(0, 0, 0, 0.15)',
                transition: 'all 0.3s ease'
              }}
              onMouseEnter={(e) => {
                e.currentTarget.style.boxShadow = '0 8px 30px -12px rgba(0, 0, 0, 0.2)';
                e.currentTarget.style.transform = 'translateY(-2px)';
              }}
              onMouseLeave={(e) => {
                e.currentTarget.style.boxShadow = '0 4px 20px -8px rgba(0, 0, 0, 0.15)';
                e.currentTarget.style.transform = 'translateY(0)';
              }}
            >
              <p style={{ fontSize: '0.75rem', color: '#9ca3af', textTransform: 'uppercase', letterSpacing: '0.05em', marginBottom: '0.5rem', fontFamily: 'Poppins', fontWeight: 400 }}>
                {stat.label}
              </p>
              <p style={{ fontSize: '1.875rem', color: '#111827', margin: 0, fontFamily: 'Poppins', fontWeight: 400 }}>
                {stat.value}
              </p>
            </div>
          ))}
        </div>

        {/* Courses card */}
        <div style={{
          backgroundColor: 'white',
          borderRadius: '0.75rem',
          border: '1px solid #f3f4f6',
          boxShadow: '0 8px 30px -12px rgba(0, 0, 0, 0.15)',
          overflow: 'hidden'
        }}>
          <div style={{ padding: '1rem 1.5rem', borderBottom: '1px solid #f3f4f6' }}>
            <h2 style={{ fontSize: '0.875rem', color: '#111827', margin: 0, fontFamily: 'Poppins', fontWeight: 400 }}>
              current courses
            </h2>
          </div>
          <div>
            {[1, 2, 3, 4].map((_, i) => (
              <div
                key={i}
                style={{
                  padding: '1rem 1.5rem',
                  borderBottom: i < 3 ? '1px solid #f3f4f6' : 'none',
                  transition: 'background-color 0.2s ease'
                }}
                onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#f9fafb'}
                onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'white'}
              >
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                  <div>
                    <p style={{ fontSize: '0.875rem', color: '#111827', marginBottom: '0.25rem', fontFamily: 'Poppins', fontWeight: 400 }}>
                      Course Title {i + 1}
                    </p>
                    <p style={{ fontSize: '0.75rem', color: '#9ca3af', margin: 0, fontFamily: 'Poppins', fontWeight: 400 }}>
                      CODE{i + 1} • Prof. Name
                    </p>
                  </div>
                  <span style={{ fontSize: '0.75rem', color: '#9ca3af', fontFamily: 'Poppins', fontWeight: 400 }}>
                    in progress
                  </span>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
