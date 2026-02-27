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

// Convert email to Firebase key
function emailToFirebaseKey(email: string): string {
  return email.replace(/\./g, ',,,');
}

export const fetchEnrollmentsByEmail = async (email: string): Promise<Enrollment[]> => {
  try {
    const emailKey = emailToFirebaseKey(email);
    const studentRef = db.ref(`students/${emailKey}`);
    const snapshot = await studentRef.once('value');
    const studentData = snapshot.val();
    
    if (!studentData) return [];
    
    const coursesRef = db.ref(`students/${emailKey}/courses`);
    const coursesSnapshot = await coursesRef.once('value');
    const coursesData = coursesSnapshot.val() || {};
    
    const enrollments: Enrollment[] = [];
    
    for (const [courseId, courseData] of Object.entries(coursesData)) {
      const courseRef = db.ref(`courses/${courseId}`);
      const courseSnapshot = await courseRef.once('value');
      const courseInfo = courseSnapshot.val() || {};
      
      enrollments.push({
        studentId: studentData.studentId || '',
        studentName: studentData.studentName || '',
        email: email,
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
    
    return enrollments;
  } catch (error) {
    console.error('Error fetching enrollments:', error);
    return [];
  }
};
