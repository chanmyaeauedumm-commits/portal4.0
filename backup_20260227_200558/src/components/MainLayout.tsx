import React from 'react';
import { useNavigate } from 'react-router-dom';
import Sidebar from './Sidebar';

interface MainLayoutProps {
  children: React.ReactNode;
}

const MainLayout = ({ children }: MainLayoutProps) => {
  const navigate = useNavigate();

  const handleLogout = () => {
    localStorage.removeItem('studentEmail');
    navigate('/');
  };

  return (
    <div style={{ display: 'flex', minHeight: '100vh' }}>
      <Sidebar onLogout={handleLogout} />
      <main className="main-content">
        {children}
      </main>
    </div>
  );
};

export default MainLayout;
