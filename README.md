<img width="580" height="170" alt="image" src="https://github.com/user-attachments/assets/1e55f180-5c1a-44d3-9e11-b1ef10fea26d" />

# Healthcare Readmission & Patient Flow Analysis

## Tools Used

**SQL (MySQL)** - Data extraction, Data cleaning, Standardization, Reporting view creation 

**Power Query** - ETL, Data transformation

**DAX** - Data modeling, Calculated measures, Explicit aggregations, KPI development

**Power BI** - Data modeling, Interactive visual reporting, dashboard design 

## Project Overview & Objectives

Health Flow Co. is a fictional healthcare system seeking to identify where operational improvements and care-coordinated strategies may have the greatest potential to improve patient outcomes and hospital bed efficiency. Leadership requires clear data-driven visibility into patients with higher observed readmission rates, post-discharge transitions, length-of-stay (LOS) patterns, and key operational factors associated with elevated readmission rates. 

This project translates approximately 7,000 patient admissions and care records into actionable insights that address the following business questions:

* **Which clinical diagnoses and patient age groups account for the largest volume of observed readmissions?**
  
* **How do discharge settings and length of stay (LOS) relate to observed readmission outcomes?**
  
* **How do readmission rates vary by payer or insurance type, and where are the largest differences in coverage groups?**
  
* **When are readmissions occurring following discharge, and what do follow-up patterns suggest about potential care-coordination opportunities?**
  
* **Where could discharge planning, follow-up scheduling, and care-coordination resources be prioritized for further investigation?**

## Data Overview
*(Important: Dataset is synthetically generated for portfolio demonstration purposes; Readmission rates and other clinical metrics are simulated and should not be interpreted as representative of real-world hospital performance).*
<p></p>

To ensure accurate clinical analysis, raw patient records were ingested, cleaned, and transformed in MySQL before being integrated into Power BI. The primary dataset covers inpatient encounters, tracking patient demographics, clinical diagnoses, treatment history, operational metrics, and 30-day readmission status.

**Data Cleaning**
* Parsing & Transforming: Standardized assorted date formats to YYYY-MM-DD dates, removed percentage symbols and converted 'readmission_risk_score' to a DECIMAL(5,2) metric, and standardized mixed boolean representations (True/1/Yes) to a binary flag (label_clean).

* Standardization: Cleaned string fields using TRIM() and capitalization logic, mapped clinical abbreviations to standard medical terms, reclassified blank categorical records as 'Unknown' and filtered extreme outlier values in age.

* Reporting View: Constructed a database view that selected cleaned fields and analysis-ready column aliases, providing a consistent data source for Power BI.

**Key Data Attributes** 
* Patient Info & Demographics: patient_id, age, gender, region

* Clinical Metrics: primary_diagnosis, comorbidities_count, treatment_type, medications_count, readmission_risk_score

* Operational Info & Stay Details: admission_date, season, length_of_stay, followup_visits_clean, discharge_disposition, insurance_type

* Readmission History & Target Flag: prev_readmission, label (30-day Readmission Flag)

**Figure 1: Primary Cleaning Script Sample** 

<img width="682" height="403" alt="image" src="https://github.com/user-attachments/assets/06099250-e6a8-4f20-96de-b55b7dcfaf9c" />


**Figure 2: Reporting View Definition**

<img width="613" height="341" alt="image" src="https://github.com/user-attachments/assets/67983629-5181-4832-bca6-236c37a50b6c" />


## Patient Risk & Demographics Dashboard 
*(Important: Dataset is synthetically generated for portfolio demonstration purposes; Readmission rates and other clinical metrics are simulated and should not be interpreted as representative of real-world hospital performance).*
<p></p>

<img width="1298" height="734" alt="image" src="https://github.com/user-attachments/assets/bc82342c-6723-4b59-a6a5-96ed729fbb1a" />


## Key Insights

**Overall Readmissions:** Across the synthetic dataset, the overall observed readmission rate is 77.68%, with an average length-of-stay (LOS) of 7.8 days, and an average risk score of 78.3%. Because these values are based on simulated data, they are presented as analytical benchmarks within the project rather than estimates of actual healthcare performance.

