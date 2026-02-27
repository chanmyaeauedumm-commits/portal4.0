import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { getStudentEnrollmentsWithFallback, getStudentWithFallback, getStudentStats } from '../lib/portalData';
import CalendarWidget from '../components/CalendarWidget';
import { BookOpen, GraduationCap, Calendar as CalendarIcon, TrendingUp } from 'lucide-react';
import '@fontsource/poppins/400.css';

export const Welcome = () => {
  const [enrollments, setEnrollments] = useState<any[]>([]);
  const [studentInfo, setStudentInfo] = useState<any>(null);
  const [stats, setStats] = useState({ totalCourses: 0, avgAttendance: 0, gpa: 0 });
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    const loadData = async () => {
      const email = localStorage.getItem('studentEmail');
      if (!email) {
        navigate('/');
        return;
      }

      try {
        const studentEnrollments = await getStudentEnrollmentsWithFallback(email);
        const student = await getStudentWithFallback(email);
        
        if (studentEnrollments.length > 0) {
          setEnrollments(studentEnrollments);
          setStudentInfo(student);
          setStats(getStudentStats(studentEnrollments));
        }
      } catch (error) {
        console.error('Error loading dashboard:', error);
      } finally {
        setLoading(false);
      }
    };

    loadData();
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
        <style>{`
          @keyframes spin { to { transform: rotate(360deg); } }
        `}</style>
      </div>
    );
  }

  if (!studentInfo) {
    return (
      <div style={{
        minHeight: '100vh',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center'
      }}>
        <div style={{ textAlign: 'center' }}>
          <h2 style={{ color: '#111827', marginBottom: '1rem' }}>Student not found</h2>
          <button
            onClick={() => navigate('/')}
            style={{
              padding: '0.5rem 1rem',
              backgroundColor: '#4F46E5',
              color: 'white',
              border: 'none',
              borderRadius: '8px',
              cursor: 'pointer'
            }}
          >
            Go to Login
          </button>
        </div>
      </div>
    );
  }

  const upcomingCourses = enrollments.slice(0, 3);

  return (
    <div style={{ padding: '2rem' }}>
      <div style={{ marginBottom: '2rem' }}>
        <h1 style={{ fontSize: '1.5rem', color: '#111827', marginBottom: '0.5rem' }}>
          Welcome back, {studentInfo.name}!
        </h1>
        <p style={{ fontSize: '0.9rem', color: '#6B7280' }}>
          {studentInfo.id} • {studentInfo.major} • {studentInfo.studyMode}
        </p>
      </div>

      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))',
        gap: '1rem',
        marginBottom: '2rem'
      }}>
        <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '1.25rem', boxShadow: '0 4px 20px rgba(0,0,0,0.03)', border: '1px solid #F3F4F6', display: 'flex', alignItems: 'center', gap: '1rem' }}>
          <div style={{ padding: '0.75rem', backgroundColor: '#EEF2FF', borderRadius: '10px' }}>
            <BookOpen size={20} color="#4F46E5" />
          </div>
          <div>
            <p style={{ fontSize: '0.7rem', color: '#9CA3AF', marginBottom: '0.25rem' }}>COURSES</p>
            <p style={{ fontSize: '1.25rem', color: '#111827', margin: 0 }}>{stats.totalCourses}</p>
          </div>
        </div>

        <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '1.25rem', boxShadow: '0 4px 20px rgba(0,0,0,0.03)', border: '1px solid #F3F4F6', display: 'flex', alignItems: 'center', gap: '1rem' }}>
          <div style={{ padding: '0.75rem', backgroundColor: '#E6F7E6', borderRadius: '10px' }}>
            <TrendingUp size={20} color="#10B981" />
          </div>
          <div>
            <p style={{ fontSize: '0.7rem', color: '#9CA3AF', marginBottom: '0.25rem' }}>ATTENDANCE</p>
            <p style={{ fontSize: '1.25rem', color: '#111827', margin: 0 }}>{stats.avgAttendance}%</p>
          </div>
        </div>

        <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '1.25rem', boxShadow: '0 4px 20px rgba(0,0,0,0.03)', border: '1px solid #F3F4F6', display: 'flex', alignItems: 'center', gap: '1rem' }}>
          <div style={{ padding: '0.75rem', backgroundColor: '#FEF3C7', borderRadius: '10px' }}>
            <GraduationCap size={20} color="#92400E" />
          </div>
          <div>
            <p style={{ fontSize: '0.7rem', color: '#9CA3AF', marginBottom: '0.25rem' }}>GPA</p>
            <p style={{ fontSize: '1.25rem', color: '#111827', margin: 0 }}>{stats.gpa.toFixed(2)}</p>
          </div>
        </div>
      </div>

      <div style={{
        display: 'grid',
        gridTemplateColumns: '1fr 1fr',
        gap: '2rem'
      }}>
        <div>
          <h2 style={{ fontSize: '1rem', color: '#111827', marginBottom: '1rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
            <CalendarIcon size={18} color="#4F46E5" />
            Myanmar Calendar 2026
          </h2>
          <CalendarWidget />
        </div>

        <div>
          <h2 style={{ fontSize: '1rem', color: '#111827', marginBottom: '1rem' }}>
            Current Courses
          </h2>
          
          <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '1rem', boxShadow: '0 4px 20px rgba(0,0,0,0.03)', border: '1px solid #F3F4F6' }}>
            {upcomingCourses.map((course, index) => (
              <div
                key={index}
                style={{
                  padding: '0.75rem',
                  borderBottom: index < upcomingCourses.length - 1 ? '1px solid #F3F4F6' : 'none',
                  cursor: 'pointer'
                }}
                onClick={() => navigate('/courses')}
              >
                <p style={{ fontSize: '0.9rem', color: '#111827', marginBottom: '0.25rem' }}>
                  {course.courseName}
                </p>
                <p style={{ fontSize: '0.7rem', color: '#6B7280' }}>
                  {course.courseId} • {course.teacherName}
                </p>
              </div>
            ))}
          </div>

          <div style={{ marginTop: '2rem' }}>
            <h2 style={{ fontSize: '1rem', color: '#111827', marginBottom: '1rem' }}>
              Upcoming Events
            </h2>
            
            <div style={{ backgroundColor: 'white', borderRadius: '12px', padding: '1rem', boxShadow: '0 4px 20px rgba(0,0,0,0.03)', border: '1px solid #F3F4F6' }}>
              <div style={{ padding: '0.5rem 0.75rem', backgroundColor: '#FEF3C7', borderRadius: '8px', marginBottom: '0.5rem', color: '#92400E' }}>
                🎉 Thingyan Festival • April 1-4, 2026
              </div>
              <div style={{ padding: '0.5rem 0.75rem', backgroundColor: '#DBEAFE', borderRadius: '8px', marginBottom: '0.5rem', color: '#1E40AF' }}>
                🎓 Final Exams • May 15-30, 2026
              </div>
              <div style={{ padding: '0.5rem 0.75rem', backgroundColor: '#D1FAE5', borderRadius: '8px', color: '#065F46' }}>
                🌟 New Semester • June 1, 2026
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};
