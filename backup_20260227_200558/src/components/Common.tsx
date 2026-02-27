import React from 'react';
import { motion } from 'framer-motion';
import { cn } from '../utils/cn';

export const GlassCard = ({ children, className, delay = 0 }: { children: React.ReactNode, className?: string, delay?: number }) => {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: 0.5, delay }}
      className={cn("backdrop-blur-xl bg-white/10 rounded-3xl border border-white/20 shadow-2xl overflow-hidden", className)}
    >
      {children}
    </motion.div>
  );
};

export const GlassBadge = ({ children, className }: { children: React.ReactNode, className?: string }) => (
  <span className={cn("px-3 py-1 rounded-full text-xs font-semibold backdrop-blur-md bg-white/10 border border-white/20 text-white/90", className)}>
    {children}
  </span>
);

export const SectionTitle = ({ title, subtitle }: { title: string, subtitle?: string }) => (
  <div className="mb-8">
    <h2 className="text-3xl font-bold text-white tracking-tight">{title}</h2>
    {subtitle && <p className="text-emerald-100/70 mt-2">{subtitle}</p>}
  </div>
);

export const PageContainer = ({ children }: { children: React.ReactNode }) => (
  <div className="min-h-screen bg-gradient-to-br from-emerald-900 to-emerald-950 p-6 md:p-12 text-white overflow-y-auto">
    <div className="max-w-6xl mx-auto space-y-8">
      {children}
    </div>
  </div>
);
