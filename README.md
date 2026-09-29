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
<img width="636" height="366" alt="image" src="https://github.com/user-attachments/assets/1c49e7c4-2742-4675-8b9e-91c358a0e7eb" />


## Key Insights

**Overall Readmissions:** Across the synthetic dataset, overall readmissions are elevated, showing a 77.68% readmission rate, an average length-of-stay (LOS) of 7.8 days, and an average risk score of 78.3%.

**Readmission risk is concentrated in chronic conditions:** Primary diagnoses such as Sepsis, COPD, Heart Failure, Stroke, and Chronic Kidney Disease lead the hospital in readmission rates, with each condition approaching or exceeding 80-90%.

**Post-discharge risk shifts heavily to Home Health and Skilled Nursing Facilities:** The majority of readmitted patients are discharged to Home Health services, followed by Skilled Nursing Facilities (SNF), while direct discharges to Home represent a minimal share of total readmissions. 

**Longer hospital stays correlate with higher readmission volume:** Readmission scales directly with stay duration, as Long Stay and Moderate Stay cohorts account for almost all readmissions, whereas Short Stay patients generate low readmissions.

**Readmissions peak among mature adult age groups:** The 61-75 age cohort accounts for the highest volume of readmissions, with the 46-60 age group following closely behind, while 0-18 and 19-30 age groups show minimal readmissions.

**Follow-up visits show specific operational intervention windows:** Readmissions are heavily concentrated among patients who complete 2 and 4 follow-up visits, identifying specific post-release touchpoints where care coordination or outpatient monitoring needs reinforcement. 

## Care Coordination & Post-Discharge Operations Dashboard 
*(Note: Dataset is synthetically generated for demonstration; baseline rates reflect simulated distributions rather than actual clinical performance).*
<p></p>
<img width="898" height="504" alt="image" src="https://github.com/user-attachments/assets/8158e29b-6e77-4181-9dc0-33c1aa40cbbe" />

## Key Insights 

**Follow-up volume alone does not prevent readmission:** Wile overall patient follow-up averages 3.65 visits, readmitted patients logged a slightly higher average of 3.90 visits. This indicates that post-discharge contact volume is less critical than the timing, clinical depth, and targeted nature of the care provided. 

**High concentration among specific discharge pathways:** Readmission risk scales sharply with stay duration across facility handoffs. Long stay patients discharged to Skilled Nursing Facilities (SNF) demonstrate the highest vulnerability (reaching up to 94% readmission), followed closely by long-stay Home Health discharges (81%).

**Payer disparities highlight systemic vulnerability:** Readmission rates vary substantially by coverage type, with Medicare beneficiaries demonstrating the highest overall rate, followed by Uninsured and Medicaid populations. Private insurance consistently exhibits the lowest relative readmission baseline.

**Compounding risk of medication burden & complexity:** High medication counts significantly elevate readmission rates even in low-comorbidity tiers. Patients with 5+ comorbidities combined with polypharmacy represent the highest operational risk cohort at 93.68%.

**Targeted resource allocation opportunity:** With 57.81% of overall discharges meeting high-risk criteria, care coordination teams can maximize impact by prioritizing outreach based on discharge pathway (SNF/Home Health) and polypharmacy rather than uniform follow-up scheduling.

## Recommendations

**1. Diagnosis & Age Cohorts:**
- Focus extra attention on patients with Chronic conditions like Sepsis, COPD, Heart Failure, Stroke, and Chronic Kidney Disease, as these diagnoses show the highest readmission rates (80-90%)
- Direct extra support to patients aged 61-75 (the largest group coming back) and 46-60 (the second largest)
- Use the hospital's computer system to automatically flag patients in these high-risk age and illness groups as soon as they are admitted so the care team can plan ahead.

**2. Discharge Disposition & Facility Transitions:**
- Standardize how patients are handed off to Skilled Nursing Facilities and Home Health services, as these two locations account for most readmissions.
- Make sure hospital doctors speak directly with staff at nursing homes or home health agencies before releasing a patient to ensure a clear care plan is shared.
- Reach out or check in on patients within 48-72 hours after they are sent to Home Health or nursing facilities to catch any health issues early.

**3. Length-of-Stay (LOS) Dynamics & Extended Stay Risks:**
- Long hospital stays alone do not stop patients from coming back, long-stay patients sent to nursing facilities (up to 94% readmission rate) and Home Health (81% rate) still face very high risk.
- Begin planning for a patient's release as soon as they enter the hospital rather than waiting until the end of a long stay.

**4. Strategic Resources Allocation & Care Coordination:**
- Having more appointments isn't enough on its own (readmitted patients actually had slightly more visits). Instead, make sure appointments (especially visits 2 and 4) focus on medicine adherence and specific health checks.
- Instead of giving every patient the same post-hospital support, focus specialized care managers on the 57.81% of patients at high-risk (especially those on Medicare, Medicaid, or uninsured patients)
- Ensure high-risk patients have a follow-up doctor or telehealth appointments booked within 7 days of leaving the hospital to address problems before they require another hospital stay.

## Conclusion 

This project highlights how data analytics can help hospital teams reduce patient readmissions by focusing resources where they are needed most.

The data shows that readmissions are not evenly spread across patients. Instead, they are heavily driven by specific high-risk groups: patients with severe chronic conditions (like Sepsis and Heart Failure), older age groups (ages 46-75), and patients discharged to external facilities like Skilled Nursing Facilities and Home Health. Furthermore, staying in the hospital longer does not guarantee a safe recovery on its own, and simply adding more follow-up visits isn't enough unless those visits focus on critical need like medication management. 

By using these insights, the hospital can move away from a "one-size-fits-all" approach. Instead, care teams can focus their time and budget on automated risk flagging, warm handoffs to nursing facilities, and specialized care management for the highes-risk 57% of patients. Taking these targeted steps will help improve patient health outcomes while reducing avoidable hospital reaadmissions. 





















