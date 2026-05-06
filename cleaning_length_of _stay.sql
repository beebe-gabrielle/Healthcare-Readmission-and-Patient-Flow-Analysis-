USE hospital_project;

-- adding column 'comorbidities_count_clean'
ALTER TABLE hospital_readmission
ADD COLUMN length_of_stay_clean INT;

-- setting data equal to comorbidities_count
UPDATE hospital_readmission
SET length_of_stay_clean = length_of_stay;

-- trimming whitespace
UPDATE hospital_readmission
SET length_of_stay_clean = TRIM(length_of_stay_clean);

-- removing outiers
UPDATE hospital_readmission
SET length_of_stay_clean = NULL
WHERE length_of_stay_clean > 30 OR length_of_stay_clean <0;

-- viewing distinct values
SELECT DISTINCT length_of_stay_clean
FROM hospital_readmission
ORDER BY length_of_stay_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE length_of_stay_clean IS NULL OR length_of_stay_clean = '';