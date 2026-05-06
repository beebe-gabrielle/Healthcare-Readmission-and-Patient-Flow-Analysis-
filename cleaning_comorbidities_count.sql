USE hospital_project;

-- adding column 'comorbidities_count_clean'
ALTER TABLE hospital_readmission
ADD COLUMN comorbidities_count_clean INT;

-- setting data equal to comorbidities_count
UPDATE hospital_readmission
SET comorbidities_count_clean = comorbidities_count;

-- trimming whitespace
UPDATE hospital_readmission
SET comorbidities_count_clean = TRIM(comorbidities_count_clean);

-- viewing distinct values
SELECT DISTINCT comorbidities_count_clean
FROM hospital_readmission
ORDER BY comorbidities_count_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE comorbidities_count_clean IS NULL OR comorbidities_count_clean = '';

