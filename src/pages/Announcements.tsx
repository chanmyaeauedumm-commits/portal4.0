import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Megaphone, Calendar, AlertCircle } from 'lucide-react';
import '@fontsource/poppins/400.css';

interface Announcement {
  id: number;
  title: string;
  content: string;
  date: string;
  author: string;
  priority: 'high' | 'medium' | 'low';
  category: string;
}

const Announcements = () => {
  const [announcements, setAnnouncements] = useState<Announcement[]>([]);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    const email = localStorage.getItem('studentEmail');
    if (!email) {
      navigate('/');
      return;
    }

    // Sample announcements - in production, fetch from Firebase
    setAnnouncements([
      {
        id: 1,
        title: 'Final Exam Schedule Released',
        content: 'The final examination schedule for May 2026 has been published. Please check the Exams page for your personal schedule.',
        date: '2026-04-15',
        author: 'Academic Office',
        priority: 'high',
        category: 'Academic'
      },
      {
        id: 2,
        title: 'Thingyan Holiday Notice',
        content: 'University will be closed from March 30 to April 4, 2026 for Thingyan Festival. Classes resume on April 5.',
        date: '2026-03-20',
        author: 'Administration',
        priority: 'high',
        category: 'Holiday'
      },
      {
        id: 3,
        title: 'Library Hours Extended',
        content: 'The library will be open until 10 PM during exam preparation week (May 10-14).',
        date: '2026-05-01',
        author: 'Library',
        priority: 'medium',
        category: 'Facility'
      }
    ]);
    setLoading(false);
  }, [navigate]);

  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case 'high': return { bg: '#FEF2F2', text: '#DC2626', border: '#FECACA' };
      case 'medium': return { bg: '#FEF3C7', text: '#92400E', border: '#FCD34D' };
      default: return { bg: '#F3F4F6', text: '#6B7280', border: '#E5E7EB' };
    }
  };

  if (loading) {
    return (
      <div style={{
        minHeight: '100vh',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center'
      }}>
        <div style={{
          width: '40px',
          height: '40px',
          borderRadius: '50%',
          border: '3px solid #E5E7EB',
          borderTopColor: '#4F46E5',
          animation: 'spin 1s linear infinite'
        }}></div>
      </div>
    );
  }

  return (
    <div style={{ padding: '2rem' }}>
      <div style={{ marginBottom: '2rem' }}>
        <h1 style={{
          fontSize: '1.5rem',
          color: '#111827',
          marginBottom: '0.5rem',
          display: 'flex',
          alignItems: 'center',
          gap: '0.5rem',
          fontWeight: 400
        }}>
          <Megaphone size={24} color="#4F46E5" />
          Announcements
        </h1>
      </div>

      <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
        {announcements.map((announcement) => {
          const colors = getPriorityColor(announcement.priority);
          
          return (
            <div
              key={announcement.id}
              style={{
                backgroundColor: 'white',
                borderRadius: '12px',
                padding: '1.5rem',
                boxShadow: '0 4px 20px rgba(0,0,0,0.03)',
                border: '1px solid #F3F4F6',
                borderLeft: `4px solid ${colors.text}`,
                transition: 'all 0.2s'
              }}
            >
              <div style={{
                display: 'flex',
                justifyContent: 'space-between',
                alignItems: 'start',
                marginBottom: '1rem'
              }}>
                <div>
                  <h3 style={{
                    fontSize: '1.1rem',
                    color: '#111827',
                    marginBottom: '0.5rem',
                    fontWeight: 400
                  }}>
                    {announcement.title}
                  </h3>
                  <div style={{
                    display: 'flex',
                    alignItems: 'center',
                    gap: '1rem',
                    fontSize: '0.8rem',
                    color: '#6B7280'
                  }}>
                    <span style={{ display: 'flex', alignItems: 'center', gap: '0.25rem', fontWeight: 400 }}>
                      <Calendar size={12} />
                      {new Date(announcement.date).toLocaleDateString()}
                    </span>
                    <span>•</span>
                    <span>{announcement.author}</span>
                    <span>•</span>
                    <span style={{
                      padding: '0.25rem 0.5rem',
                      backgroundColor: '#F3F4F6',
                      borderRadius: '4px',
                      fontSize: '0.7rem'
                    }}>
                      {announcement.category}
                    </span>
                  </div>
                </div>
                <span style={{
                  padding: '0.25rem 0.75rem',
                  backgroundColor: colors.bg,
                  color: colors.text,
                  borderRadius: '9999px',
                  fontSize: '0.7rem',
                  border: `1px solid ${colors.border}`,
                  fontWeight: 400
                }}>
                  {announcement.priority.toUpperCase()}
                </span>
              </div>

              <p style={{
                fontSize: '0.9rem',
                color: '#4B5563',
                lineHeight: '1.6',
                fontWeight: 400
              }}>
                {announcement.content}
              </p>

              {announcement.priority === 'high' && (
                <div style={{
                  display: 'flex',
                  alignItems: 'center',
                  gap: '0.5rem',
                  marginTop: '1rem',
                  padding: '0.5rem',
                  backgroundColor: '#FEF2F2',
                  borderRadius: '8px',
                  fontSize: '0.8rem',
                  color: '#DC2626'
                }}>
                  <AlertCircle size={14} />
                  <span>Action may be required</span>
                </div>
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
};

export { Announcements };


