import { GlassCard, SectionTitle } from '../components/Common';
import { Construction } from 'lucide-react';

export const Materials = () => {
  return (
    <div className="p-8 md:p-12 max-w-7xl mx-auto space-y-8 h-full flex flex-col">
      <SectionTitle title="Course Materials" subtitle="Resources, syllabi, and files" />

      <GlassCard delay={0.1} className="flex-1 flex flex-col items-center justify-center p-12 text-center min-h-[400px]">
        <div className="p-6 bg-emerald-500/10 rounded-full mb-6 text-emerald-300 border border-emerald-500/20 shadow-[0_0_30px_rgba(52,211,153,0.2)]">
          <Construction className="w-16 h-16 animate-pulse" />
        </div>
        <h3 className="text-2xl font-bold text-white mb-2">Coming Soon</h3>
        <p className="text-emerald-100/60 max-w-md mx-auto">
          We're currently building out the course materials section. Check back later to access files, syllabi, and resources for your enrolled classes.
        </p>
      </GlassCard>
    </div>
  );
};
