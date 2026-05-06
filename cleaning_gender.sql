USE hospital_project;

-- adding column gender_clean
ALTER TABLE hospital_readmission
ADD COLUMN gender_clean VARCHAR(20);

-- setting data equal to gender
UPDATE hospital_readmission
SET gender_clean = gender;

-- trimming whitespace 
UPDATE hospital_readmission
SET gender_clean = TRIM(gender_clean);

-- formatting data
UPDATE hospital_readmission
SET gender_clean = 'Male'
WHERE gender IN ('M','m','male','MALE');

-- formatting data
UPDATE hospital_readmission
SET gender_clean = 'Female' 
WHERE gender IN ('F','f','female','FEMALE');
  
-- verifying formatting
SELECT DISTINCT gender_clean
FROM hospital_readmission
LIMIT 10;
  
-- checking for nulls 
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE gender_clean IS NULL OR gender_clean = '';

