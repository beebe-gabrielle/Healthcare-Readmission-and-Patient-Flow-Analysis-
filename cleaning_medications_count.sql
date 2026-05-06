USE hospital_project;

-- adding column 'medications_count_clean'
ALTER TABLE hospital_readmission
ADD COLUMN medications_count_clean INT;

-- setting data equal to medications_count
UPDATE hospital_readmission
SET medications_count_clean = medications_count;

-- trimming whitespace
UPDATE hospital_readmission
SET medications_count_clean = TRIM(medications_count_clean);

-- viewing distinct values
SELECT DISTINCT medications_count_clean
FROM hospital_readmission
ORDER BY medications_count_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE medications_count_clean IS NULL OR medications_count_clean = '';