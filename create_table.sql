CREATE DATABASE hospital_project;

USE hospital_project;

CREATE TABLE hospital_readmission (
	patient_id VARCHAR(10),
    admission_date VARCHAR(50),
    season VARCHAR(20),
    age INT,
    gender VARCHAR(10),
    region VARCHAR(50),
    primary_diagnosis VARCHAR(100),
    comorbidities_count INT,
    length_of_stay INT,
    treatment_type VARCHAR(50),
    medications_count INT,
    followup_visits INT,
    prev_readmissions INT,
    insurance_type VARCHAR(50),
    discharge_disposition VARCHAR(50),
    readmission_risk_score VARCHAR(10),
    label VARCHAR(10)
);

SELECT * 
FROM hospital_readmission
LIMIT 5;