USE hospital_project;

-- adding column 'age_clean'
ALTER TABLE hospital_readmission
ADD COLUMN age_clean INT;

-- setting data equal to age
UPDATE hospital_readmission
SET age_clean = age;

-- trimming whitespace
UPDATE hospital_readmission
SET age_clean = TRIM(age_clean);

-- removing outiers
UPDATE hospital_readmission
SET age_clean = NULL
WHERE age_clean > 120 OR age_clean <0;

-- viewing distinct values
SELECT DISTINCT age_clean
FROM hospital_readmission
ORDER BY age_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE age_clean IS NULL OR age_clean = '';


