import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { FileText, Calendar, Clock } from 'lucide-react';
import '@fontsource/poppins/400.css';

interface Exam {
  course: string;
  code: string;
  date: string;
  time: string;
  duration: string;
  location: string;
  type: string;
}

const Exams = () => {
  const [exams, setExams] = useState<Exam[]>([]);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    const email = localStorage.getItem('studentEmail');
    if (!email) {
      navigate('/');
      return;
    }

    // Sample exams - in production, fetch from Firebase
    setExams([
      {
        course: 'Introduction to Business',
        code: 'BUS101',
        date: '2026-05-15',
        time: '09:00 AM',
        duration: '3 hours',
        location: 'Hall A',
        type: 'Final Exam'
      },
      {
        course: 'English Composition',
        code: 'ENG101',
        date: '2026-05-18',
        time: '01:00 PM',
        duration: '2 hours',
        location: 'Hall B',
        type: 'Final Exam'
      },
      {
        course: 'Computer Fundamentals',
        code: 'IT101',
        date: '2026-05-20',
        time: '09:00 AM',
        duration: '3 hours',
        location: 'Lab 101',
        type: 'Final Exam'
      },
      {
        course: 'College Mathematics',
        code: 'MATH101',
        date: '2026-05-22',
        time: '01:00 PM',
        duration: '3 hours',
        location: 'Hall C',
        type: 'Final Exam'
      }
    ]);
    setLoading(false);
  }, [navigate]);

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
          <FileText size={24} color="#4F46E5" />
          Exam Schedule
        </h1>
        <p style={{ color: '#6B7280', fontSize: '0.9rem', fontWeight: 400 }}>
          Final Examination Schedule - May 2026
        </p>
      </div>

      <div style={{
        backgroundColor: 'white',
        borderRadius: '12px',
        boxShadow: '0 4px 20px rgba(0,0,0,0.03)',
        border: '1px solid #F3F4F6',
        overflow: 'hidden'
      }}>
        <div style={{ overflowX: 'auto' }}>
          <table style={{
            width: '100%',
            borderCollapse: 'collapse',
            fontSize: '0.9rem'
          }}>
            <thead style={{ backgroundColor: '#F9FAFB' }}>
              <tr>
                <th style={{ padding: '1rem 1.5rem', textAlign: 'left', color: '#6B7280', fontWeight: 400 }}>Course</th>
                <th style={{ padding: '1rem 1.5rem', textAlign: 'left', color: '#6B7280', fontWeight: 400 }}>Code</th>
                <th style={{ padding: '1rem 1.5rem', textAlign: 'left', color: '#6B7280', fontWeight: 400 }}>Date</th>
                <th style={{ padding: '1rem 1.5rem', textAlign: 'left', color: '#6B7280', fontWeight: 400 }}>Time</th>
                <th style={{ padding: '1rem 1.5rem', textAlign: 'left', color: '#6B7280', fontWeight: 400 }}>Duration</th>
                <th style={{ padding: '1rem 1.5rem', textAlign: 'left', color: '#6B7280', fontWeight: 400 }}>Location</th>
                <th style={{ padding: '1rem 1.5rem', textAlign: 'left', color: '#6B7280', fontWeight: 400 }}>Type</th>
              </tr>
            </thead>
            <tbody>
              {exams.map((exam, index) => (
                <tr key={index} style={{
                  borderTop: '1px solid #F3F4F6',
                  transition: 'background-color 0.2s'
                }}
                onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#F9FAFB'}
                onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'white'}
                >
                  <td style={{ padding: '1rem 1.5rem', color: '#111827', fontWeight: 400 }}>{exam.course}</td>
                  <td style={{ padding: '1rem 1.5rem', color: '#6B7280', fontWeight: 400 }}>{exam.code}</td>
                  <td style={{ padding: '1rem 1.5rem', color: '#111827', fontWeight: 400 }}>
                    {new Date(exam.date).toLocaleDateString()}
                  </td>
                  <td style={{ padding: '1rem 1.5rem', color: '#111827', fontWeight: 400 }}>{exam.time}</td>
                  <td style={{ padding: '1rem 1.5rem', color: '#6B7280', fontWeight: 400 }}>{exam.duration}</td>
                  <td style={{ padding: '1rem 1.5rem', color: '#6B7280', fontWeight: 400 }}>{exam.location}</td>
                  <td style={{ padding: '1rem 1.5rem' }}>
                    <span style={{
                      padding: '0.25rem 0.75rem',
                      backgroundColor: '#EEF2FF',
                      color: '#4F46E5',
                      borderRadius: '9999px',
                      fontSize: '0.75rem',
                      fontWeight: 400
                    }}>
                      {exam.type}
                    </span>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      <div style={{
        marginTop: '2rem',
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fit, minmax(250px, 1fr))',
        gap: '1rem'
      }}>
        <div style={{
          backgroundColor: 'white',
          borderRadius: '12px',
          padding: '1.5rem',
          boxShadow: '0 4px 20px rgba(0,0,0,0.03)',
          border: '1px solid #F3F4F6'
        }}>
          <Clock size={24} color="#4F46E5" style={{ marginBottom: '1rem' }} />
          <h3 style={{ fontSize: '1rem', color: '#111827', marginBottom: '0.5rem', fontWeight: 400 }}>Time Management</h3>
          <p style={{ fontSize: '0.8rem', color: '#6B7280', lineHeight: '1.5', fontWeight: 400 }}>
            Create a study schedule and stick to it. Take regular breaks to stay focused.
          </p>
        </div>

        <div style={{
          backgroundColor: 'white',
          borderRadius: '12px',
          padding: '1.5rem',
          boxShadow: '0 4px 20px rgba(0,0,0,0.03)',
          border: '1px solid #F3F4F6'
        }}>
          <FileText size={24} color="#10B981" style={{ marginBottom: '1rem' }} />
          <h3 style={{ fontSize: '1rem', color: '#111827', marginBottom: '0.5rem', fontWeight: 400 }}>Review Materials</h3>
          <p style={{ fontSize: '0.8rem', color: '#6B7280', lineHeight: '1.5', fontWeight: 400 }}>
            Go through your notes, past assignments, and practice problems.
          </p>
        </div>

        <div style={{
          backgroundColor: 'white',
          borderRadius: '12px',
          padding: '1.5rem',
          boxShadow: '0 4px 20px rgba(0,0,0,0.03)',
          border: '1px solid #F3F4F6'
        }}>
          <Calendar size={24} color="#F59E0B" style={{ marginBottom: '1rem' }} />
          <h3 style={{ fontSize: '1rem', color: '#111827', marginBottom: '0.5rem', fontWeight: 400 }}>Rest Well</h3>
          <p style={{ fontSize: '0.8rem', color: '#6B7280', lineHeight: '1.5', fontWeight: 400 }}>
            Get enough sleep before exams. A well-rested mind performs better.
          </p>
        </div>
      </div>
    </div>
  );
};

export { Exams };


