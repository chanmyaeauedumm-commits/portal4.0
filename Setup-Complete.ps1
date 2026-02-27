# ============================================================================
# THE ONE SCRIPT - COMPLETE SCHOOL PORTAL SETUP
# With your REAL Firebase data and simple email login
# ============================================================================

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     THE ONE SCRIPT - AUY SCHOOL PORTAL COMPLETE SETUP                      ║" -ForegroundColor Cyan
Write-Host "║              Simple Email Login + Your 54 Real Students                    ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# YOUR ACTUAL FIREBASE CONFIGURATION
# ============================================================================
$FIREBASE_CONFIG = @{
    apiKey = "AIzaSyDMaoB6mOKYJOkDGwCmliz0azqtJifbwpY"
    authDomain = "auy-portal-v2.firebaseapp.com"
    databaseURL = "https://auy-portal-v2-default-rtdb.asia-southeast1.firebasedatabase.app"
    projectId = "auy-portal-v2"
    storageBucket = "auy-portal-v2.firebasestorage.app"
    messagingSenderId = "1092101561903"
    appId = "1:1092101561903:web:07abc804196ff95bc2f0da"
}

$ADMIN_PASSWORD = "admin123"

# ============================================================================
# STEP 1: CREATE DIRECTORY STRUCTURE
# ============================================================================
Write-Host ""
Write-Host "📁 STEP 1: Creating directory structure..." -ForegroundColor Yellow

$directories = @(
    "src/lib",
    "src/contexts",
    "src/pages",
    "src/components",
    "src/data",
    "src/types",
    "src/utils"
)

foreach ($dir in $directories) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "  Created: $dir" -ForegroundColor Gray
    }
}

# ============================================================================
# STEP 2: FIX THE BUILD ERROR IN DATACONTEXT.TSX
# ============================================================================
Write-Host ""
Write-Host "🔧 STEP 2: Fixing build error in DataContext.tsx..." -ForegroundColor Yellow

$dataContextPath = "src/contexts/DataContext.tsx"
if (Test-Path $dataContextPath) {
    $content = Get-Content $dataContextPath -Raw
    # Fix the specific line with missing quotes
    $fixed = $content -replace "ref\(db,\s*students/\);", 'ref(db, "students/");'
    $fixed | Set-Content $dataContextPath -Encoding UTF8
    Write-Host "✅ Fixed DataContext.tsx - Added quotes around 'students/'" -ForegroundColor Green
} else {
    Write-Host "ℹ️ DataContext.tsx not found - will create it with proper code" -ForegroundColor Yellow
}

# ============================================================================
# STEP 3: CREATE FIREBASE CONFIG WITH YOUR ACTUAL KEYS
# ============================================================================
Write-Host ""
Write-Host "🔥 STEP 3: Creating Firebase configuration with your actual keys..." -ForegroundColor Yellow

$firebaseConfigPath = "src/lib/firebase.ts"
$firebaseConfig = @"
// Import the functions you need from the SDKs you need
import { initializeApp } from 'firebase/app';
import { getAuth } from 'firebase/auth';
import { getDatabase } from 'firebase/database';
import { getStorage } from 'firebase/storage';

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "$($FIREBASE_CONFIG.apiKey)",
  authDomain: "$($FIREBASE_CONFIG.authDomain)",
  databaseURL: "$($FIREBASE_CONFIG.databaseURL)",
  projectId: "$($FIREBASE_CONFIG.projectId)",
  storageBucket: "$($FIREBASE_CONFIG.storageBucket)",
  messagingSenderId: "$($FIREBASE_CONFIG.messagingSenderId)",
  appId: "$($FIREBASE_CONFIG.appId)"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
export const db = getDatabase(app);
export const storage = getStorage(app);
export default app;
"@

$firebaseConfig | Set-Content $firebaseConfigPath -Encoding UTF8
Write-Host "✅ Created Firebase config with your actual keys" -ForegroundColor Green

# ============================================================================
# STEP 4: CREATE STUDENT DATA FROM YOUR JSON (ALL 54 STUDENTS)
# ============================================================================
Write-Host ""
Write-Host "📊 STEP 4: Creating student data with ALL 54 students..." -ForegroundColor Yellow

$studentDataPath = "src/data/students.ts"

$studentData = @'
// Auto-generated student data from AUY portal export
// Total Students: 54

export interface Course {
  code: string;
  courseName: string;
  credits: number;
  grade: string;
  attendancePercentage: number;
  teacherName: string;
  googleClassroomLink?: string;
}

export interface Student {
  studentId: string;
  studentName: string;
  email: string;
  major: string;
  studyMode: 'OnCampus' | 'Remote';
  courses: Course[];
}

