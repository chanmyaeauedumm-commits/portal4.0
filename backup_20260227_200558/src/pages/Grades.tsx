import { useData } from '../contexts/DataContext';
import { GlassCard, SectionTitle, GlassBadge } from '../components/Common';
import { Award, FileText, CheckCircle2 } from 'lucide-react';
import { cn } from '../utils/cn';

const gradeColors: Record<string, string> = {
  'A': 'text-emerald-300 bg-emerald-500/10 border-emerald-500/30',
  'A-': 'text-emerald-300 bg-emerald-500/10 border-emerald-500/30',
  'B+': 'text-teal-300 bg-teal-500/10 border-teal-500/30',
  'B': 'text-cyan-300 bg-cyan-500/10 border-cyan-500/30',
  'B-': 'text-sky-300 bg-sky-500/10 border-sky-500/30',
  'C+': 'text-yellow-300 bg-yellow-500/10 border-yellow-500/30',
  'C': 'text-amber-300 bg-amber-500/10 border-amber-500/30',
  'C-': 'text-orange-300 bg-orange-500/10 border-orange-500/30',
  'D': 'text-rose-300 bg-rose-500/10 border-rose-500/30',
  'F': 'text-red-500 bg-red-500/10 border-red-500/30'
};

const gradePointsMap: Record<string, number> = {
  'A': 4.0, 'A-': 3.7, 'B+': 3.3, 'B': 3.0, 'B-': 2.7, 'C+': 2.3, 'C': 2.0, 'C-': 1.7, 'D': 1.0, 'F': 0.0
};

export const Grades = () => {
  const { enrollments, loading } = useData();

  if (loading) {
    return (
      <div className="flex h-full items-center justify-center p-8 text-white/50">
        <div className="animate-spin rounded-full h-12 w-12 border-4 border-emerald-400 border-t-transparent" />
      </div>
    );
  }

  // Stats
  let totalPoints = 0;
  let gradedCredits = 0;
  let totalCredits = 0;

  enrollments.forEach(enr => {
    totalCredits += (enr.credits || 0);
    if (gradePointsMap[enr.grade] !== undefined) {
      totalPoints += gradePointsMap[enr.grade] * (enr.credits || 0);
      gradedCredits += (enr.credits || 0);
    }
  });

  const gpa = gradedCredits > 0 ? (totalPoints / gradedCredits).toFixed(2) : "0.00";

  return (
    <div className="p-8 md:p-12 max-w-7xl mx-auto space-y-8 pb-20">
      <SectionTitle title="Grades & Transcripts" subtitle="Academic performance overview" />

      {/* Summary Cards */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        <GlassCard delay={0.1} className="p-6 flex items-center gap-4">
          <div className="p-4 bg-emerald-500/20 rounded-2xl text-emerald-300 border border-emerald-500/30">
            <Award className="w-8 h-8" />
          </div>
          <div>
            <p className="text-sm text-emerald-100/60 font-medium uppercase tracking-wider">Cumulative GPA</p>
            <p className="text-3xl font-bold text-white">{gpa}</p>
          </div>
        </GlassCard>

        <GlassCard delay={0.2} className="p-6 flex items-center gap-4">
          <div className="p-4 bg-blue-500/20 rounded-2xl text-blue-300 border border-blue-500/30">
            <CheckCircle2 className="w-8 h-8" />
          </div>
          <div>
            <p className="text-sm text-emerald-100/60 font-medium uppercase tracking-wider">Total Credits</p>
            <p className="text-3xl font-bold text-white">{totalCredits}</p>
          </div>
        </GlassCard>

        <GlassCard delay={0.3} className="p-6 flex items-center gap-4">
          <div className="p-4 bg-purple-500/20 rounded-2xl text-purple-300 border border-purple-500/30">
            <FileText className="w-8 h-8" />
          </div>
          <div>
            <p className="text-sm text-emerald-100/60 font-medium uppercase tracking-wider">Courses</p>
            <p className="text-3xl font-bold text-white">{enrollments.length}</p>
          </div>
        </GlassCard>
      </div>

      {/* Table */}
      <GlassCard delay={0.4} className="overflow-hidden">
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead>
              <tr className="border-b border-white/10 bg-black/10 text-emerald-100/50 uppercase tracking-wider text-xs font-semibold">
                <th className="p-4 pl-6">Course Code</th>
                <th className="p-4">Course Name</th>
                <th className="p-4">Credits</th>
                <th className="p-4">Grade</th>
                <th className="p-4">Grade Points</th>
                <th className="p-4 pr-6 text-right">Last Updated</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-white/5">
              {enrollments.map((enr) => {
                const gp = gradePointsMap[enr.grade] !== undefined ? gradePointsMap[enr.grade] : null;
                const totalGp = gp !== null ? (gp * enr.credits).toFixed(2) : '-';
                
                return (
                  <tr key={enr.courseId} className="hover:bg-white/5 transition-colors">
                    <td className="p-4 pl-6">
                      <GlassBadge className="bg-transparent border-white/10 font-mono">{enr.courseId}</GlassBadge>
                    </td>
                    <td className="p-4 font-medium text-white/90">{enr.courseName}</td>
                    <td className="p-4 text-emerald-100/60">{enr.credits}</td>
                    <td className="p-4">
                      {enr.grade ? (
                        <span className={cn(
                          "px-2.5 py-1 rounded-md text-sm font-bold border",
                          gradeColors[enr.grade] || "text-white/60 bg-white/10 border-white/20"
                        )}>
                          {enr.grade}
                        </span>
                      ) : (
                        <span className="text-white/40 italic text-sm">N/A</span>
                      )}
                    </td>
                    <td className="p-4 text-emerald-100/60 font-mono">{totalGp}</td>
                    <td className="p-4 pr-6 text-right text-emerald-100/40 text-sm">
                      {new Date(enr.lastUpdated).toLocaleDateString()}
                    </td>
                  </tr>
                );
              })}
              {enrollments.length === 0 && (
                <tr>
                  <td colSpan={6} className="p-8 text-center text-white/40">
                    No grades available
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </GlassCard>
    </div>
  );
};
