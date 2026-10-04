# Hospital OPD Wait-Time Analysis & Prediction

## Problem Statement
Long and unpredictable OPD (Outpatient Department) wait times are a common
pain point in hospitals. This project analyzes 5,000 patient visit records
to uncover operational bottlenecks (peak hours, high-load departments,
staffing impact) and builds a machine learning model to predict expected
wait time for a new patient — giving hospital staff a planning tool.

**Dataset:** Hospital Wait Time Data (Kaggle, 5,000 rows, 57 columns)
**Core metric:** `WaitTimeMinutes` — time between triage completion and the
doctor starting the consultation (derived from `TriageToProviderStartTime`).

## Project Structure
```
hospital-opd-project/
├── data/
│   ├── raw/            # Hospital_Wait_Time_Data.csv goes here (untouched)
│   └── processed/      # Cleaned dataset after preprocessing
├── sql/                # SQL scripts for analysis queries
├── notebooks/          # Python notebooks (cleaning, EDA, ML model)
├── dashboard/          # Power BI / Tableau file + exported screenshots
├── models/             # Saved trained ML model (.pkl)
├── reports/
│   └── screenshots/    # Dashboard & chart screenshots for README/LinkedIn
├── requirements.txt    # Python dependencies
└── README.md
```

## Tools Used
- **SQL** — data aggregation & business-question queries
- **Python (pandas, matplotlib, seaborn)** — data cleaning & exploratory analysis
- **scikit-learn** — wait-time prediction model (Random Forest Regressor)
- **Power BI / Tableau Public** — interactive dashboard

## Workflow
1. **Data Cleaning** (`notebooks/01_data_cleaning.ipynb`) — select relevant
   columns, drop duplicates/invalid rows, parse dates, export clean CSV to
   `data/processed/opd_visits_clean.csv`.
2. **SQL Analysis** (`sql/analysis_queries.sql`) — 9 business questions:
   department-wise wait time, peak hours, day-of-week trends, triage
   urgency vs. actual wait, staffing impact, weekend vs. weekday.
3. **Dashboard** (`dashboard/`) — visualize the above findings interactively.
4. **ML Model** (`notebooks/02_wait_time_prediction.ipynb`) — predict
   `WaitTimeMinutes` using department, arrival hour, day of week, triage
   category, appointment type, and staffing levels as features.
5. **Reporting** — key insights and dashboard screenshots collected in
   `reports/`.

## Key Insights
*(Fill this in once you've run the analysis — 3 to 4 bullet points,
e.g. "Emergency department shows the highest average wait despite urgent
triage status, concentrated between 2 PM–4 PM.")*

## Model Performance
*(Fill this in after training — reported by the notebook as MAE and R².)*

## Author
Asif Ali — [LinkedIn](https://linkedin.com/in/asif-ali-083202208)
