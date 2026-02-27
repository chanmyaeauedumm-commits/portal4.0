import React from 'react';

interface SoftButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'primary' | 'secondary' | 'outline';
  size?: 'sm' | 'md' | 'lg';
  children: React.ReactNode;
}

export default function SoftButton({ 
  variant = 'primary', 
  size = 'md', 
  children, 
  className = '',
  ...props 
}: SoftButtonProps) {
  const baseStyles = 'rounded-xl transition-all duration-300 font-["Poppins"] font-normal';
  
  const variants = {
    primary: 'bg-indigo-600 text-white shadow-[0_4px_12px_rgba(79,70,229,0.2)] hover:shadow-[0_6px_16px_rgba(79,70,229,0.3)] hover:bg-indigo-700',
    secondary: 'bg-gray-100 text-gray-700 shadow-[0_2px_8px_rgba(0,0,0,0.03)] hover:shadow-[0_4px_12px_rgba(0,0,0,0.06)] hover:bg-gray-200',
    outline: 'bg-white text-gray-700 border border-gray-200 shadow-[0_2px_8px_rgba(0,0,0,0.02)] hover:shadow-[0_4px_12px_rgba(0,0,0,0.04)] hover:bg-gray-50',
  };
  
  const sizes = {
    sm: 'px-3 py-1.5 text-xs',
    md: 'px-4 py-2 text-sm',
    lg: 'px-6 py-3 text-base',
  };
  
  return (
    <button 
      className={`${baseStyles} ${variants[variant]} ${sizes[size]} ${className}`}
      {...props}
    >
      {children}
    </button>
  );
}