// Complete student data from your JSON export
export const studentsData = {
  "students": {
    "aung,,,khant,,,phyo,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S001",
      "studentName": "Aung Khant Phyo",
      "email": "aung.khant.phyo@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B", "attendancePercentage": 86, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B-", "attendancePercentage": 95, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A", "attendancePercentage": 87, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A-", "attendancePercentage": 97, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B-", "attendancePercentage": 90, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B-", "attendancePercentage": 90, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "aung,,,khant,,,zaw,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S027",
      "studentName": "Aung Khant Zaw",
      "email": "aung.khant.zaw@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B-", "attendancePercentage": 95, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B", "attendancePercentage": 92, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A", "attendancePercentage": 94, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B+", "attendancePercentage": 96, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A-", "attendancePercentage": 91, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B", "attendancePercentage": 91, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "aung,,,kyaw,,,min,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S028",
      "studentName": "Aung Kyaw Min",
      "email": "aung.kyaw.min@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B-", "attendancePercentage": 86, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B+", "attendancePercentage": 98, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B-", "attendancePercentage": 85, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B+", "attendancePercentage": 92, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B", "attendancePercentage": 85, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B-", "attendancePercentage": 93, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "aung,,,min,,,khant,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S052",
      "studentName": "Aung Min Khant",
      "email": "aung.min.khant@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "Remote",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B+", "attendancePercentage": 85, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A", "attendancePercentage": 86, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A-", "attendancePercentage": 86, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A-", "attendancePercentage": 92, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A", "attendancePercentage": 77, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A", "attendancePercentage": 85, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "aye,,,chan,,,myae,,,aung,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S029",
      "studentName": "Aye Chan Myae Aung",
      "email": "aye.chan.myae.aung@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A-", "attendancePercentage": 89, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B", "attendancePercentage": 93, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B-", "attendancePercentage": 91, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B", "attendancePercentage": 96, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B+", "attendancePercentage": 97, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B+", "attendancePercentage": 90, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "aye,,,chan,,,pyone,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S051",
      "studentName": "Aye Chan Pyone",
      "email": "aye.chan.pyone@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "Remote",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A-", "attendancePercentage": 89, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A-", "attendancePercentage": 80, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A", "attendancePercentage": 88, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B-", "attendancePercentage": 76, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B-", "attendancePercentage": 77, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A", "attendancePercentage": 75, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "chan,,,htet,,,zan,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S016",
      "studentName": "Chan Htet Zan",
      "email": "chan.htet.zan@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B", "attendancePercentage": 98, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B-", "attendancePercentage": 86, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B", "attendancePercentage": 85, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A", "attendancePercentage": 91, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A-", "attendancePercentage": 88, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B+", "attendancePercentage": 90, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "chanmyae,,,au,,,edu,,,mm,,@,,gmail,,,com": {
      "studentId": "S053",
      "studentName": "Chan Myae Testing",
      "email": "chanmyae.au.edu.mm@gmail.com",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A", "attendancePercentage": 96, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B", "attendancePercentage": 85, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A", "attendancePercentage": 95, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A-", "attendancePercentage": 91, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B-", "attendancePercentage": 90, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A", "attendancePercentage": 86, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "eaint,,,myat,,,kyaw,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S030",
      "studentName": "Eaint Myat Kyaw",
      "email": "eaint.myat.kyaw@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A-", "attendancePercentage": 88, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B+", "attendancePercentage": 93, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B-", "attendancePercentage": 92, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A", "attendancePercentage": 91, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B+", "attendancePercentage": 90, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B-", "attendancePercentage": 87, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "en,,,sian,,,piang,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S010",
      "studentName": "En Sian Piang",
      "email": "en.sian.piang@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A", "attendancePercentage": 87, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B-", "attendancePercentage": 90, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B", "attendancePercentage": 96, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B", "attendancePercentage": 95, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A-", "attendancePercentage": 94, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B-", "attendancePercentage": 87, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "hnin,,,wai,,,phyo,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S031",
      "studentName": "Hnin Wai Phyo",
      "email": "hnin.wai.phyo@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A-", "attendancePercentage": 93, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B+", "attendancePercentage": 89, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A", "attendancePercentage": 92, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B", "attendancePercentage": 88, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B+", "attendancePercentage": 88, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A-", "attendancePercentage": 89, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "hninyamoneoo,,,au,,,edu,,@,,gmail,,,com": {
      "studentId": "S054",
      "studentName": "Hnin Yamone Oo",
      "email": "hninyamoneoo.au.edu@gmail.com",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B", "attendancePercentage": 79, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B-", "attendancePercentage": 85, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A-", "attendancePercentage": 90, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B", "attendancePercentage": 77, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B+", "attendancePercentage": 93, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B", "attendancePercentage": 89, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "hpa,,,la,,,hpone,,,ram,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S032",
      "studentName": "Hpa La Hpone Ram",
      "email": "hpa.la.hpone.ram@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A-", "attendancePercentage": 87, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A", "attendancePercentage": 91, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B", "attendancePercentage": 86, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A", "attendancePercentage": 91, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A-", "attendancePercentage": 92, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B", "attendancePercentage": 86, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "hsu,,,eain,,,htet,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S002",
      "studentName": "Hsu Eain Htet",
      "email": "hsu.eain.htet@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A", "attendancePercentage": 91, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B+", "attendancePercentage": 86, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B", "attendancePercentage": 89, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B", "attendancePercentage": 87, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B+", "attendancePercentage": 91, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B+", "attendancePercentage": 93, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "hsu,,,kyal,,,sin,,,zaw,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S011",
      "studentName": "Hsu Kyal Sin Zaw",
      "email": "hsu.kyal.sin.zaw@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B-", "attendancePercentage": 90, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A", "attendancePercentage": 98, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B-", "attendancePercentage": 98, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B-", "attendancePercentage": 87, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A", "attendancePercentage": 91, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A", "attendancePercentage": 87, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "hsu,,,pyae,,,la,,,min,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S033",
      "studentName": "Hsu Pyae La Min",
      "email": "hsu.pyae.la.min@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A-", "attendancePercentage": 96, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B+", "attendancePercentage": 85, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A-", "attendancePercentage": 94, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B", "attendancePercentage": 85, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B+", "attendancePercentage": 96, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A-", "attendancePercentage": 91, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "htoo,,,yadanar,,,oo,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S003",
      "studentName": "Htoo Yadanar Oo",
      "email": "htoo.yadanar.oo@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A", "attendancePercentage": 88, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B+", "attendancePercentage": 91, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A-", "attendancePercentage": 90, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B+", "attendancePercentage": 87, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B+", "attendancePercentage": 94, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A", "attendancePercentage": 93, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "htut,,,khaung,,,oo,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S047",
      "studentName": "Htut Khaung Oo",
      "email": "htut.khaung.oo@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "Remote",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B+", "attendancePercentage": 80, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B", "attendancePercentage": 80, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A", "attendancePercentage": 82, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B-", "attendancePercentage": 87, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B", "attendancePercentage": 92, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B-", "attendancePercentage": 85, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "indira,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S034",
      "studentName": "Indira",
      "email": "indira@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A", "attendancePercentage": 92, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B-", "attendancePercentage": 91, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A", "attendancePercentage": 98, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B", "attendancePercentage": 86, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A", "attendancePercentage": 97, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B+", "attendancePercentage": 94, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "jbthaw,,@,,gmail,,,com": {
      "studentId": "S054",
      "studentName": "jbthaw",
      "email": "jbthaw@gmail.com",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A", "attendancePercentage": 0, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B", "attendancePercentage": 0, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A", "attendancePercentage": 0, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A-", "attendancePercentage": 0, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B-", "attendancePercentage": 0, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A", "attendancePercentage": 0, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "jinochan1991,,@,,gmail,,,com": {
      "studentId": "S053",
      "studentName": "Jino Chan",
      "email": "jinochan1991@gmail.com",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A-", "attendancePercentage": 95, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B+", "attendancePercentage": 88, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A", "attendancePercentage": 91, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B", "attendancePercentage": 82, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B+", "attendancePercentage": 97, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A-", "attendancePercentage": 94, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "kaung,,,khant,,,kyaw,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S012",
      "studentName": "Kaung Khant Kyaw",
      "email": "kaung.khant.kyaw@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A", "attendancePercentage": 87, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B+", "attendancePercentage": 87, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A", "attendancePercentage": 88, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A", "attendancePercentage": 98, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A", "attendancePercentage": 89, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B-", "attendancePercentage": 89, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "kaung,,,nyan,,,lin,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S019",
      "studentName": "Kaung Nyan Lin",
      "email": "kaung.nyan.lin@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B+", "attendancePercentage": 87, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B", "attendancePercentage": 95, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B-", "attendancePercentage": 86, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A", "attendancePercentage": 91, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B+", "attendancePercentage": 90, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A-", "attendancePercentage": 90, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "kaung,,,pyae,,,phyo,,,kyaw,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S004",
      "studentName": "Kaung Pyae Phyo Kyaw",
      "email": "kaung.pyae.phyo.kyaw@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A", "attendancePercentage": 94, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B", "attendancePercentage": 87, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B", "attendancePercentage": 89, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B+", "attendancePercentage": 91, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B", "attendancePercentage": 92, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B+", "attendancePercentage": 85, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "l,,,seng,,,rail,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S021",
      "studentName": "L Seng Rail",
      "email": "l.seng.rail@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B+", "attendancePercentage": 90, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B-", "attendancePercentage": 93, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A-", "attendancePercentage": 93, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A-", "attendancePercentage": 85, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B", "attendancePercentage": 94, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B", "attendancePercentage": 94, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "la,,,mye,,,gyung,,,naw,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S035",
      "studentName": "La Mye Gyung Naw",
      "email": "la.mye.gyung.naw@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A", "attendancePercentage": 90, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A", "attendancePercentage": 93, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A-", "attendancePercentage": 94, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B-", "attendancePercentage": 88, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B-", "attendancePercentage": 90, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A-", "attendancePercentage": 87, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "la,,,pyae,,,chit,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S036",
      "studentName": "La Pyae Chit",
      "email": "la.pyae.chit@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B", "attendancePercentage": 93, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A-", "attendancePercentage": 90, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B-", "attendancePercentage": 87, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B-", "attendancePercentage": 96, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B+", "attendancePercentage": 85, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B", "attendancePercentage": 95, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "lin,,,sandar,,,kyaw,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S037",
      "studentName": "Lin Sandar Kyaw",
      "email": "lin.sandar.kyaw@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B", "attendancePercentage": 97, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A", "attendancePercentage": 93, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A", "attendancePercentage": 96, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B+", "attendancePercentage": 90, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B-", "attendancePercentage": 98, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A-", "attendancePercentage": 89, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "man,,,sian,,,hoih,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S005",
      "studentName": "Man Sian Hoih",
      "email": "man.sian.hoih@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B-", "attendancePercentage": 93, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B-", "attendancePercentage": 89, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A-", "attendancePercentage": 96, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B", "attendancePercentage": 94, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B", "attendancePercentage": 91, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B", "attendancePercentage": 95, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "may,,,lin,,,phyu,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S013",
      "studentName": "May Lin Phyu",
      "email": "may.lin.phyu@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A-", "attendancePercentage": 98, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A-", "attendancePercentage": 95, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B+", "attendancePercentage": 87, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B", "attendancePercentage": 96, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A", "attendancePercentage": 96, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A", "attendancePercentage": 92, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "min,,,hein,,,khant,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S022",
      "studentName": "Min Hein Khant",
      "email": "min.hein.khant@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A", "attendancePercentage": 87, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A", "attendancePercentage": 98, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B-", "attendancePercentage": 88, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A-", "attendancePercentage": 86, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A-", "attendancePercentage": 90, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A", "attendancePercentage": 91, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "min,,,hein,,,kyaw,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S014",
      "studentName": "Min Hein Kyaw",
      "email": "min.hein.kyaw@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B+", "attendancePercentage": 89, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B", "attendancePercentage": 88, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A", "attendancePercentage": 85, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A", "attendancePercentage": 98, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A", "attendancePercentage": 95, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B", "attendancePercentage": 97, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "min,,,thiha,,,kyaw,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S038",
      "studentName": "Min Thiha Kyaw",
      "email": "min.thiha.kyaw@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A", "attendancePercentage": 88, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A", "attendancePercentage": 87, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A-", "attendancePercentage": 89, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B-", "attendancePercentage": 97, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B-", "attendancePercentage": 87, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B", "attendancePercentage": 90, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "mung,,,hkawng,,,la,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S048",
      "studentName": "Mung Hkawng La",
      "email": "mung.hkawng.la@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "Remote",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B", "attendancePercentage": 77, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B+", "attendancePercentage": 91, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B+", "attendancePercentage": 86, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B-", "attendancePercentage": 89, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A", "attendancePercentage": 80, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A", "attendancePercentage": 85, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "mya,,,hmue,,,may,,,zaw,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S018",
      "studentName": "Mya Hmue May Zaw",
      "email": "mya.hmue.may.zaw@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B", "attendancePercentage": 88, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A", "attendancePercentage": 92, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B+", "attendancePercentage": 93, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A", "attendancePercentage": 85, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B-", "attendancePercentage": 85, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B", "attendancePercentage": 97, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "myat,,,thiri,,,kyaw,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S050",
      "studentName": "Myat Thiri Kyaw",
      "email": "myat.thiri.kyaw@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "Remote",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B-", "attendancePercentage": 91, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A-", "attendancePercentage": 90, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B", "attendancePercentage": 89, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A-", "attendancePercentage": 78, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B-", "attendancePercentage": 88, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B-", "attendancePercentage": 84, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "nan,,,moe,,,nwe,,,oo,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S039",
      "studentName": "Nan Moe Nwe Oo",
      "email": "nan.moe.nwe.oo@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A", "attendancePercentage": 94, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B-", "attendancePercentage": 94, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A", "attendancePercentage": 87, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A", "attendancePercentage": 89, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B", "attendancePercentage": 92, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B", "attendancePercentage": 87, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "nlang,,,seng,,,htoi,,,pan,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S040",
      "studentName": "Nlang Seng Htoi Pan",
      "email": "nlang.seng.htoi.pan@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B", "attendancePercentage": 98, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B+", "attendancePercentage": 85, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A-", "attendancePercentage": 90, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A-", "attendancePercentage": 86, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B-", "attendancePercentage": 93, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B+", "attendancePercentage": 85, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "nlang,,,seng,,,myo,,,myat,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S041",
      "studentName": "Nlang Seng Myo Myat",
      "email": "nlang.seng.myo.myat@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B+", "attendancePercentage": 96, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A-", "attendancePercentage": 86, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A-", "attendancePercentage": 87, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B-", "attendancePercentage": 91, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B", "attendancePercentage": 91, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B", "attendancePercentage": 94, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "phone,,,pyae,,,han,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S006",
      "studentName": "Phone Pyae Han",
      "email": "phone.pyae.han@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B+", "attendancePercentage": 87, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B-", "attendancePercentage": 86, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B+", "attendancePercentage": 98, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B-", "attendancePercentage": 85, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B-", "attendancePercentage": 88, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B", "attendancePercentage": 91, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "shoon,,,lae,,,aung,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S042",
      "studentName": "Shoon Lae Aung",
      "email": "shoon.lae.aung@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B-", "attendancePercentage": 96, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A-", "attendancePercentage": 95, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B-", "attendancePercentage": 85, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B", "attendancePercentage": 89, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B", "attendancePercentage": 87, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B+", "attendancePercentage": 90, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "sian,,,san,,,nuam,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S024",
      "studentName": "Sian San Nuam",
      "email": "sian.san.nuam@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B-", "attendancePercentage": 86, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A", "attendancePercentage": 96, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B+", "attendancePercentage": 92, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B-", "attendancePercentage": 86, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B-", "attendancePercentage": 86, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B", "attendancePercentage": 88, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "su,,,pyae,,,than,,,dar,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S043",
      "studentName": "Su Pyae Than Dar",
      "email": "su.pyae.than.dar@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B", "attendancePercentage": 91, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A", "attendancePercentage": 96, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A", "attendancePercentage": 96, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B+", "attendancePercentage": 85, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B-", "attendancePercentage": 87, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B+", "attendancePercentage": 87, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "swan,,,sa,,,phyo,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S017",
      "studentName": "Swan Sa Phyo",
      "email": "swan.sa.phyo@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B-", "attendancePercentage": 89, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B+", "attendancePercentage": 96, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B-", "attendancePercentage": 89, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A", "attendancePercentage": 94, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A", "attendancePercentage": 96, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A-", "attendancePercentage": 96, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "thaw,,,thaw,,,zin,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S020",
      "studentName": "Thaw Thaw Zin",
      "email": "thaw.thaw.zin@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B+", "attendancePercentage": 95, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A-", "attendancePercentage": 95, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A-", "attendancePercentage": 93, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A-", "attendancePercentage": 91, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B", "attendancePercentage": 88, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A", "attendancePercentage": 97, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "thawdar,,,shoon,,,lei,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S023",
      "studentName": "Thawdar Shoon Lei",
      "email": "thawdar.shoon.lei@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A-", "attendancePercentage": 93, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "A-", "attendancePercentage": 85, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B", "attendancePercentage": 89, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B-", "attendancePercentage": 92, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B-", "attendancePercentage": 86, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A", "attendancePercentage": 92, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "thet,,,hayman,,,kyaw,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S026",
      "studentName": "Thet Hayman Kyaw",
      "email": "thet.hayman.kyaw@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A", "attendancePercentage": 86, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B-", "attendancePercentage": 87, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A-", "attendancePercentage": 87, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B+", "attendancePercentage": 93, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B+", "attendancePercentage": 96, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B", "attendancePercentage": 96, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "thet,,,mon,,,chit,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S049",
      "studentName": "Thet Mon Chit",
      "email": "thet.mon.chit@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "Remote",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B-", "attendancePercentage": 90, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B-", "attendancePercentage": 75, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B-", "attendancePercentage": 76, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B-", "attendancePercentage": 76, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B", "attendancePercentage": 87, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B", "attendancePercentage": 76, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "thin,,,thin,,,aung,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S044",
      "studentName": "Thin Thin Aung",
      "email": "thin.thin.aung@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A", "attendancePercentage": 93, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B-", "attendancePercentage": 98, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A-", "attendancePercentage": 97, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B+", "attendancePercentage": 87, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B-", "attendancePercentage": 97, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A", "attendancePercentage": 97, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "thin,,,zar,,,li,,,htay,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S007",
      "studentName": "Thin Zar Li Htay",
      "email": "thin.zar.li.htay@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B", "attendancePercentage": 95, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B+", "attendancePercentage": 90, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A-", "attendancePercentage": 94, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B-", "attendancePercentage": 94, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A-", "attendancePercentage": 87, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B-", "attendancePercentage": 91, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "thint,,,myat,,,aung,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S015",
      "studentName": "Thint Myat Aung",
      "email": "thint.myat.aung@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A-", "attendancePercentage": 94, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B", "attendancePercentage": 92, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A-", "attendancePercentage": 92, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B-", "attendancePercentage": 94, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A-", "attendancePercentage": 94, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B+", "attendancePercentage": 93, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "thiri,,,thansin,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S045",
      "studentName": "Thiri Thansin",
      "email": "thiri.thansin@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B+", "attendancePercentage": 90, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B", "attendancePercentage": 95, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B+", "attendancePercentage": 88, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B+", "attendancePercentage": 94, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A-", "attendancePercentage": 94, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B-", "attendancePercentage": 85, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "yatanar,,,moe,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S046",
      "studentName": "Yatanar Moe",
      "email": "yatanar.moe@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B-", "attendancePercentage": 88, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B-", "attendancePercentage": 91, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A-", "attendancePercentage": 97, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B-", "attendancePercentage": 92, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A", "attendancePercentage": 91, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B+", "attendancePercentage": 87, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "yoon,,,thiri,,,naing,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S008",
      "studentName": "Yoon Thiri Naing",
      "email": "yoon.thiri.naing@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B-", "attendancePercentage": 89, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B", "attendancePercentage": 85, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B", "attendancePercentage": 91, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B-", "attendancePercentage": 86, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "A", "attendancePercentage": 89, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B", "attendancePercentage": 94, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "zau,,,myu,,,lat,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S009",
      "studentName": "Zau Myu Lat",
      "email": "zau.myu.lat@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "B-", "attendancePercentage": 98, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B", "attendancePercentage": 98, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "A", "attendancePercentage": 94, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "A", "attendancePercentage": 91, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B", "attendancePercentage": 94, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "B+", "attendancePercentage": 96, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    },
    "zaw,,,seng,,,awng,,@,,student,,,au,,,edu,,,mm": {
      "studentId": "S025",
      "studentName": "Zaw Seng Awng",
      "email": "zaw.seng.awng@student.au.edu.mm",
      "major": "ISP program",
      "studyMode": "OnCampus",
      "courses": {
        "BUS101": { "courseName": "Introduction to Business", "credits": 3, "grade": "A", "attendancePercentage": 90, "teacherName": "Prof. Johnson", "googleClassroomLink": "https://classroom.google.com/" },
        "ENG101": { "courseName": "English Composition", "credits": 3, "grade": "B-", "attendancePercentage": 95, "teacherName": "Dr. Smith", "googleClassroomLink": "https://classroom.google.com/" },
        "HUM11": { "courseName": "Humanities", "credits": 3, "grade": "B+", "attendancePercentage": 97, "teacherName": "Prof. Green", "googleClassroomLink": "https://classroom.google.com/" },
        "IT101": { "courseName": "Computer Fundamentals", "credits": 3, "grade": "B", "attendancePercentage": 95, "teacherName": "Dr. Brown", "googleClassroomLink": "https://classroom.google.com/" },
        "MATH101": { "courseName": "College Mathematics", "credits": 3, "grade": "B-", "attendancePercentage": 96, "teacherName": "Prof. Lee", "googleClassroomLink": "https://classroom.google.com/" },
        "STAT100": { "courseName": "Statistics", "credits": 3, "grade": "A", "attendancePercentage": 91, "teacherName": "Dr. White", "googleClassroomLink": "https://classroom.google.com/" }
      }
    }
  }
};

// Helper functions
export const getAllStudents = (): Student[] => {
  return Object.values(studentsData.students).map((student: any) => ({
    studentId: student.studentId,
    studentName: student.studentName,
    email: student.email,
    major: student.major,
    studyMode: student.studyMode,
    courses: Object.entries(student.courses || {}).map(([code, data]: [string, any]) => ({
      code,
      courseName: data.courseName,
      credits: data.credits,
      grade: data.grade,
      attendancePercentage: data.attendancePercentage,
      teacherName: data.teacherName,
      googleClassroomLink: data.googleClassroomLink
    }))
  }));
};

export const getStudentByEmail = (email: string): Student | null => {
  const emailKey = email.replace(/\./g, ',,,');
  const student = studentsData.students[emailKey as keyof typeof studentsData.students];
  if (!student) return null;
  
  return {
    studentId: student.studentId,
    studentName: student.studentName,
    email: student.email,
    major: student.major,
    studyMode: student.studyMode,
    courses: Object.entries(student.courses || {}).map(([code, data]: [string, any]) => ({
      code,
      courseName: data.courseName,
      credits: data.credits,
      grade: data.grade,
      attendancePercentage: data.attendancePercentage,
      teacherName: data.teacherName,
      googleClassroomLink: data.googleClassroomLink
    }))
  };
};

export const getStudentById = (id: string): Student | null => {
  const student = Object.values(studentsData.students).find(s => s.studentId === id);
  if (!student) return null;
  
  return {
    studentId: student.studentId,
    studentName: student.studentName,
    email: student.email,
    major: student.major,
    studyMode: student.studyMode,
    courses: Object.entries(student.courses || {}).map(([code, data]: [string, any]) => ({
      code,
      courseName: data.courseName,
      credits: data.credits,
      grade: data.grade,
      attendancePercentage: data.attendancePercentage,
      teacherName: data.teacherName,
      googleClassroomLink: data.googleClassroomLink
    }))
  };
};
'@

$studentData | Set-Content $studentDataPath -Encoding UTF8
Write-Host "✅ Created student data with ALL 54 students!" -ForegroundColor Green

# ============================================================================
# STEP 5: CREATE SIMPLE LOGIN PAGE (EMAIL ONLY)
# ============================================================================
Write-Host ""
Write-Host "🔐 STEP 5: Creating simple email login page..." -ForegroundColor Yellow

$loginPagePath = "src/pages/SimpleLogin.tsx"

$loginPage = @"
import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { getStudentByEmail } from '../data/students';

export default function SimpleLogin() {
  const [email, setEmail] = useState('');
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    // Simulate a small delay for better UX
    setTimeout(() => {
      const student = getStudentByEmail(email);
      
      if (student) {
        // Store student info in localStorage
        localStorage.setItem('currentStudent', JSON.stringify(student));
        navigate('/dashboard');
      } else {
        setError('Email not found. Please use your student email.');
      }
      setLoading(false);
    }, 500);
  };

  // List of sample emails for easy testing
  const sampleEmails = [
    'aung.khant.phyo@student.au.edu.mm',
    'hsu.eain.htet@student.au.edu.mm',
    'htoo.yadanar.oo@student.au.edu.mm',
    'kaung.pyae.phyo.kyaw@student.au.edu.mm',
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-600 to-indigo-800 flex items-center justify-center p-4">
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md p-8">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold text-gray-900 mb-2">AUY Student Portal</h1>
          <p className="text-gray-600">Enter your student email to access your dashboard</p>
        </div>

        <form onSubmit={handleSubmit} className="space-y-6">
          <div>
            <label htmlFor="email" className="block text-sm font-medium text-gray-700 mb-2">
              Student Email
            </label>
            <input
              id="email"
              type="email"
              required
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="your.email@student.au.edu.mm"
              className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
              disabled={loading}
            />
          </div>

          {error && (
            <div className="bg-red-50 text-red-600 p-3 rounded-lg text-sm">
              {error}
            </div>
          )}

          <button
            type="submit"
            disabled={loading}
            className="w-full bg-indigo-600 text-white py-3 rounded-lg font-semibold hover:bg-indigo-700 transition disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {loading ? 'Checking...' : 'Access Dashboard'}
          </button>
        </form>

        <div className="mt-6">
          <p className="text-sm text-gray-500 text-center mb-3">Test with these emails:</p>
          <div className="space-y-2">
            {sampleEmails.map((sampleEmail) => (
              <button
                key={sampleEmail}
                onClick={() => setEmail(sampleEmail)}
                className="w-full text-left text-sm text-indigo-600 hover:text-indigo-800 hover:bg-indigo-50 p-2 rounded transition"
              >
                {sampleEmail}
              </button>
            ))}
          </div>
        </div>

        <div className="mt-6 text-center">
          <a href="/admin" className="text-sm text-gray-400 hover:text-gray-600">
            Admin Login
          </a>
        </div>
      </div>
    </div>
  );
}
"@

