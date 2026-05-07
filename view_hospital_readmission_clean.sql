CREATE VIEW hospital_readmission_clean AS
SELECT patient_id,
	   admission_date_clean,
       season_clean,
       age_clean,
       gender_clean,
       region_clean,
       primary_diagnosis_clean,
       comorbidities_count_clean,
       length_of_stay_clean,
       treatment_type_clean,
       medications_count_clean,
       followup_visits_clean,
       prev_readmission_clean,
       insurance_type_clean,
       label_clean
FROM hospital_readmission;

SELECT COUNT(*) 
FROM hospital_readmission_clean ;

SELECT *
FROM hospital_readmission_clean
WHERE patient_id = 'P03097';

