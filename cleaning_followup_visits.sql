USE hospital_project;

-- adding column followup_visits_clean
ALTER TABLE hospital_readmission
ADD COLUMN followup_visits_clean INT;

-- setting data equal to followup_visits
UPDATE hospital_readmission
SET followup_visits_clean = followup_visits;

-- trimming whitespace
UPDATE hospital_readmission
SET followup_visits_clean = TRIM(followup_visits_clean);

-- viewing distinct values
SELECT DISTINCT followup_visits_clean
FROM hospital_readmission
ORDER BY followup_visits_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE followup_visits_clean IS NULL;