$loginPage | Set-Content $loginPagePath -Encoding UTF8
Write-Host "✅ Created SimpleLogin page" -ForegroundColor Green

# ============================================================================
# STEP 6: CREATE STUDENT DASHBOARD
# ============================================================================
Write-Host ""
Write-Host "📊 STEP 6: Creating student dashboard..." -ForegroundColor Yellow

$dashboardPath = "src/pages/StudentDashboard.tsx"

$dashboard = @"
import React, { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { Student } from '../data/students';

export default function StudentDashboard() {
  const [student, setStudent] = useState<Student | null>(null);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    const studentData = localStorage.getItem('currentStudent');
    if (!studentData) {
      navigate('/');
      return;
    }
    setStudent(JSON.parse(studentData));
    setLoading(false);
  }, [navigate]);

  const handleLogout = () => {
    localStorage.removeItem('currentStudent');
    navigate('/');
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-indigo-600"></div>
      </div>
    );
  }

  if (!student) return null;

  // Calculate statistics
  const totalCourses = student.courses.length;
  const averageAttendance = Math.round(
    student.courses.reduce((sum, course) => sum + course.attendancePercentage, 0) / totalCourses
  );
  const gradePoints: { [key: string]: number } = {
    'A': 4.0, 'A-': 3.7, 'B+': 3.3, 'B': 3.0, 'B-': 2.7, 'C+': 2.3, 'C': 2.0, 'C-': 1.7, 'D': 1.0, 'F': 0.0
  };
  const gpa = student.courses.reduce((sum, course) => {
    return sum + (gradePoints[course.grade] || 0);
  }, 0) / totalCourses;

  return (
    <div className="min-h-screen bg-gray-100">
      {/* Header */}
      <div className="bg-white shadow">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
          <div className="flex justify-between items-center">
            <div>
              <h1 className="text-2xl font-bold text-gray-900">Welcome, {student.studentName}!</h1>
              <p className="text-gray-600">{student.studentId} • {student.major} • {student.studyMode}</p>
            </div>
            <button
              onClick={handleLogout}
              className="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition"
            >
              Logout
            </button>
          </div>
        </div>
      </div>

      {/* Stats Cards */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <div className="bg-white rounded-lg shadow p-6">
            <h3 className="text-sm font-medium text-gray-500 uppercase">Total Courses</h3>
            <p className="text-3xl font-bold text-gray-900 mt-2">{totalCourses}</p>
          </div>
          <div className="bg-white rounded-lg shadow p-6">
            <h3 className="text-sm font-medium text-gray-500 uppercase">Average Attendance</h3>
            <p className="text-3xl font-bold text-gray-900 mt-2">{averageAttendance}%</p>
          </div>
          <div className="bg-white rounded-lg shadow p-6">
            <h3 className="text-sm font-medium text-gray-500 uppercase">Current GPA</h3>
            <p className="text-3xl font-bold text-gray-900 mt-2">{gpa.toFixed(2)}</p>
          </div>
        </div>

        {/* Courses Table */}
        <div className="bg-white rounded-lg shadow overflow-hidden">
          <div className="px-6 py-4 border-b border-gray-200">
            <h2 className="text-lg font-semibold text-gray-900">My Courses</h2>
          </div>
          <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200">
              <thead className="bg-gray-50">
                <tr>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Code</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Credits</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Grade</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Attendance</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Teacher</th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Classroom</th>
                </tr>
              </thead>
              <tbody className="bg-white divide-y divide-gray-200">
                {student.courses.map((course) => (
                  <tr key={course.code} className="hover:bg-gray-50">
                    <td className="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                      {course.courseName}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      {course.code}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      {course.credits}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className={\`px-2 py-1 text-xs font-semibold rounded-full \${
                        course.grade.startsWith('A') ? 'bg-green-100 text-green-800' :
                        course.grade.startsWith('B') ? 'bg-blue-100 text-blue-800' :
                        'bg-yellow-100 text-yellow-800'
                      }\`}>
                        {course.grade}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="flex items-center">
                        <span className="text-sm text-gray-900 mr-2">{course.attendancePercentage}%</span>
                        <div className="w-16 bg-gray-200 rounded-full h-2">
                          <div
                            className={\`h-2 rounded-full \${
                              course.attendancePercentage >= 90 ? 'bg-green-600' :
                              course.attendancePercentage >= 80 ? 'bg-yellow-600' :
                              'bg-red-600'
                            }\`}
                            style={{ width: \`\${course.attendancePercentage}%\` }}
                          ></div>
                        </div>
                      </div>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                      {course.teacherName}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-sm">
                      <a
                        href={course.googleClassroomLink}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="text-indigo-600 hover:text-indigo-900"
                      >
                        Open
                      </a>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  );
}
"@

$dashboard | Set-Content $dashboardPath -Encoding UTF8
Write-Host "✅ Created StudentDashboard page" -ForegroundColor Green

# ============================================================================
# STEP 7: CREATE APP.TSX WITH ROUTES
# ============================================================================
Write-Host ""
Write-Host "🔄 STEP 7: Creating App.tsx with routes..." -ForegroundColor Yellow

$appPath = "src/App.tsx"

$appContent = @'
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import SimpleLogin from './pages/SimpleLogin';
import StudentDashboard from './pages/StudentDashboard';
import OneAdmin from './pages/OneAdmin';

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<SimpleLogin />} />
        <Route path="/dashboard" element={<StudentDashboard />} />
        <Route path="/admin" element={<OneAdmin />} />
        <Route path="*" element={<Navigate to="/" replace />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
'@

$appContent | Set-Content $appPath -Encoding UTF8
Write-Host "✅ Created App.tsx with routes" -ForegroundColor Green

# ============================================================================
# STEP 8: CREATE MAIN.TSX
# ============================================================================
Write-Host ""
Write-Host "🎯 STEP 8: Creating main.tsx..." -ForegroundColor Yellow

$mainPath = "src/main.tsx"

$mainContent = @'
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import './index.css'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)
'@

$mainContent | Set-Content $mainPath -Encoding UTF8
Write-Host "✅ Created main.tsx" -ForegroundColor Green

# ============================================================================
# STEP 9: CREATE INDEX.CSS WITH TAILWIND
# ============================================================================
Write-Host ""
Write-Host "🎨 STEP 9: Creating index.css with Tailwind..." -ForegroundColor Yellow

$cssPath = "src/index.css"

$cssContent = @'
@import "tailwindcss";

body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

code {
  font-family: source-code-pro, Menlo, Monaco, Consolas, 'Courier New',
    monospace;
}
'@

$cssContent | Set-Content $cssPath -Encoding UTF8
Write-Host "✅ Created index.css" -ForegroundColor Green

# ============================================================================
# STEP 10: UPDATE PACKAGE.JSON WITH DEV COMMAND
# ============================================================================
Write-Host ""
Write-Host "📦 STEP 10: Updating package.json..." -ForegroundColor Yellow

$packagePath = "package.json"
if (Test-Path $packagePath) {
    $packageJson = Get-Content $packagePath -Raw | ConvertFrom-Json
    
    # Update scripts
    $packageJson.scripts = @{
        dev = "vite"
        build = "vite build"
        preview = "vite preview"
    }
    
    $packageJson | ConvertTo-Json -Depth 10 | Set-Content $packagePath -Encoding UTF8
    Write-Host "✅ Updated package.json scripts" -ForegroundColor Green
}

# ============================================================================
# FINAL SUMMARY
# ============================================================================
Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║                    SETUP COMPLETE! 🎉                                      ║" -ForegroundColor Cyan
Write-Host "╠════════════════════════════════════════════════════════════════════════════╣" -ForegroundColor Cyan
Write-Host "║                                                                             ║" -ForegroundColor Cyan
Write-Host "║  ✅ Fixed build error in DataContext.tsx                                    ║" -ForegroundColor Green
Write-Host "║  ✅ Created Firebase config with your actual keys                           ║" -ForegroundColor Green
Write-Host "║  ✅ Added ALL 54 students from your JSON                                    ║" -ForegroundColor Green
Write-Host "║  ✅ Created Simple Login page (email only!)                                 ║" -ForegroundColor Green
Write-Host "║  ✅ Created Student Dashboard with real data                                ║" -ForegroundColor Green
Write-Host "║  ✅ Set up routing in App.tsx                                               ║" -ForegroundColor Green
Write-Host "║                                                                             ║" -ForegroundColor Cyan
Write-Host "╠════════════════════════════════════════════════════════════════════════════╣" -ForegroundColor Cyan
Write-Host "║                                                                             ║" -ForegroundColor Cyan
Write-Host "║  🚀 NEXT STEPS:                                                             ║" -ForegroundColor Yellow
Write-Host "║  1. Run: npm install (if you haven't already)                               ║" -ForegroundColor White
Write-Host "║  2. Run: npm run dev                                                        ║" -ForegroundColor White
Write-Host "║  3. Open: http://localhost:5173                                             ║" -ForegroundColor White
Write-Host "║  4. Login with any student email from the list                              ║" -ForegroundColor White
Write-Host "║  5. Admin panel: http://localhost:5173/admin (password: admin123)           ║" -ForegroundColor White
Write-Host "║                                                                             ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

Write-Host "✨ YOUR AUY PORTAL IS READY! Simple email login with 54 real students! ✨" -ForegroundColor Magenta
Write-Host ""