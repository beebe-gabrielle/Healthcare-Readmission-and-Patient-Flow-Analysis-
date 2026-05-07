-- 1. Creating database & tables
SOURCE create_table.sql;

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



-- 2. Cleaning column: admission date
SOURCE cleaning_admission_date.sql;

-- adding column admission_date_clean
ALTER TABLE hospital_readmission
ADD COLUMN admission_date_clean VARCHAR(20);

-- formatting data
UPDATE hospital_readmission
SET admission_date_clean = 
	CASE 
  		-- format MM/DD/YYYY (e.g., 08/24/2022)
    	WHEN admission_date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$' 
        THEN DATE_FORMAT(STR_TO_DATE(admission_date, '%m/%d/%Y'), '%Y-%m-%d')
    
    	-- format D-Mon-YY (e.g., 13-sep-21)
   		WHEN admission_date REGEXP '^[0-9]{1,2}-[A-Za-z]+-[0-9]{2}$' 
        THEN DATE_FORMAT(STR_TO_DATE(admission_date, '%e-%b-%y'), '%Y-%m-%d')
	
    	-- format M/D/YYYY H:MM (e.g., 3/23/2021 0:00)
    	WHEN admission_date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4} [0-9]{1,2}:[0-9]{2}$' 
        THEN DATE_FORMAT(STR_TO_DATE(admission_date, '%c/%e/%Y %H:%i'), '%Y-%m-%d')

    	-- fallback for nulls 
    	ELSE NULL 
	END;

-- viewing unique values
SELECT DISTINCT admission_date_clean
FROM hospital_readmission
ORDER BY admission_date_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE admission_date_clean IS NULL;



-- 3. Cleaning column: season
SOURCE cleaning_season.sql;

-- adding column 'season_clean'
ALTER TABLE hospital_readmission
ADD COLUMN season_clean VARCHAR(20);

-- formatting data
UPDATE hospital_readmission
SET season_clean = 
	CASE
    	-- handling nulls and blank strings
		WHEN season IS NULL OR TRIM(season) = '' THEN 'Unknown'
	
   		-- formatting remaining values
    	ELSE CONCAT(UPPER(LEFT(TRIM(season), 1)), LOWER(SUBSTRING(TRIM(season), 2)))
	END;

-- viewing unique values
SELECT DISTINCT season_clean
FROM hospital_readmission
ORDER BY season_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE season IS NULL;



-- 4. Cleaning column: age
SOURCE cleaning_age.sql;

-- adding column 'age_clean'
ALTER TABLE hospital_readmission
ADD COLUMN age_clean INT;

--formatting data
UPDATE hospital_readmission
SET age_clean = 
	CASE 
    	-- removing outliers
    	WHEN age > 120 OR age < 0 THEN NULL
    	ELSE age
	END;

-- viewing unique values
SELECT DISTINCT age_clean
FROM hospital_readmission
ORDER BY age_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE age_clean IS NULL;



-- 5. Cleaning column: gender
SOURCE cleaning_gender.sql;

-- adding column gender_clean
ALTER TABLE hospital_readmission
ADD COLUMN gender_clean VARCHAR(20);

-- formatting data
UPDATE hospital_readmission
SET gender_clean = 
	CASE
		WHEN LOWER(TRIM(gender)) IN ('m','male') THEN 'Male'
   		WHEN LOWER(TRIM(gender)) IN ('f','female') THEN 'Female'
    
  		  -- handling nulls
   		ELSE 'Unknown'
	END;
  
-- viewing unique values
SELECT DISTINCT gender_clean
FROM hospital_readmission;
  
-- viewing null values 
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE gender_clean IS NULL;



-- 6. Cleaning column: region
SOURCE cleaning_region.sql;

-- adding column region_clean
ALTER TABLE hospital_readmission
ADD COLUMN region_clean VARCHAR(20);

-- formatting data
UPDATE hospital_readmission
SET region_clean = 
	CASE
	-- handling nulls and blank strings
	WHEN region IS NULL OR TRIM(region) = '' THEN 'Unknown'
    
    -- formatting remaining values
    ELSE CONCAT(UPPER(LEFT(TRIM(region), 1)), LOWER(SUBSTRING(TRIM(region), 2)))
    END;

-- viewing unique values
SELECT DISTINCT region_clean
FROM hospital_readmission
ORDER BY region_clean;

-- viewing null values 
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE region_clean IS NULL;



-- 7. Cleaning column: primary_diagnosis
SOURCE cleaning_primary_diagnosis.sql;

-- adding column primary_diagnosis_clean
ALTER TABLE hospital_readmission
ADD COLUMN primary_diagnosis_clean VARCHAR(50);

