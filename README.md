<img width="580" height="170" alt="image" src="https://github.com/user-attachments/assets/1e55f180-5c1a-44d3-9e11-b1ef10fea26d" />

# Healthcare Readmission & Patient Flow Analysis

## Tools Used

**SQL (MySQL)** - Data Cleaning, Validation 

**Power BI** - Data Modeling, Visualization, Dashboard 

## Project Overview & Objectives

Health Flow Co. is a fictional healthcare provider seeking to determine where operational improvements and care-coordinated strategies can yield the greatest impact on patient outcomes and hospital bed efficiency. Leadership requires clear visibility into high-risk patient populations, post-discharge transitions, length-of-stay dynamics, and key operational drivers associated with elevated readmission risk. 

This analysis translates patient flow and clinical data from 7,000 admissions records into actionable insights to address the following core questions posed by managment:

* **Which primary diagnoses and age cohorts drive the highest concentration of readmission risk?**

* **How do discharge dispositions impact readmission rates?**

* **How does stay duration correlate with readmission volume, and where are extended stays failing to mitigate post-discharge risk?**

* **Where should discharge planning, early follow-up scheduling, and care-coordination resources be prioritized to achieve a sustained reduction in readmissions?**

## Data Overview

To ensure accurate clinical analysis, raw patient records were ingested, cleaned, and transformed in MySQL before being integrated into Power BI. The primary dataset covers inpatient encounters, tracking patient demographics, clinical diagnoses, treatment history, operational metrics, and 30-day readmission status.

**Data Cleaning**
* Parsing & Transforming: Parsed assorted formats into standardized YYYY-MM-DD dates, stripped percentage signs to cast 'readmission_risk_score' to a DECIMAL(5,2) metric, and mapped mixed boolean representations (True/1/Yes) to a TINYINT binary flag (label_clean).

* Standardization: Cleaned string fields using TRIM() and CONCAT() capitalization logic, mapped clinical abbreviations to standard medical terms, reclassified blank categorial records as 'Unknown' and filtered extreme outlier values in age.

**Key Data Attributes** 
* Patient Info & Demographics: patient_id, age, gender, region

* Clinical Metrics: primary_diagnosis, comorbidities_count, treatment_type, medications_count, readmission_risk_score

* Operational Info & Stay Details: admission_date, season, length_of_stay, followup_visits_clean, discharge_disposition, insurance_type

* Readmission History & Target Flag: prev_readmission, label (30-day Readmission Flag)

## Patient Risk & Demographics Dashboard 

<img width="906" height="514" alt="image" src="https://github.com/user-attachments/assets/73739947-fd90-4e24-9d2b-356425268afc" />

## Key Insights

**Overall readmissions are critically high:** A 77.68% overall admission rate indicates widespread post-discharge return rates, accompanied by an average length-of-stay (LOS) of 7.8 days and an average risk score of 78.3%

**Readmission risk is concentrated in chronic conditions:** Primary diagnoses such as Sepsis, COPD, Heart Failure, Stroke, and Chronic Kidney Disease lead the hospital in readmission rates, with each condition approaching or exceeding 80-90%.

**Post-discharge risk shifts heavily to Home Health and Skilled Nursing Facilities:** The majority of readmitted patients are discharged to Home Health services, followed by Skilled Nursing Facilities (SNF), while direct discharges to Home represent a minimal share of total readmissions. 

**Longer hospital stays correlate with higher readmission volume:** Readmission scales directly with stay duration, as Long Stay and Moderate Stay cohorts account for almost all readmissions, whereas Short Stay patients generate low readmissions.

**Readmissions peak among mature adult age groups:** The 61-75 age cohort accounts for the highest volume of readmissions, with the 46-60 age group following closely behind, while 0-18 and 19-30 age groups show minimal readmissions.

**Follow-up visits show specific operational intervention windows:** Readmissions are heavily concentrated among patients who complete 2 and 4 follow-up visits, identifying specific post-release touchpoints where care coordination or outpatient monitoring needs reinforcement. 

## Dashboard 

## Key Insights

## Recommendations

## Conclusion 

