-- ============================================================
-- Hospital OPD Wait-Time Analysis — SQL Queries
-- Table: opd_visits  (import data/processed/opd_visits_clean.csv)
-- Key columns:
--   PatientID, Department, AppointmentType, InsuranceType,
--   ArrivalMethod, VisitDate, ArrivalHour, DayOfWeek, IsWeekend,
--   TriageCategory, FacilityOccupancyRate, ProvidersOnShift,
--   NursesOnShift, StaffToPatientRatio,
--   WaitTimeMinutes   -- our core "OPD wait time" metric
--   TotalTimeInHospital, TotalDelayTime
-- ============================================================

-- 1. Average wait time by department (find the worst-performing dept)
SELECT
    Department,
    ROUND(AVG(WaitTimeMinutes), 1) AS avg_wait_minutes,
    COUNT(*) AS total_visits
FROM opd_visits
GROUP BY Department
ORDER BY avg_wait_minutes DESC;

-- 2. Wait time by hour of arrival (find peak hours)
SELECT
    ArrivalHour,
    ROUND(AVG(WaitTimeMinutes), 1) AS avg_wait_minutes,
    COUNT(*) AS total_visits
FROM opd_visits
GROUP BY ArrivalHour
ORDER BY ArrivalHour;

-- 3. Wait time by day of week (find busiest days)
SELECT
    DayOfWeek,
    ROUND(AVG(WaitTimeMinutes), 1) AS avg_wait_minutes,
    COUNT(*) AS total_visits
FROM opd_visits
GROUP BY DayOfWeek
ORDER BY avg_wait_minutes DESC;

-- 4. Top 10 longest individual wait times (outlier investigation)
SELECT
    PatientID,
    Department,
    VisitDate,
    TriageCategory,
    WaitTimeMinutes
FROM opd_visits
ORDER BY WaitTimeMinutes DESC
LIMIT 10;

-- 5. Department + hour combo with worst wait times (actionable insight)
SELECT
    Department,
    ArrivalHour,
    ROUND(AVG(WaitTimeMinutes), 1) AS avg_wait_minutes,
    COUNT(*) AS total_visits
FROM opd_visits
GROUP BY Department, ArrivalHour
HAVING total_visits > 5
ORDER BY avg_wait_minutes DESC
LIMIT 10;

-- 6. Wait time by triage urgency category (are urgent cases really seen faster?)
SELECT
    TriageCategory,
    ROUND(AVG(WaitTimeMinutes), 1) AS avg_wait_minutes,
    COUNT(*) AS total_visits
FROM opd_visits
GROUP BY TriageCategory
ORDER BY avg_wait_minutes DESC;

-- 7. Impact of staffing levels on wait time (do more nurses/providers help?)
SELECT
    ProvidersOnShift,
    NursesOnShift,
    ROUND(AVG(WaitTimeMinutes), 1) AS avg_wait_minutes,
    COUNT(*) AS total_visits
FROM opd_visits
GROUP BY ProvidersOnShift, NursesOnShift
ORDER BY avg_wait_minutes DESC
LIMIT 10;

-- 8. Weekend vs weekday comparison
SELECT
    IsWeekend,
    ROUND(AVG(WaitTimeMinutes), 1) AS avg_wait_minutes,
    COUNT(*) AS total_visits
FROM opd_visits
GROUP BY IsWeekend;

-- 9. Overall KPI summary (for dashboard header cards)
SELECT
    COUNT(*) AS total_patients,
    ROUND(AVG(WaitTimeMinutes), 1) AS avg_wait_minutes,
    MAX(WaitTimeMinutes) AS max_wait_minutes,
    MIN(WaitTimeMinutes) AS min_wait_minutes,
    ROUND(AVG(TotalTimeInHospital), 1) AS avg_total_time_in_hospital
FROM opd_visits;
