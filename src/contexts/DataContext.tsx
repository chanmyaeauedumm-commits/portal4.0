import React, { createContext, useContext, useEffect, useState } from 'react';
import { useAuth } from './AuthContext';
import { Enrollment, fetchEnrollmentsByEmail } from '../services/firebaseData';

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

const DataContext = createContext<DataContextType>({ enrollments: [], loading: true, studentInfo: null });

export const useData = () => useContext(DataContext);

export const DataProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const { user } = useAuth();
  const [enrollments, setEnrollments] = useState<Enrollment[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (user && user.email) {
      setLoading(true);
      fetchEnrollmentsByEmail(user.email).then((data) => {
        setEnrollments(data);
        setLoading(false);
      }).catch(err => {
        console.error("Failed to fetch enrollments:", err);
        setLoading(false);
      });
    } else {
      setEnrollments([]);
      setLoading(false);
    }
  }, [user]);

  const studentInfo = enrollments.length > 0 ? {
    studentId: enrollments[0].studentId,
    studentName: enrollments[0].studentName,
    email: enrollments[0].email,
    major: enrollments[0].major,
    studyMode: enrollments[0].studyMode,
  } : null;

  return (
    <DataContext.Provider value={{ enrollments, loading, studentInfo }}>
      {children}
    </DataContext.Provider>
  );
};
