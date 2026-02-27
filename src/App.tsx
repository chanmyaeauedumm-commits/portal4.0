import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider } from './contexts/AuthContext';
import { DataProvider } from './contexts/DataContext';
import SimpleLogin from './pages/SimpleLogin';
import MainLayout from './components/MainLayout';
import { Welcome } from './pages/Welcome';
import { Courses } from './pages/Courses';
import { Grades } from './pages/Grades';
import { Attendance } from './pages/Attendance';
import { Exams } from './pages/Exams';
import { Announcements } from './pages/Announcements';

function App() {
  return (
    <BrowserRouter>
      <AuthProvider>
        <DataProvider>
          <Routes>
            <Route path="/" element={<SimpleLogin />} />
            <Route path="/dashboard" element={
              <MainLayout>
                <Welcome />
              </MainLayout>
            } />
            <Route path="/courses" element={
              <MainLayout>
                <Courses />
              </MainLayout>
            } />
            <Route path="/grades" element={
              <MainLayout>
                <Grades />
              </MainLayout>
            } />
            <Route path="/attendance" element={
              <MainLayout>
                <Attendance />
              </MainLayout>
            } />
            <Route path="/exams" element={
              <MainLayout>
                <Exams />
              </MainLayout>
            } />
            <Route path="/announcements" element={
              <MainLayout>
                <Announcements />
              </MainLayout>
            } />
            <Route path="*" element={<Navigate to="/" replace />} />
          </Routes>
        </DataProvider>
      </AuthProvider>
    </BrowserRouter>
  );
}

export default App;
