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
SOURCE cleaning_admission_date.sql

-- adding column admission_date_clean
ALTER TABLE hospital_readmission
ADD COLUMN admission_date_clean VARCHAR(20);

-- formatting data
UPDATE hospital_readmission
SET admission_date_clean = CASE 

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

-- verifying unique values 
SELECT DISTINCT admission_date_clean
FROM hospital_readmission
ORDER BY admission_date_clean;

-- checking for nulls 
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE admission_date_clean IS NULL;



-- 3. Cleaning column: season
SOURCE cleaning_season.sql

-- adding column 'season_clean'
ALTER TABLE hospital_readmission
ADD COLUMN season_clean VARCHAR(20);

-- formatting data
UPDATE hospital_readmission
SET season_clean = CASE

    -- handling nulls and blank strings
	WHEN season IS NULL OR TRIM(season) = '' THEN 'Unkown'
    
    -- formatting remaining values
    ELSE CONCAT(UPPER(LEFT(TRIM(season), 1)), LOWER(SUBSTRING(TRIM(season), 2)))
END;

-- viewing distinct values
SELECT DISTINCT season_clean
FROM hospital_readmission
ORDER BY season_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE season IS NULL OR season = '';


-- 3. Cleaning column: age
SOURCE cleaning_age.sql

-- adding column 'age_clean'
ALTER TABLE hospital_readmission
ADD COLUMN age_clean INT;

--formatting data
UPDATE hospital_readmission
SET age_clean = CASE 
	
    -- removing outliers
    WHEN age > 120 OR age < 0 THEN NULL
    ELSE age
END;

-- viewing distinct values
SELECT DISTINCT age_clean
FROM hospital_readmission
ORDER BY age_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE age_clean IS NULL;



-- 4. Cleaning column: gender
SOURCE cleaning_gender.sql;

-- adding column gender_clean
ALTER TABLE hospital_readmission
ADD COLUMN gender_clean VARCHAR(20);

-- formatting data
UPDATE hospital_readmission
SET gender_clean = CASE
	WHEN LOWER(TRIM(gender)) IN ('M','m','male','MALE') THEN 'Male'
    WHEN LOWER(TRIM(gender)) IN ('F','f','female','FEMALE') THEN 'Female'
    
    -- handling nulls
    ELSE 'Unknown'
END;
  
-- verifying unique values
SELECT DISTINCT gender_clean
FROM hospital_readmission;
  
-- checking for nulls 
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE gender_clean IS NULL;



-- 5. Cleaning column: region
SOURCE cleaning_region.sql;

-- adding column region_clean
ALTER TABLE hospital_readmission
ADD COLUMN region_clean VARCHAR(20);

-- formatting data
UPDATE hospital_readmission
SET region_clean = CASE

	-- handling nulls and blank strings
	WHEN region IS NULL OR TRIM(region) = '' THEN 'Unkown'
    
    -- formatting remaining values
    ELSE CONCAT(UPPER(LEFT(TRIM(region), 1)), LOWER(SUBSTRING(TRIM(region), 2)))
    END;

-- verifying formatting
SELECT DISTINCT region_clean
FROM hospital_readmission
ORDER BY region_clean;

-- checking for nulls 
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE region_clean IS NULL;





