import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useData } from '../contexts/DataContext';
import { Calendar, CheckCircle, XCircle, AlertCircle } from 'lucide-react';
import '@fontsource/poppins/400.css';

const Attendance = () => {
  const { enrollments, loading: dataLoading } = useData();
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    const email = localStorage.getItem('studentEmail');
    if (!email) {
      navigate('/');
      return;
    }
    setLoading(false);
  }, [navigate]);

  if (loading || dataLoading) {
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

  const overallAttendance = enrollments.length > 0
    ? Math.round(enrollments.reduce((sum, e) => sum + e.attendancePercentage, 0) / enrollments.length)
    : 0;

  const getStatus = (percentage: number) => {
    if (percentage >= 90) return { label: 'Excellent', color: '#10B981', icon: CheckCircle };
    if (percentage >= 80) return { label: 'Good', color: '#F59E0B', icon: AlertCircle };
    return { label: 'Needs Improvement', color: '#EF4444', icon: XCircle };
  };

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
          <Calendar size={24} color="#4F46E5" />
          Attendance Overview
        </h1>
      </div>

      <div style={{
        backgroundColor: 'white',
        borderRadius: '12px',
        padding: '2rem',
        boxShadow: '0 4px 20px rgba(0,0,0,0.03)',
        border: '1px solid #F3F4F6',
        marginBottom: '2rem',
        textAlign: 'center'
      }}>
        <p style={{ fontSize: '0.9rem', color: '#6B7280', marginBottom: '0.5rem', fontWeight: 400 }}>
          Overall Attendance
        </p>
        <p style={{ fontSize: '3rem', color: '#111827', marginBottom: '1rem', fontWeight: 400 }}>
          {overallAttendance}%
        </p>
        <div style={{
          width: '200px',
          height: '8px',
          backgroundColor: '#E5E7EB',
          borderRadius: '9999px',
          margin: '0 auto',
          overflow: 'hidden'
        }}>
          <div style={{
            width: `${overallAttendance}%`,
            height: '100%',
            backgroundColor: 
              overallAttendance >= 90 ? '#10B981' :
              overallAttendance >= 80 ? '#F59E0B' :
              '#EF4444',
            borderRadius: '9999px',
            transition: 'width 0.3s ease'
          }}></div>
        </div>
      </div>

      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fill, minmax(300px, 1fr))',
        gap: '1.5rem'
      }}>
        {enrollments.map((course, index) => {
          const status = getStatus(course.attendancePercentage);
          const Icon = status.icon;
          
          return (
            <div
              key={index}
              style={{
                backgroundColor: 'white',
                borderRadius: '12px',
                padding: '1.5rem',
                boxShadow: '0 4px 20px rgba(0,0,0,0.03)',
                border: '1px solid #F3F4F6'
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
                    fontSize: '1rem',
                    color: '#111827',
                    marginBottom: '0.25rem',
                    fontWeight: 400
                  }}>
                    {course.courseName}
                  </h3>
                  <p style={{
                    fontSize: '0.8rem',
                    color: '#6B7280',
                    fontWeight: 400
                  }}>
                    {course.courseId}
                  </p>
                </div>
                <Icon size={20} color={status.color} />
              </div>

              <div style={{ marginBottom: '1rem' }}>
                <div style={{
                  display: 'flex',
                  justifyContent: 'space-between',
                  alignItems: 'center',
                  marginBottom: '0.5rem'
                }}>
                  <span style={{ fontSize: '0.8rem', color: '#6B7280', fontWeight: 400 }}>Attendance</span>
                  <span style={{
                    fontSize: '1.25rem',
                    color: '#111827',
                    fontWeight: 400
                  }}>
                    {course.attendancePercentage}%
                  </span>
                </div>
                <div style={{
                  width: '100%',
                  height: '6px',
                  backgroundColor: '#E5E7EB',
                  borderRadius: '9999px',
                  overflow: 'hidden'
                }}>
                  <div style={{
                    width: `${course.attendancePercentage}%`,
                    height: '100%',
                    backgroundColor: status.color,
                    borderRadius: '9999px',
                    transition: 'width 0.3s ease'
                  }}></div>
                </div>
              </div>

              <div style={{
                padding: '0.5rem',
                backgroundColor: '#F9FAFB',
                borderRadius: '8px',
                fontSize: '0.8rem',
                color: status.color,
                textAlign: 'center',
                fontWeight: 400
              }}>
                {status.label}
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
};

export { Attendance };


