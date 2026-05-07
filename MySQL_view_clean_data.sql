-- creating view of updated, clean data 
CREATE VIEW hospital_readmission_clean AS
SELECT patient_id,
	   admission_date_clean AS admission_date,
       season_clean AS season,
       age_clean AS age,
       gender_clean AS gender,
       region_clean AS region,
       primary_diagnosis_clean AS primary_diagnosis,
       comorbidities_count_clean AS comorbidities_count,
       length_of_stay_clean AS length_of_stay,
       treatment_type_clean AS treatment_type,
       medications_count_clean AS medications_count,
       followup_visits_clean AS followup_visits,
       prev_readmission_clean AS prev_readmissions,
       insurance_type_clean AS  insurance_type,
       label_clean AS label
FROM hospital_readmission;


