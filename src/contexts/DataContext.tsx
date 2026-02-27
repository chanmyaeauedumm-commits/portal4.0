import React, { createContext, useContext, useEffect, useState } from 'react';
import { useAuth } from './AuthContext';
import { db } from '../lib/firebase';

export interface Enrollment {
  studentId: string;
  studentName: string;
  email: string;
  studyMode: string;
  major: string;
  courseId: string;
  courseName: string;
  teacherName: string;
  credits: number;
  grade: string;
  googleClassroomLink: string;
  attendancePercentage: number;
  lastUpdated: string;
}

interface DataContextType {
  enrollments: Enrollment[];
  loading: boolean;
  studentInfo: {
    studentId: string;
    studentName: string;
    email: string;
    major: string;
    studyMode: string;
  } | null;
}

const DataContext = createContext<DataContextType>({ 
  enrollments: [], 
  loading: true, 
  studentInfo: null 
});

export const useData = () => useContext(DataContext);

export const DataProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const { user } = useAuth();
  const [enrollments, setEnrollments] = useState<Enrollment[]>([]);
  const [loading, setLoading] = useState(true);
  const [studentInfo, setStudentInfo] = useState(null);

  useEffect(() => {
    const loadData = async () => {
      if (!user?.email) {
        setLoading(false);
        return;
      }

      try {
        const emailKey = user.email.replace(/\./g, ',,,');
        const studentRef = db.ref(`students/${emailKey}`);
        const snapshot = await studentRef.once('value');
        const studentData = snapshot.val();

        if (studentData) {
          setStudentInfo({
            studentId: studentData.studentId || '',
            studentName: studentData.studentName || '',
            email: user.email || '',
            major: studentData.major || '',
            studyMode: studentData.studyMode || ''
          });

          const coursesRef = db.ref(`students/${emailKey}/courses`);
          const coursesSnapshot = await coursesRef.once('value');
          const coursesData = coursesSnapshot.val() || {};
          
          const enrollmentList: Enrollment[] = [];
          
          for (const [courseId, courseData] of Object.entries(coursesData)) {
            const courseRef = db.ref(`courses/${courseId}`);
            const courseSnapshot = await courseRef.once('value');
            const courseInfo = courseSnapshot.val() || {};
            
            enrollmentList.push({
              studentId: studentData.studentId || '',
              studentName: studentData.studentName || '',
              email: user.email || '',
              studyMode: studentData.studyMode || '',
              major: studentData.major || '',
              courseId: courseId,
              courseName: courseInfo.courseName || '',
              teacherName: courseInfo.teacher || '',
              credits: courseInfo.credits || 3,
              grade: (courseData as any).grade || '',
              googleClassroomLink: courseInfo.googleClassroomLink || 'https://classroom.google.com/',
              attendancePercentage: (courseData as any).attendancePercentage || 0,
              lastUpdated: (courseData as any).lastUpdated || new Date().toISOString().split('T')[0]
            });
          }
          
          setEnrollments(enrollmentList);
        }
      } catch (error) {
        console.error('Error loading data:', error);
      } finally {
        setLoading(false);
      }
    };

    loadData();
  }, [user]);

  return (
    <DataContext.Provider value={{ enrollments, loading, studentInfo }}>
      {children}
    </DataContext.Provider>
  );
};
