import { useData } from '../contexts/DataContext';
import { GlassCard, SectionTitle, GlassBadge } from '../components/Common';
import { ExternalLink, Users, BookOpen } from 'lucide-react';

export const Courses = () => {
  const { enrollments, loading } = useData();

  if (loading) {
    return (
      <div className="flex h-full items-center justify-center p-8 text-white/50">
        <div className="animate-spin rounded-full h-12 w-12 border-4 border-emerald-400 border-t-transparent" />
      </div>
    );
  }

  return (
    <div className="p-8 md:p-12 max-w-7xl mx-auto space-y-8 pb-20">
      <SectionTitle title="My Courses" subtitle="Manage and access your current classes" />

      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {enrollments.map((enr, i) => (
          <GlassCard key={enr.courseId} delay={i * 0.1} className="p-6 flex flex-col group relative overflow-hidden">
            <div className="absolute top-0 left-0 w-2 h-full bg-gradient-to-b from-emerald-400 to-teal-500 rounded-l-3xl opacity-50 group-hover:opacity-100 transition-opacity" />
            
            <div className="flex justify-between items-start mb-4 ml-4">
              <GlassBadge className="bg-white/5 border-white/10 text-emerald-100/70">{enr.courseId}</GlassBadge>
              {enr.grade && <span className="text-2xl font-bold text-emerald-300 drop-shadow-sm">{enr.grade}</span>}
            </div>
            
            <h4 className="font-semibold text-xl text-white mb-2 ml-4 group-hover:text-emerald-300 transition-colors line-clamp-2">
              {enr.courseName}
            </h4>
            
            <div className="space-y-3 mb-8 ml-4">
              <div className="flex items-center gap-2 text-sm text-emerald-100/60">
                <Users className="w-4 h-4" />
                {enr.teacherName}
              </div>
              <div className="flex items-center gap-2 text-sm text-emerald-100/60">
                <BookOpen className="w-4 h-4" />
                {enr.credits} Credits
              </div>
            </div>
            
            <div className="mt-auto pt-6 border-t border-white/10 ml-4">
              <a 
                href={enr.googleClassroomLink} 
                target="_blank" 
                rel="noreferrer"
                className="w-full py-3 px-4 bg-emerald-500/20 hover:bg-emerald-500/30 text-emerald-300 rounded-xl font-medium transition-colors border border-emerald-500/30 flex items-center justify-center gap-2 group-hover:border-emerald-400/50 group-hover:shadow-[0_0_15px_rgba(52,211,153,0.3)]"
              >
                Open Classroom
                <ExternalLink className="w-4 h-4" />
              </a>
            </div>
          </GlassCard>
        ))}
      </div>
    </div>
  );
};
