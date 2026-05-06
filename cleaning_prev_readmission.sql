USE hospital_project;

-- adding column prev_readmission_clean
ALTER TABLE hospital_readmission
ADD COLUMN prev_readmission_clean INT;

-- setting data equal to prev_readmission
UPDATE hospital_readmission
SET prev_readmission_clean = prev_readmissions;

-- trimming whitespace
UPDATE hospital_readmission
SET prev_readmission_clean = TRIM(prev_readmission_clean);

-- viewing distinct values
SELECT DISTINCT prev_readmission_clean
FROM hospital_readmission
ORDER BY prev_readmission_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE prev_readmission_clean IS NULL OR prev_readmission_clean = '';
