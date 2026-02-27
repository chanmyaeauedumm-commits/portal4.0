import React, { useState } from 'react';
import { Link, useLocation } from 'react-router-dom';
import { 
  Home, 
  BookOpen, 
  GraduationCap, 
  Calendar, 
  Megaphone, 
  FileText,
  LogOut,
  Menu,
  X
} from 'lucide-react';

interface SidebarProps {
  onLogout: () => void;
}

const Sidebar = ({ onLogout }: SidebarProps) => {
  const [isOpen, setIsOpen] = useState(false);
  const location = useLocation();

  const menuItems = [
    { path: '/dashboard', icon: Home, label: 'Welcome' },
    { path: '/courses', icon: BookOpen, label: 'Courses' },
    { path: '/grades', icon: GraduationCap, label: 'Grades' },
    { path: '/attendance', icon: Calendar, label: 'Attendance' },
    { path: '/exams', icon: FileText, label: 'Exams' },
    { path: '/announcements', icon: Megaphone, label: 'Announcements' },
  ];

  const isActive = (path: string) => location.pathname === path;

  return (
    <>
      {/* Mobile Menu Button */}
      <button
        className="mobile-menu-btn"
        onClick={() => setIsOpen(!isOpen)}
        aria-label="Toggle menu"
      >
        {isOpen ? <X size={20} /> : <Menu size={20} />}
      </button>

      {/* Sidebar */}
      <div className={`sidebar ${isOpen ? 'open' : ''}`}>
        {/* Logo Area */}
        <div className="sidebar-logo">
          <h2 style={{ fontSize: '1.25rem', color: '#4F46E5', margin: 0 }}>
            Student Portal
          </h2>
          <p style={{ fontSize: '0.75rem', color: '#9CA3AF', marginTop: '0.25rem' }}>
            AUY • 2026
          </p>
        </div>

        {/* Menu Items */}
        <div className="sidebar-menu">
          {menuItems.map((item) => {
            const Icon = item.icon;
            const active = isActive(item.path);
            
            return (
              <Link
                key={item.path}
                to={item.path}
                className={`sidebar-menu-item ${active ? 'active' : ''}`}
                onClick={() => setIsOpen(false)}
              >
                <Icon className="sidebar-menu-icon" />
                <span style={{ fontSize: '0.9rem' }}>{item.label}</span>
              </Link>
            );
          })}
        </div>

        {/* Logout Button */}
        <div className="sidebar-footer">
          <button
            onClick={onLogout}
            className="sidebar-logout"
          >
            <LogOut className="sidebar-menu-icon" />
            <span style={{ fontSize: '0.9rem' }}>Sign Out</span>
          </button>
        </div>
      </div>

      {/* Mobile Overlay */}
      {isOpen && (
        <div
          className="mobile-overlay"
          onClick={() => setIsOpen(false)}
        />
      )}
    </>
  );
};

export default Sidebar;
