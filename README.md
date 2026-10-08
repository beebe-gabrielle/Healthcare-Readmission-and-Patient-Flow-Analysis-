<img width="580" height="170" alt="image" src="https://github.com/user-attachments/assets/1e55f180-5c1a-44d3-9e11-b1ef10fea26d" />

# Healthcare Readmission & Patient Flow Analysis

## Tools Used

**SQL (MySQL)** - Data extraction, Data cleaning, Reporting view creation 

**Power Query** - ETL, Data transformation

**DAX** - Data modeling, Calculated measures, Explicit aggregations, KPI metrics

**Power BI** - Data modeling, Interactive visual reporting, UI dashboard design 

## Project Overview & Objectives

Health Flow Co. is a fictional healthcare system seeking to determine where operational improvements and care-coordinated strategies can yield the greatest impact on patient outcomes and hospital bed efficiency. Leadership requires clear data-driven visibility into high-risk patient populations, post-discharge transitions, length-of-stay (LOS) dynamics, and key operational drivers associated with elevated readmission risk. 

This project translates ~7000 patient admissions and care records into actionable insights that address the following core business questions posed by management:

* **Which clinical diagnoses and patient age groups account for the highest concentration of readmission risk?**
  
* **How do patient discharge settings and length of stay (LOS) impact readmission outcomes?**
  
* **How does readmission risk vary by payer or insurance type, and where are coverage vulnerabilities most pronounced?**
  
* **At what point post-discharge are readmissions occurring, and what does follow-up cadence tell us about care coordination timing?**
  
* **Where should discharge planning, follow-up scheduling, and care-coordination resources be prioritized to achieve a sustained reduction in readmissions?**

## Data Overview

To ensure accurate clinical analysis, raw patient records were ingested, cleaned, and transformed in MySQL before being integrated into Power BI. The primary dataset covers inpatient encounters, tracking patient demographics, clinical diagnoses, treatment history, operational metrics, and 30-day readmission status.

**Data Cleaning**
* Parsing & Transforming: Parsed assorted formats into standardized YYYY-MM-DD dates, stripped percentage signs to cast 'readmission_risk_score' to a DECIMAL(5,2) metric, and mapped mixed boolean representations (True/1/Yes) to a TINYINT binary flag (label_clean).

* Standardization: Cleaned string fields using TRIM() and CONCAT() capitalization logic, mapped clinical abbreviations to standard medical terms, reclassified blank categorial records as 'Unknown' and filtered extreme outlier values in age.\

* Reporting View: Constructed a database view that selected cleaned fields and restored analysis ready column aliases to serve as a seamless data source for Power BI

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
*(Note: Dataset is synthetically generated for demonstration; baseline rates reflect simulated distributions rather than actual clinical performance).*
<p></p>

<img width="1298" height="734" alt="image" src="https://github.com/user-attachments/assets/bc82342c-6723-4b59-a6a5-96ed729fbb1a" />


## Key Insights

**Overall Readmissions:** Across the synthetic dataset, overall readmissions are elevated, showing a 77.68% readmission rate, an average length-of-stay (LOS) of 7.8 days, and an average risk score of 78.3%.

**Readmission risk is concentrated in chronic conditions:** Primary diagnoses such as Sepsis (87.83%), COPD (87.75%), Heart Failure (87.28%), Stroke (86.26%), and Chronic Kidney Disease (84.03%) lead the hospital in readmission rates, dropping significantly for acute/manageable conditions like Hypertension (68.88%) and Influenza (68.75%). 

**Readmissions peak among mature adult age groups:** The 61-75 age cohort accounts for the highest volume of readmissions (1,754), with the 46-60 age group following closely behind (1,611), while 0-18 (29) and 19-30 (131) age groups show minimal readmissions.

**Post-acute care handoffs drive maximum risk:** Patients discharged to Skilled Nursing Facilities (SNF) and Home Health experience significantly higher readmission rates across stay durations than those discharged directly home. 

