# AUY Student Portal Schema - Email as Reference
# ZenStack with Firebase Realtime Database

type User @table {
  // Using email as the primary identifier
  email: String! @unique
  displayName: String!
  studentId: String @unique
  userType: String! @default(value: "student")  // "student" or "admin"
  major: String
  studyMode: String  // "OnCampus" or "Remote"
  photoUrl: String
  createdAt: Timestamp! @default(now())
  lastLogin: Timestamp
  
  // Relations
  enrollments Enrollment[] @relation(name: "studentEnrollments")
  submissions Submission[] @relation(name: "studentSubmissions")
  taughtCourses Course[] @relation(name: "instructorCourses")  // for instructors
}

type Course @table {
  courseCode: String! @unique
  title: String!
  description: String
  credits: Int! @default(value: 3)
  instructorEmail: String!  // Reference by email
  semester: String!  // e.g., "Fall 2024"
  year: Int!
  googleClassroomLink: String
  createdAt: Timestamp! @default(now())
  
  // Relations
  instructor User @relation(name: "instructorCourses", fields: [instructorEmail], references: [email])
  enrollments Enrollment[] @relation(name: "courseEnrollments")
  assignments Assignment[] @relation(name: "courseAssignments")
}

type Enrollment @table(key: ["studentEmail", "courseCode"]) {
  studentEmail: String!  // Reference by email
  courseCode: String!    // Reference by course code
  enrollmentDate: Date! @default(now())
  createdAt: Timestamp! @default(now())
  finalGrade: String     // Letter grade: A, B+, etc.
  attendancePercentage: Float
  
  // Relations
  student User @relation(name: "studentEnrollments", fields: [studentEmail], references: [email])
  course Course @relation(name: "courseEnrollments", fields: [courseCode], references: [courseCode])
}

type Assignment @table {
  courseCode: String!  // Reference by course code
  title: String!
  description: String
  dueDate: Timestamp!
  maxPoints: Int! @default(value: 100)
  weight: Float        // Percentage of final grade
  createdAt: Timestamp! @default(now())
  submissionInstructions: String
  
  // Relations
  course Course @relation(name: "courseAssignments", fields: [courseCode], references: [courseCode])
  submissions Submission[] @relation(name: "assignmentSubmissions")
}

type Submission @table(key: ["studentEmail", "assignmentId"]) {
  studentEmail: String!      // Reference by email
  assignmentId: String!      // Reference by assignment ID
  submissionDate: Timestamp! @default(now())
  createdAt: Timestamp! @default(now())
  grade: Float               // Points received
  feedback: String
  submissionContentUrl: String
  status: String @default(value: "submitted")  // "submitted", "graded", "late"
  
  // Relations
  student User @relation(name: "studentSubmissions", fields: [studentEmail], references: [email])
  assignment Assignment @relation(name: "assignmentSubmissions", fields: [assignmentId], references: [id])
}

type Announcement @table {
  title: String!
  content: String!
  authorEmail: String!  // Reference by email
  courseCode: String    // Null for global announcements
  createdAt: Timestamp! @default(now())
  updatedAt: Timestamp! @default(now())
  priority: String @default(value: "normal")  // "high", "normal", "low"
  
  // Relations
  author User @relation(name: "authorAnnouncements", fields: [authorEmail], references: [email])
  course Course @relation(name: "courseAnnouncements", fields: [courseCode], references: [courseCode])
}

type GradeCalculation @table {
  studentEmail: String!  // Reference by email
  courseCode: String!    // Reference by course code
  calculatedGPA: Float
  totalPoints: Float
  maxPossiblePoints: Float
  lastUpdated: Timestamp! @default(now())
  
  // Relations
  student User @relation(name: "studentGrades", fields: [studentEmail], references: [email])
  course Course @relation(name: "courseGrades", fields: [courseCode], references: [courseCode])
}