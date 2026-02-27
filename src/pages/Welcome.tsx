import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { getStudentEnrollmentsWithFallback, getStudentWithFallback, getStudentStats, Enrollment } from '../lib/portalData';
import CalendarWidget from '../components/CalendarWidget';
import { BookOpen, GraduationCap, Calendar as CalendarIcon, TrendingUp } from 'lucide-react';

const Welcome = () => {
  const [enrollments, setEnrollments] = useState<Enrollment[]>([]);
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
        const [studentEnrollments, student] = await Promise.all([
          getStudentEnrollmentsWithFallback(email),
          getStudentWithFallback(email)
        ]);
        
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
            className="btn btn-primary"
          >
            Go to Login
          </button>
        </div>
      </div>
    );
  }

  // Get upcoming courses (next 3)
  const upcomingCourses = enrollments.slice(0, 3);

  return (
    <div style={{ padding: '2rem' }}>
      {/* Welcome Header */}
      <div style={{ marginBottom: '2rem' }}>
        <h1 style={{ fontSize: '1.5rem', color: '#111827', marginBottom: '0.5rem' }}>
          Welcome back, {studentInfo.name}!
        </h1>
        <p style={{ fontSize: '0.9rem', color: '#6B7280' }}>
          {studentInfo.id} • {studentInfo.major} • {studentInfo.studyMode}
        </p>
      </div>

      {/* Stats Cards */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fit, minmax(200px, 1fr))',
        gap: '1rem',
        marginBottom: '2rem'
      }}>
        <div className="card stats-card">
          <div className="stats-icon" style={{ backgroundColor: '#EEF2FF' }}>
            <BookOpen size={20} color="#4F46E5" />
          </div>
          <div>
            <p style={{ fontSize: '0.7rem', color: '#9CA3AF', marginBottom: '0.25rem' }}>COURSES</p>
            <p style={{ fontSize: '1.25rem', color: '#111827', margin: 0 }}>{stats.totalCourses}</p>
          </div>
        </div>

        <div className="card stats-card">
          <div className="stats-icon" style={{ backgroundColor: '#E6F7E6' }}>
            <TrendingUp size={20} color="#10B981" />
          </div>
          <div>
            <p style={{ fontSize: '0.7rem', color: '#9CA3AF', marginBottom: '0.25rem' }}>ATTENDANCE</p>
            <p style={{ fontSize: '1.25rem', color: '#111827', margin: 0 }}>{stats.avgAttendance}%</p>
          </div>
        </div>

        <div className="card stats-card">
          <div className="stats-icon" style={{ backgroundColor: '#FEF3C7' }}>
            <GraduationCap size={20} color="#92400E" />
          </div>
          <div>
            <p style={{ fontSize: '0.7rem', color: '#9CA3AF', marginBottom: '0.25rem' }}>GPA</p>
            <p style={{ fontSize: '1.25rem', color: '#111827', margin: 0 }}>{stats.gpa.toFixed(2)}</p>
          </div>
        </div>
      </div>

      {/* Two Column Layout */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: '1fr 1fr',
        gap: '2rem'
      }}>
        {/* Left Column - Calendar */}
        <div>
          <h2 style={{
            fontSize: '1rem',
            color: '#111827',
            marginBottom: '1rem',
            display: 'flex',
            alignItems: 'center',
            gap: '0.5rem'
          }}>
            <CalendarIcon size={18} color="#4F46E5" />
            Myanmar Calendar 2026
          </h2>
          <CalendarWidget />
        </div>

        {/* Right Column - Quick Info */}
        <div>
          <h2 style={{ fontSize: '1rem', color: '#111827', marginBottom: '1rem' }}>
            Current Courses
          </h2>
          
          <div className="card" style={{ padding: '1rem' }}>
            {upcomingCourses.map((course, index) => (
              <div
                key={index}
                style={{
                  padding: '0.75rem',
                  borderBottom: index < upcomingCourses.length - 1 ? '1px solid #F3F4F6' : 'none',
                  cursor: 'pointer',
                  transition: 'background-color 0.2s'
                }}
                onMouseEnter={(e) => e.currentTarget.style.backgroundColor = '#F9FAFB'}
                onMouseLeave={(e) => e.currentTarget.style.backgroundColor = 'white'}
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

          {/* Upcoming Events */}
          <div style={{ marginTop: '2rem' }}>
            <h2 style={{ fontSize: '1rem', color: '#111827', marginBottom: '1rem' }}>
              Upcoming Events
            </h2>
            
            <div className="card" style={{ padding: '1rem' }}>
              <div className="badge badge-warning" style={{ marginBottom: '0.5rem', display: 'block' }}>
                🎉 Thingyan Festival • April 1-4, 2026
              </div>
              <div className="badge badge-info" style={{ marginBottom: '0.5rem', display: 'block' }}>
                🎓 Final Exams • May 15-30, 2026
              </div>
              <div className="badge badge-success" style={{ display: 'block' }}>
                🌟 New Semester • June 1, 2026
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export { Welcome };