-- formatting data
UPDATE hospital_readmission
SET primary_diagnosis_clean = 
    CASE 
        -- handling nulls and blank strings
        WHEN primary_diagnosis IS NULL OR TRIM(primary_diagnosis) = '' THEN 'Unknown'
        
        -- standardizing diagnosis terms
        WHEN LOWER(TRIM(primary_diagnosis)) IN ('appenditis', 'appy') THEN 'Appendicitis'
        WHEN LOWER(TRIM(primary_diagnosis)) IN ('ckd', 'kidney dis.', 'kidney disease') THEN 'Chronic Kidney Disease'
        WHEN LOWER(TRIM(primary_diagnosis)) = 'copd' THEN 'COPD'
        WHEN LOWER(TRIM(primary_diagnosis)) IN ('cva', 'stroke') THEN 'Stroke'
        WHEN LOWER(TRIM(primary_diagnosis)) IN ('diabetes', 'dm') THEN 'Diabetes'
        WHEN LOWER(TRIM(primary_diagnosis)) IN ('flu', 'influenza') THEN 'Influenza'
        WHEN LOWER(TRIM(primary_diagnosis)) IN ('fracture', 'fx') THEN 'Fracture'
        WHEN LOWER(TRIM(primary_diagnosis)) IN ('heart failure', 'hf') THEN 'Heart Failure'
        WHEN LOWER(TRIM(primary_diagnosis)) IN ('htn', 'hypertension') THEN 'Hypertension'
        WHEN LOWER(TRIM(primary_diagnosis)) IN ('pneum.', 'pneumonia') THEN 'Pneumonia'
        WHEN LOWER(TRIM(primary_diagnosis)) = 'sepsis' THEN 'Sepsis'
        
        -- formatting remaining values
        ELSE CONCAT(UPPER(LEFT(TRIM(primary_diagnosis), 1)), LOWER(SUBSTRING(TRIM(primary_diagnosis), 2)))
    END;

-- viewing unique values
SELECT DISTINCT primary_diagnosis_clean
FROM hospital_readmission
ORDER BY primary_diagnosis_clean;

-- viewing null values 
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE primary_diagnosis_clean IS NULL;



-- 8. Cleaning column: comorbidities_count
SOURCE cleaning_comorbidities_count.sql;

-- adding column 'comorbidities_count_clean'
ALTER TABLE hospital_readmission
ADD COLUMN comorbidities_count_clean INT;

-- setting data equal to comorbidities_count
UPDATE hospital_readmission
SET comorbidities_count_clean = comorbidities_count;

-- viewing unique values
SELECT DISTINCT comorbidities_count_clean
FROM hospital_readmission
ORDER BY comorbidities_count_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE comorbidities_count_clean IS NULL;



-- 9. Cleaning column: treatment_type
SOURCE cleaning_treatment_type.sql;

-- adding column treatment_type_clean
ALTER TABLE hospital_readmission
ADD COLUMN treatment_type_clean VARCHAR(20);

-- formatting data
UPDATE hospital_readmission
SET treatment_type_clean = 
	CASE 
		-- handling nulls and blank strings
		WHEN treatment_type IS NULL OR TRIM(treatment_type) = '' THEN 'Unknown'
    
		-- formatting remaining values
		ELSE CONCAT(UPPER(LEFT(TRIM(treatment_type), 1)), LOWER(SUBSTRING(TRIM(treatment_type), 2)))
	END;

-- viewing distinct values
SELECT DISTINCT treatment_type_clean
FROM hospital_readmission
ORDER BY treatment_type_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE treatment_type_clean IS NULL;



-- 10. Cleaning column: medications_count
SOURCE cleaning_medications_count.sql;

-- adding column 'medications_count_clean'
ALTER TABLE hospital_readmission
ADD COLUMN medications_count_clean INT;

-- setting data equal to medications_count
UPDATE hospital_readmission
SET medications_count_clean = medications_count;

-- viewing distinct values
SELECT DISTINCT medications_count_clean
FROM hospital_readmission
ORDER BY medications_count_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE medications_count_clean IS NULL;



-- 11. Cleaning column: medications_count
SOURCE cleaning_medications_count.sql;

-- adding column followup_visits_clean
ALTER TABLE hospital_readmission
ADD COLUMN followup_visits_clean INT;

-- setting data equal to followup_visits
UPDATE hospital_readmission
SET followup_visits_clean = followup_visits;

-- viewing distinct values
SELECT DISTINCT followup_visits_clean
FROM hospital_readmission
ORDER BY followup_visits_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE followup_visits_clean IS NULL;



-- 12. Cleaning column: followup_visits
SOURCE cleaning_followup_visits.sql;

-- adding column followup_visits_clean
ALTER TABLE hospital_readmission
ADD COLUMN followup_visits_clean INT;

-- setting data equal to followup_visits
UPDATE hospital_readmission
SET followup_visits_clean = followup_visits;

-- viewing distinct values
SELECT DISTINCT followup_visits_clean
FROM hospital_readmission
ORDER BY followup_visits_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE followup_visits_clean IS NULL;



-- 13. Cleaning column: prev_readmission
SOURCE cleaning_prev_readmission.sql;

-- adding column prev_readmission_clean
ALTER TABLE hospital_readmission
ADD COLUMN prev_readmission_clean INT;