**Length of stay compounds discharge vulnerability:** Across all discharge destinations (Home, Home Health, Rehabilitation, SNF) readmission rates scale sequentially with inpatient stay duration; patients in Moderate and Long Stay categories consistently re-enter the hospital at higher rates than Short stay patients. 

**Follow-up visits show specific operational intervention windows:** Readmissions are heavily concentrated among patients who complete 2 and 4 follow-up visits, identifying specific post-release touchpoints where care coordination or outpatient monitoring needs reinforcement. 

**Payer disparities highlight systemic vulnerability:** Readmission rates vary substantially by coverage type, with Medicare beneficiaries demonstrating the highest overall rate (95.45%), followed by Uninsured (78.30%) and Medicaid (77.35%) populations while Private insurance consistently exhibits the lowest relative readmission baseline (66.99%).

## Recommendations

**1. Diagnosis & Age Cohorts:**
- Automate EHR Risk Flagging: Configure EHR triggers at admission to flag patients presenting with Sepsis, COPD, Heart Failure, Stroke, or Chronic Kidney Disease, as these conditions exhibit readmission rates exceeding 80-87%
- Target Mature Adult Demographics: Concentrate care coordination and social work resources on the 46-60 and 61-75 age cohorts, which represent the vast majority of total readmission volume (1,611 and 1,754 readmissions).

**2. Discharge Disposition & Facility Handoffs:**
- Standardize Inter-Facility Handoffs: Establish mandatory transfer protocols and direct clinical warm handoffs when discharging patients to Skilled Nursing Facilities (SNF) and Home Health, which represent the highest-risk disposition pathways. 
- Early Post-Release Outreach: Implement mandatory telehealth or care-manager touchpoints within 48-72 hours of discharge for all patients transitioning to SNFs or Home Health care. 

**3. Length-of-Stay (LOS) Dynamics & Extended Stay Risks:**
- Mitigate Extended-Stay Risk: Initiate discharge planning at admission for patients projected to have Moderate or Long stays, as extended stays in post-acute facilities compound readmissions vulnerability. 
- Active Bed-Capacity Planning: Coordinate multidisciplinary rounding to streamline care progression, avoiding unnecessary inpatient days that increase patient exposure to hospital-acquired complications. 

**4. Strategic Resources Allocation & Care Coordination:**
- Optimize Follow-Up Quality over Quantity: Focus post-discharge touchpoints on high-value clinical interventions (medication reconciliation, symptom checks) during key critical windows, specifically visits 2 and 4, rather than relying solely on total visit count.
- Target Payer Vulnerabilities: Allocate specialized nurse navigators to Medicare beneficiaries (exhibiting a 95.45% readmission rate), Uninsured (78.30%), and Medicaid (77.35%) populations to address socioeconomic and coverage gaps before release. 

## Conclusion

This project demonstrates how data analytics enables healthcare administrators and clinical teams to proactively mitigate hospital readmissions by strategically allocating care management resources to highest-vulnerability cohorts.

The analysis reveals that readmission risk is highly concentrated rather than uniformly distributed. Primary drivers include severe chronic conditions (such as Sepsis, COPD, and Heart Failure), mature adult age groups (ages 46–75), and post-acute facility transitions to Skilled Nursing Facilities (SNFs) and Home Health. Furthermore, extended length of stay alone does not eliminate post-discharge vulnerability, and increasing follow-up visit volume is ineffective without targeted clinical depth—specifically during key post-release touchpoints like visits 2 and 4.

By leveraging these data-driven insights, Health Flow Co. can transition from a passive, "one-size-fits-all" post-discharge model to an automated, precision-driven care strategy. Implementing automated EHR risk triggers, standardized warm handoffs to post-acute facilities, and dedicated nurse navigation for the 57.81% high-risk population will drive sustained reductions in avoidable readmissions while optimizing bed capacity and patient outcomes.





