**Readmission Patterns by Diagnosis:** Primary diagnoses such as Sepsis (87.83%), COPD (87.75%), Heart Failure (87.28%), Stroke (86.26%), and Chronic Kidney Disease (84.03%) show the highest observed readmission rates in the dataset, compared to lower rates for conditions such as Hypertension (68.88%) and Influenza (68.75%). 

**Readmission by Age Group:** The 61-75 age cohort accounts for the highest volume of readmissions (1,754), with the 46-60 age group following closely behind (1,611), while 0-18 (29) and 19-30 (131) age groups show minimal readmissions.

**Post-acute Care Settings:** Patients discharged to Skilled Nursing Facilities (SNF) and Home Health show higher observed readmission rates across stay durations compared with patients discharged directly home.

**Length of Stay Patterns:** Observed readmission rates increase across Short, Moderate, and Long stay categories within the discharge settings examined. This association suggests that patients with longer inpatient stays may represent populations with greater underlying clinical or operational complexity. 

**Follow-up Visit Patterns:** Readmissions are concentrated among patients completing 2 and 4 follow-up visits. Follow-up frequency may reflect underlying patient risk or care complexity; however, these patterns warrant further analysis rather than indicating that additional visits increase readmission risk.  

**Payer Differences:** Readmission rates vary substantially across insurance groups, with Medicare beneficiaries demonstrating the highest overall rate (95.45%), followed by Uninsured (78.30%) and Medicaid (77.35%), while Private insurance consistently exhibits the lowest observed rate (66.99%).

## Recommendations

**1. Diagnosis & Age Cohorts:**
- Evaluate EHR Risk Flagging: Assess whether patients with Sepsis, COPD, Heart Failure, Stroke, and Chronic Kidney Disease warrant enhanced risk stratification, given their substantially higher observed readmission rates in the dataset.
- Investigate Mature Adult Demographics: Prioritize 46-60 and 61-75 age cohorts for further analysis as they represent the largest observed readmission volumes (1,611 and 1,754 readmissions).

**2. Discharge Disposition & Facility Handoffs:**
- Evaluate Inter-Facility Handoffs: Review transition processes for patients discharged to SNFs and Home Health, where observed readmission rates are consistently higher than for direct-to-home discharges. 
- Early Post-Discharge Outreach: Consider evaluating 48-72 hour post-discharge outreach for patients transitioning to SNF or Home Health settings to determine whether earlier contact is associated with improved transition outcomes. 

**3. Length-of-Stay (LOS) Patterns:**
- Initiate Earlier Discharge Planning: Patients with Moderate and Long inpatient stays demonstrate higher observed readmission rates. Discharge planning could be evaluated earlier in the inpatient stay to identify barriers, coordinate services, and support appropriate transitions. 
- Evaluate Bed-Capacity Implications: Analyze whether longer stays are associated with identifiable operational bottlenecks, delayed transitions, or patient complexity that may affect hospital capacity.  

**4. Strategic Resources Allocation & Care Coordination:**
- Investigate Follow-up Patterns: Evaluate the timing, purpose, and patient characteristics associated with 2 and 4 follow-up visits to determine whether these patterns reflect differences in clinical complexity, patient risk, or care-coordination needs.
- Investigate Payer-Based Differences:  Medicare beneficiaries (exhibiting a 95.45% readmission rate), Uninsured (78.30%), and Medicaid (77.35%) populations demonstrate higher observed readmission rates in this dataset. Further analysis should evaluate whether differences persist after accounting for age, diagnosis, prior readmission history, comorbidities, and other patient-level characteristics before assigning specific interventions to payer groups. 

## Conclusion

This project demonstrates how data analytics can help healthcare administrators and clinical teams identify cohorts with higher observed readmission rates and prioritize areas for further evaluation of care-management resources.

The analysis reveals that observed readmissions are not uniformly distributed, with higher observed readmission rates among patients with severe chronic conditions (such as Sepsis, COPD, and Heart Failure), mature adult age groups (ages 46–75), post-acute facility transitions to Skilled Nursing Facilities (SNFs) and Home Health settings, longer length of stay categories, and specific follow-up patterns.

These findings provide a data-driven basis for evaluating automated EHR risk triggers, standardized warm handoffs, and targeted nurse navigation as potential strategies for reducing readmission risk among patients with higher observed readmission rates. 






