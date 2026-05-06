USE hospital_project;

-- adding column region_clean
ALTER TABLE hospital_readmission
ADD COLUMN region_clean VARCHAR(20);

-- setting data equal to region
UPDATE hospital_readmission
SET region_clean = region;

-- trimming whitespace 
UPDATE hospital_readmission
SET region_clean = TRIM(region_clean);

-- converting to title case
UPDATE hospital_readmission
SET region_clean = CONCAT(
	UPPER(LEFT(region_clean, 1)),
    SUBSTRING(region_clean, 2)
    );

-- verifying formatting
SELECT DISTINCT region_clean
FROM hospital_readmission
ORDER BY region_clean;

-- checking for nulls 
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE region_clean IS NULL OR region_clean = '';