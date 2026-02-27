import { useData } from '../contexts/DataContext';
import { GlassCard, SectionTitle } from '../components/Common';
import { CheckCircle, BarChart3, Users, LineChart } from 'lucide-react';

export const Progress = () => {
  const { enrollments, studentInfo, loading } = useData();

  if (loading) {
    return (
      <div className="flex h-full items-center justify-center p-8 text-white/50">
        <div className="animate-spin rounded-full h-12 w-12 border-4 border-emerald-400 border-t-transparent" />
      </div>
    );
  }

  // Calculate stats
  const totalCredits = enrollments.reduce((sum, enr) => sum + (enr.credits || 0), 0);
  const totalTargetCredits = 120; // Assuming a typical Bachelor's degree
  const creditCompletion = Math.min((totalCredits / totalTargetCredits) * 100, 100);

  const avgAttendance = enrollments.length > 0 
    ? enrollments.reduce((sum, enr) => sum + (enr.attendancePercentage || 0), 0) / enrollments.length
    : 0;

  const coursesDone = enrollments.filter(enr => enr.grade && enr.grade !== 'F').length;
  const totalCourses = enrollments.length;
  const courseCompletion = totalCourses > 0 ? (coursesDone / totalCourses) * 100 : 0;

  return (
    <div className="p-8 md:p-12 max-w-7xl mx-auto space-y-8 pb-20">
      <SectionTitle title="Academic Progress" subtitle={`Tracking degree progress for ${studentInfo?.major || 'your program'}`} />

      <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
        {/* Credit Completion */}
        <GlassCard delay={0.1} className="p-8 space-y-6 flex flex-col justify-between">
          <div className="flex justify-between items-start">
            <div>
              <h3 className="text-xl font-bold text-white mb-1">Credit Completion</h3>
              <p className="text-sm text-emerald-100/60 flex items-center gap-2">
                <BarChart3 className="w-4 h-4" /> Degree Requirement: {totalTargetCredits} Credits
              </p>
            </div>
            <div className="text-3xl font-bold text-emerald-400">{creditCompletion.toFixed(1)}%</div>
          </div>
          
          <div className="space-y-2">
            <div className="flex justify-between text-sm font-medium">
              <span className="text-white/80">{totalCredits} Earned</span>
              <span className="text-white/40">{totalTargetCredits - totalCredits} Remaining</span>
            </div>
            <div className="h-4 w-full bg-black/20 rounded-full overflow-hidden border border-white/5">
              <div 
                className="h-full bg-gradient-to-r from-emerald-500 to-teal-400 rounded-full shadow-[0_0_10px_rgba(52,211,153,0.5)] transition-all duration-1000"
                style={{ width: `${creditCompletion}%` }}
              />
            </div>
          </div>
        </GlassCard>

        {/* Courses Completed */}
        <GlassCard delay={0.2} className="p-8 space-y-6 flex flex-col justify-between">
          <div className="flex justify-between items-start">
            <div>
              <h3 className="text-xl font-bold text-white mb-1">Courses Passed</h3>
              <p className="text-sm text-emerald-100/60 flex items-center gap-2">
                <CheckCircle className="w-4 h-4" /> Based on current enrollments
              </p>
            </div>
            <div className="text-3xl font-bold text-blue-400">{courseCompletion.toFixed(1)}%</div>
          </div>
          
          <div className="space-y-2">
            <div className="flex justify-between text-sm font-medium">
              <span className="text-white/80">{coursesDone} Passed</span>
              <span className="text-white/40">{totalCourses} Total Enrolled</span>
            </div>
            <div className="h-4 w-full bg-black/20 rounded-full overflow-hidden border border-white/5">
              <div 
                className="h-full bg-gradient-to-r from-blue-500 to-cyan-400 rounded-full shadow-[0_0_10px_rgba(59,130,246,0.5)] transition-all duration-1000"
                style={{ width: `${courseCompletion}%` }}
              />
            </div>
          </div>
        </GlassCard>

        {/* Attendance Avg */}
        <GlassCard delay={0.3} className="p-8 space-y-6 flex flex-col justify-between">
          <div className="flex justify-between items-start">
            <div>
              <h3 className="text-xl font-bold text-white mb-1">Overall Attendance</h3>
              <p className="text-sm text-emerald-100/60 flex items-center gap-2">
                <Users className="w-4 h-4" /> Average across all courses
              </p>
            </div>
            <div className="text-3xl font-bold text-amber-400">{avgAttendance.toFixed(1)}%</div>
          </div>
          
          <div className="space-y-2">
            <div className="flex justify-between text-sm font-medium">
              <span className="text-white/80">Present</span>
              <span className="text-white/40">Absent</span>
            </div>
            <div className="h-4 w-full bg-black/20 rounded-full overflow-hidden border border-white/5">
              <div 
                className="h-full bg-gradient-to-r from-amber-500 to-yellow-400 rounded-full shadow-[0_0_10px_rgba(245,158,11,0.5)] transition-all duration-1000"
                style={{ width: `${avgAttendance}%` }}
              />
            </div>
          </div>
        </GlassCard>

        {/* GPA Trend Placeholder */}
        <GlassCard delay={0.4} className="p-8 space-y-6 flex flex-col justify-between">
          <div className="flex justify-between items-start">
            <div>
              <h3 className="text-xl font-bold text-white mb-1">GPA Trend</h3>
              <p className="text-sm text-emerald-100/60 flex items-center gap-2">
                <LineChart className="w-4 h-4" /> Academic trajectory
              </p>
            </div>
            <div className="p-2 bg-purple-500/20 rounded-xl text-purple-300 border border-purple-500/30">
              <LineChart className="w-6 h-6" />
            </div>
          </div>
          
          <div className="flex-1 flex items-center justify-center p-4 border border-white/10 border-dashed rounded-2xl bg-white/5">
            <p className="text-white/40 text-sm text-center">
              Insufficient historical data to display trend chart.<br/>
              Complete more semesters to unlock insights.
            </p>
          </div>
        </GlassCard>
      </div>
    </div>
  );
};
