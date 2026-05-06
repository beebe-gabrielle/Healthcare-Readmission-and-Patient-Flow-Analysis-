USE hospital_project;

-- adding column 'admission_date_clean'
ALTER TABLE hospital_readmission
ADD COLUMN admission_date_clean VARCHAR(20);

-- setting data equal to admission_date
UPDATE hospital_readmission
SET admission_date_clean = admission_date;

-- cleaning date formats 
UPDATE hospital_readmission
SET admission_date_clean = DATE_FORMAT(STR_TO_DATE(admission_date_clean, '%m/%d/%Y'), '%Y-%m-%d')
WHERE admission_date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$';

-- cleaning abbreviated months 
UPDATE hospital_readmission
SET admission_date_clean = DATE_FORMAT(STR_TO_DATE(admission_date, '%e-%b-%y'), '%Y-%m-%d')
WHERE admission_date REGEXP '^[0-9]{1,2}-[A-Za-z]+-[0-9]{2}$';

-- cleaning timestamps 
UPDATE hospital_readmission
SET admission_date_clean = DATE_FORMAT(STR_TO_DATE(admission_date, '%c/%e/%Y %H:%i'), '%Y-%m-%d')
WHERE admission_date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4} [0-9]{1,2}:[0-9]{2}$';

-- viewing distinct values
SELECT DISTINCT admission_date_clean
FROM hospital_readmission
ORDER BY admission_date_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE admission_date_clean IS NULL;