// Portal Data Service - Provides student data with fallback

export interface Enrollment {
  enrollmentId: string;
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

// Fallback data from your CSV
export const fallbackEnrollments: Enrollment[] = [
  {
    enrollmentId: "ENR00001",
    studentId: "S001",
    studentName: "Aung Khant Phyo",
    email: "aung.khant.phyo@student.au.edu.mm",
    studyMode: "OnCampus",
    major: "ISP program",
    courseId: "BUS101",
    courseName: "Introduction to Business",
    teacherName: "Prof. Johnson",
    credits: 3,
    grade: "B",
    googleClassroomLink: "https://classroom.google.com/",
    attendancePercentage: 86,
    lastUpdated: "2026-02-22"
  },
  {
    enrollmentId: "ENR00002",
    studentId: "S001",
    studentName: "Aung Khant Phyo",
    email: "aung.khant.phyo@student.au.edu.mm",
    studyMode: "OnCampus",
    major: "ISP program",
    courseId: "ENG101",
    courseName: "English Composition",
    teacherName: "Dr. Smith",
    credits: 3,
    grade: "B-",
    googleClassroomLink: "https://classroom.google.com/",
    attendancePercentage: 95,
    lastUpdated: "2026-02-22"
  },
  {
    enrollmentId: "ENR00003",
    studentId: "S001",
    studentName: "Aung Khant Phyo",
    email: "aung.khant.phyo@student.au.edu.mm",
    studyMode: "OnCampus",
    major: "ISP program",
    courseId: "HUM11",
    courseName: "Humanities",
    teacherName: "Prof. Green",
    credits: 3,
    grade: "A",
    googleClassroomLink: "https://classroom.google.com/",
    attendancePercentage: 87,
    lastUpdated: "2026-02-22"
  },
  {
    enrollmentId: "ENR00004",
    studentId: "S001",
    studentName: "Aung Khant Phyo",
    email: "aung.khant.phyo@student.au.edu.mm",
    studyMode: "OnCampus",
    major: "ISP program",
    courseId: "IT101",
    courseName: "Computer Fundamentals",
    teacherName: "Dr. Brown",
    credits: 3,
    grade: "A-",
    googleClassroomLink: "https://classroom.google.com/",
    attendancePercentage: 97,
    lastUpdated: "2026-02-22"
  },
  {
    enrollmentId: "ENR00005",
    studentId: "S001",
    studentName: "Aung Khant Phyo",
    email: "aung.khant.phyo@student.au.edu.mm",
    studyMode: "OnCampus",
    major: "ISP program",
    courseId: "MATH101",
    courseName: "College Mathematics",
    teacherName: "Prof. Lee",
    credits: 3,
    grade: "B-",
    googleClassroomLink: "https://classroom.google.com/",
    attendancePercentage: 90,
    lastUpdated: "2026-02-22"
  },
  {
    enrollmentId: "ENR00006",
    studentId: "S001",
    studentName: "Aung Khant Phyo",
    email: "aung.khant.phyo@student.au.edu.mm",
    studyMode: "OnCampus",
    major: "ISP program",
    courseId: "STAT100",
    courseName: "Statistics",
    teacherName: "Dr. White",
    credits: 3,
    grade: "B-",
    googleClassroomLink: "https://classroom.google.com/",
    attendancePercentage: 90,
    lastUpdated: "2026-02-22"
  },
  {
    enrollmentId: "ENR00007",
    studentId: "S002",
    studentName: "Hsu Eain Htet",
    email: "hsu.eain.htet@student.au.edu.mm",
    studyMode: "OnCampus",
    major: "ISP program",
    courseId: "BUS101",
    courseName: "Introduction to Business",
    teacherName: "Prof. Johnson",
    credits: 3,
    grade: "A",
    googleClassroomLink: "https://classroom.google.com/",
    attendancePercentage: 91,
    lastUpdated: "2026-02-22"
  },
  {
    enrollmentId: "ENR00008",
    studentId: "S002",
    studentName: "Hsu Eain Htet",
    email: "hsu.eain.htet@student.au.edu.mm",
    studyMode: "OnCampus",
    major: "ISP program",
    courseId: "ENG101",
    courseName: "English Composition",
    teacherName: "Dr. Smith",
    credits: 3,
    grade: "B+",
    googleClassroomLink: "https://classroom.google.com/",
    attendancePercentage: 86,
    lastUpdated: "2026-02-22"
  },
  {
    enrollmentId: "ENR00009",
    studentId: "S002",
    studentName: "Hsu Eain Htet",
    email: "hsu.eain.htet@student.au.edu.mm",
    studyMode: "OnCampus",
    major: "ISP program",
    courseId: "HUM11",
    courseName: "Humanities",
    teacherName: "Prof. Green",
    credits: 3,
    grade: "B",
    googleClassroomLink: "https://classroom.google.com/",
    attendancePercentage: 89,
    lastUpdated: "2026-02-22"
  },
  {
    enrollmentId: "ENR00010",
    studentId: "S002",
    studentName: "Hsu Eain Htet",
    email: "hsu.eain.htet@student.au.edu.mm",
    studyMode: "OnCampus",
    major: "ISP program",
    courseId: "IT101",
    courseName: "Computer Fundamentals",
    teacherName: "Dr. Brown",
    credits: 3,
    grade: "B",
    googleClassroomLink: "https://classroom.google.com/",
    attendancePercentage: 87,
    lastUpdated: "2026-02-22"
  }
];

// Helper functions
export async function getStudentEnrollmentsWithFallback(email: string): Promise<Enrollment[]> {
  // For now, return filtered fallback data
  return fallbackEnrollments.filter(e => e.email.toLowerCase() === email.toLowerCase());
}

export async function getStudentWithFallback(email: string): Promise<any> {
  const enrollment = fallbackEnrollments.find(e => e.email.toLowerCase() === email.toLowerCase());
  if (enrollment) {
    return {
      name: enrollment.studentName,
      id: enrollment.studentId,
      email: enrollment.email,
      major: enrollment.major,
      studyMode: enrollment.studyMode
    };
  }
  return null;
}

export function getStudentStats(enrollments: Enrollment[]) {
  const totalCourses = enrollments.length;
  const avgAttendance = Math.round(
    enrollments.reduce((sum, e) => sum + (e.attendancePercentage || 0), 0) / (totalCourses || 1)
  );
  
  const gradePoints: { [key: string]: number } = {
    'A': 4.0, 'A-': 3.7, 'B+': 3.3, 'B': 3.0, 'B-': 2.7,
    'C+': 2.3, 'C': 2.0, 'C-': 1.7, 'D': 1.0, 'F': 0.0
  };
  
  const gpa = enrollments.reduce((sum, e) => sum + (gradePoints[e.grade] || 0), 0) / (totalCourses || 1);
  
  return { totalCourses, avgAttendance, gpa };
}
