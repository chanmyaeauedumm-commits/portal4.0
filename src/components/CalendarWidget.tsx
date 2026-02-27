import React, { useState } from 'react';
import { ChevronLeft, ChevronRight } from 'lucide-react';

// Myanmar Public Holidays 2026
const myanmarHolidays2026 = [
  { date: '2026-01-04', name: 'Independence Day' },
  { date: '2026-02-12', name: 'Union Day' },
  { date: '2026-03-02', name: 'Peasants Day' },
  { date: '2026-03-27', name: 'Armed Forces Day' },
  { date: '2026-03-30', name: 'Thingyan Water Festival' },
  { date: '2026-03-31', name: 'Thingyan Water Festival' },
  { date: '2026-04-01', name: 'Thingyan Water Festival' },
  { date: '2026-04-02', name: 'Thingyan Water Festival' },
  { date: '2026-04-03', name: 'Myanmar New Year' },
  { date: '2026-04-04', name: 'Myanmar New Year Holiday' },
  { date: '2026-05-01', name: 'Labour Day' },
  { date: '2026-05-13', name: 'Full Moon of Kasong' },
  { date: '2026-07-19', name: 'Martyrs Day' },
  { date: '2026-07-28', name: 'Full Moon of Waso' },
  { date: '2026-10-24', name: 'Full Moon of Thadingyut' },
  { date: '2026-10-25', name: 'Thadingyut Festival' },
  { date: '2026-11-21', name: 'Full Moon of Tazaungmon' },
  { date: '2026-11-22', name: 'National Day' },
  { date: '2026-12-25', name: 'Christmas Day' },
];

interface CalendarWidgetProps {
  initialDate?: Date;
}

const CalendarWidget: React.FC<CalendarWidgetProps> = ({ initialDate = new Date() }) => {
  const [currentDate, setCurrentDate] = useState(initialDate);
  const [selectedDate, setSelectedDate] = useState<Date | null>(null);

  const year = currentDate.getFullYear();
  const month = currentDate.getMonth();

  const monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  const getDaysInMonth = (year: number, month: number) => {
    return new Date(year, month + 1, 0).getDate();
  };

  const getFirstDayOfMonth = (year: number, month: number) => {
    return new Date(year, month, 1).getDay();
  };

  const daysInMonth = getDaysInMonth(year, month);
  const firstDay = getFirstDayOfMonth(year, month);

  const days = [];
  const dayNames = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];

  // Add empty cells for days before the first day of month
  for (let i = 0; i < firstDay; i++) {
    days.push(<div key={`empty-${i}`} style={{ padding: '0.5rem' }}></div>);
  }

  // Add cells for each day of the month
  for (let day = 1; day <= daysInMonth; day++) {
    const date = new Date(year, month, day);
    const dateStr = date.toISOString().split('T')[0];
    const holiday = myanmarHolidays2026.find(h => h.date === dateStr);
    const isSelected = selectedDate && date.toDateString() === selectedDate.toDateString();
    const isToday = new Date().toDateString() === date.toDateString();

    days.push(
      <div
        key={`day-${day}`}
        onClick={() => setSelectedDate(date)}
        style={{
          padding: '0.5rem',
          textAlign: 'center',
          cursor: 'pointer',
          backgroundColor: isSelected ? '#EEF2FF' : holiday ? '#FEF3C7' : 'transparent',
          color: holiday ? '#92400E' : isToday ? '#4F46E5' : '#111827',
          borderRadius: '8px',
          transition: 'all 0.2s',
          border: isToday ? '1px solid #4F46E5' : 'none'
        }}
        onMouseEnter={(e) => {
          if (!isSelected && !holiday) {
            e.currentTarget.style.backgroundColor = '#F3F4F6';
          }
        }}
        onMouseLeave={(e) => {
          if (!isSelected && !holiday) {
            e.currentTarget.style.backgroundColor = 'transparent';
          }
        }}
      >
        {day}
      </div>
    );
  }

  const prevMonth = () => {
    setCurrentDate(new Date(year, month - 1, 1));
    setSelectedDate(null);
  };

  const nextMonth = () => {
    setCurrentDate(new Date(year, month + 1, 1));
    setSelectedDate(null);
  };

  return (
    <div style={{
      backgroundColor: 'white',
      borderRadius: '12px',
      padding: '1.25rem',
      boxShadow: '0 4px 20px rgba(0,0,0,0.03)',
      border: '1px solid #F3F4F6'
    }}>
      {/* Header */}
      <div style={{
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        marginBottom: '1rem'
      }}>
        <h3 style={{ fontSize: '0.95rem', color: '#111827', margin: 0 }}>
          {monthNames[month]} {year}
        </h3>
        <div style={{ display: 'flex', gap: '0.5rem' }}>
          <button
            onClick={prevMonth}
            style={{
              padding: '0.25rem',
              backgroundColor: 'transparent',
              border: '1px solid #E5E7EB',
              borderRadius: '6px',
              cursor: 'pointer',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              color: '#6B7280'
            }}
          >
            <ChevronLeft size={16} />
          </button>
          <button
            onClick={nextMonth}
            style={{
              padding: '0.25rem',
              backgroundColor: 'transparent',
              border: '1px solid #E5E7EB',
              borderRadius: '6px',
              cursor: 'pointer',
              display: 'flex',
              alignItems: 'center',
              justifyContent: 'center',
              color: '#6B7280'
            }}
          >
            <ChevronRight size={16} />
          </button>
        </div>
      </div>

      {/* Day Names */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(7, 1fr)',
        marginBottom: '0.5rem',
        textAlign: 'center',
        fontSize: '0.7rem',
        color: '#9CA3AF'
      }}>
        {dayNames.map(day => (
          <div key={day} style={{ padding: '0.25rem' }}>{day}</div>
        ))}
      </div>

      {/* Calendar Grid */}
      <div style={{
        display: 'grid',
        gridTemplateColumns: 'repeat(7, 1fr)',
        gap: '0.25rem',
        marginBottom: '1rem'
      }}>
        {days}
      </div>

      {/* Selected Date Info */}
      {selectedDate && (
        <div style={{
          marginTop: '0.75rem',
          padding: '0.75rem',
          backgroundColor: '#F9FAFB',
          borderRadius: '8px',
          fontSize: '0.8rem'
        }}>
          <p style={{ color: '#111827', marginBottom: '0.25rem' }}>
            {selectedDate.toLocaleDateString('en-US', { 
              weekday: 'long', 
              year: 'numeric', 
              month: 'long', 
              day: 'numeric' 
            })}
          </p>
          {myanmarHolidays2026.find(h => h.date === selectedDate.toISOString().split('T')[0]) && (
            <p style={{ color: '#92400E' }}>
              🎉 {myanmarHolidays2026.find(h => h.date === selectedDate.toISOString().split('T')[0])?.name}
            </p>
          )}
        </div>
      )}
    </div>
  );
};

export default CalendarWidget;
