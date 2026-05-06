USE hospital_project;

-- adding column primary_diagnosis_clean
ALTER TABLE hospital_readmission
ADD COLUMN primary_diagnosis_clean VARCHAR(50);

-- setting data equal to primary_diagnosis
UPDATE hospital_readmission
SET primary_diagnosis_clean = primary_diagnosis;

-- formatting data
UPDATE hospital_readmission
SET primary_diagnosis_clean = 
    CASE 
        -- replacing nulls with 'Unknown'
        -- trimming white space 
        WHEN primary_diagnosis IS NULL THEN 'Unknown'
        WHEN TRIM(primary_diagnosis) = '' THEN 'Unknown'
        
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
        
        ELSE TRIM(primary_diagnosis)
    END;

-- verifying formatting
SELECT DISTINCT primary_diagnosis_clean
FROM hospital_readmission
ORDER BY primary_diagnosis_clean;

-- checking for nulls 
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE primary_diagnosis_clean IS NULL OR primary_diagnosis_clean = '';
