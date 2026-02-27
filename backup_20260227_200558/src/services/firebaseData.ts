import { ref, get, child } from "firebase/database";
import { db } from "../lib/firebase";

export interface Enrollment {
  studentId: string;
  studentName: string;
  email: string;
  studyMode: string;
  courseId: string;
  courseName: string;
  teacherName: string;
  credits: number;
  grade: string;
  googleClassroomLink: string;
  attendancePercentage: number;
  lastUpdated: string;
  major: string;
}

// Convert email to Firebase key (replace . with ,,,)
function emailToFirebaseKey(email: string): string {
  return email.replace(/\./g, ',,,');
}

export const fetchEnrollmentsByEmail = async (email: string): Promise<Enrollment[]> => {
  try {
    const emailKey = emailToFirebaseKey(email);
    const studentRef = ref(db, `students/${emailKey}/courses`);
    const snapshot = await get(studentRef);
    
    if (snapshot.exists()) {
      const coursesData = snapshot.val();
      const enrollments: Enrollment[] = [];
      
      // Get student basic info
      const studentInfoRef = ref(db, `students/${emailKey}`);
      const studentSnapshot = await get(studentInfoRef);
      const studentInfo = studentSnapshot.exists() ? studentSnapshot.val() : {};
      
      // Convert courses to enrollments format
      for (const [courseId, courseData] of Object.entries(coursesData)) {
        // Get course details
        const courseRef = ref(db, `courses/${courseId}`);
        const courseSnapshot = await get(courseRef);
        const courseInfo = courseSnapshot.exists() ? courseSnapshot.val() : {};
        
        enrollments.push({
          studentId: studentInfo.studentId || '',
          studentName: studentInfo.studentName || '',
          email: email,
          studyMode: studentInfo.studyMode || '',
          major: studentInfo.major || '',
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
    }
    
    return [];
  } catch (error) {
    console.error('Error fetching enrollments:', error);
    return [];
  }
};

export const fetchStudentInfo = async (email: string) => {
  try {
    const emailKey = emailToFirebaseKey(email);
    const studentRef = ref(db, `students/${emailKey}`);
    const snapshot = await get(studentRef);
    
    if (snapshot.exists()) {
      return snapshot.val();
    }
    return null;
  } catch (error) {
    console.error('Error fetching student info:', error);
    return null;
  }
};
