USE hospital_project;

-- adding column treatment_type_clean
ALTER TABLE hospital_readmission
ADD COLUMN treatment_type_clean VARCHAR(20);

-- setting data equal to treatment_type
UPDATE hospital_readmission
SET treatment_type_clean = treatment_type;

-- trimming whitespace 
UPDATE hospital_readmission
SET treatment_type_clean = TRIM(treatment_type);

-- converting to title case
UPDATE hospital_readmission
SET treatment_type_clean = CONCAT(
	UPPER(LEFT(treatment_type_clean, 1)),
    LOWER(SUBSTRING(treatment_type_clean, 2))
    );

-- viewing distinct values
SELECT DISTINCT treatment_type_clean
FROM hospital_readmission
ORDER BY treatment_type_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE treatment_type_clean IS NULL OR treatment_type_clean = '';