-- setting data equal to prev_readmission
UPDATE hospital_readmission
SET prev_readmission_clean = prev_readmissions;

-- viewing distinct values
SELECT DISTINCT prev_readmission_clean
FROM hospital_readmission
ORDER BY prev_readmission_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE prev_readmission_clean IS NULL;



-- 14. Cleaning column: prev_readmission
SOURCE cleaning_prev_readmission.sql;

-- adding column insurance_type_clean
ALTER TABLE hospital_readmission
ADD COLUMN insurance_type_clean VARCHAR(20);

-- formatting data
UPDATE hospital_readmission
SET insurance_type_clean = 
    CASE 
        -- handling nulls and blank strings
        WHEN insurance_type IS NULL OR TRIM(insurance_type) = '' THEN 'Unknown'
        
        -- standardizing insurance types
        WHEN LOWER(TRIM(insurance_type)) IN ('Mcaid', 'Med.') THEN 'Medicaid'
        WHEN LOWER(TRIM(insurance_type)) = 'Pvt.' THEN 'Private'
		WHEN LOWER(TRIM(insurance_type)) = 'uninsured' THEN 'Uninsured'
		WHEN LOWER(TRIM(insurance_type)) = 'MEDICARE' THEN 'Medicare'
        
        -- formatting remaining values
	    ELSE CONCAT(UPPER(LEFT(TRIM(insurance_type), 1)), LOWER(SUBSTRING(TRIM(insurance_type), 2)))
    END;

-- viewing distinct values
SELECT DISTINCT insurance_type_clean
FROM hospital_readmission
ORDER BY insurance_type_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE insurance_type_clean IS NULL;



-- 15. Cleaning column: discharge_disposition
SOURCE cleaning_discharge_dispositionn.sql;

-- adding column discharge_disposition_clean
ALTER TABLE hospital_readmission
ADD COLUMN discharge_disposition_clean VARCHAR(50);

-- setting data equal to discharge_disposition and formatting  
UPDATE hospital_readmission
SET discharge_disposition_clean = 
    CASE 
        -- handling nulls and blank strings
        WHEN discharge_disposition IS NULL OR TRIM(discharge_disposition) = '' THEN 'Unknown'
        
        -- standardizing discharge types
        WHEN LOWER(TRIM(discharge_disposition)) = ('Rehab') THEN 'Rehabilitation'
		WHEN LOWER(TRIM(discharge_disposition)) = ('Home health') THEN 'Home Health'
        WHEN LOWER(TRIM(discharge_disposition)) IN ('skilled nursing', 'SNF') THEN 'Skilled Nursing Facility'
        
        -- standardizing remaining values 
	    ELSE CONCAT(UPPER(LEFT(TRIM(discharge_disposition), 1)), LOWER(SUBSTRING(TRIM(discharge_disposition), 2)))
    END;

-- viewing distinct values
SELECT DISTINCT discharge_disposition_clean
FROM hospital_readmission
ORDER BY discharge_disposition_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE discharge_disposition_clean IS NULL;



-- 16. Cleaning column: readmission_risk_score
SOURCE cleaning_readmission_risk_score.sql;

-- adding column readmission_risk_score_clean
ALTER TABLE hospital_readmission
ADD COLUMN readmission_risk_score_clean VARCHAR(20);

-- formatting data
UPDATE hospital_readmission
SET readmission_risk_score_clean = 
	CASE
		-- removing % sign and converting to decimal
		WHEN readmission_risk_score LIKE '%\%%' THEN CAST(REPLACE(readmission_risk_score, '%', '') AS DECIMAL(4,2)) / 100.0
		
        -- handling null and missing values 
        WHEN readmission_risk_score IS NULL OR TRIM(readmission_risk_score) = '' THEN NULL
        
        -- standardizing remaining values 
		ELSE CAST(readmission_risk_score AS DECIMAL(4,2))
	END;

-- changing data type to DECIMAL(4,2) 
ALTER TABLE hospital_readmission
MODIFY COLUMN readmission_risk_score_clean DECIMAL(4,2);

-- viewing distinct values
SELECT DISTINCT readmission_risk_score_clean
FROM hospital_readmission
ORDER BY readmission_risk_score_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE readmission_risk_score_clean IS NULL;



-- 17. Cleaning column: label
SOURCE cleaning_label.sql;

-- adding column label_clean
ALTER TABLE hospital_readmission
ADD COLUMN label_clean TINYINT;

-- formatting string values to 1 (True) or 0 (False)
UPDATE hospital_readmission
SET label_clean = 
	CASE 
        -- foramtting True values
		WHEN LOWER(TRIM(label)) IN ('true', 'yes', '1', 'y', 't') THEN 1
        
        -- formatiing False values 
        WHEN LOWER(TRIM(label)) IN ('false', 'no', '0', 'n', 'f') THEN 0
        
        -- handling missing values
        ELSE NULL
	END;
    
-- viewing distinct values
SELECT DISTINCT label_clean
FROM hospital_readmission
ORDER BY label_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE label_clean IS NULL;
