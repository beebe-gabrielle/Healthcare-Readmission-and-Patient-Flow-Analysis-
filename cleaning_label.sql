USE hospital_project;

-- adding column label_clean
ALTER TABLE hospital_readmission
ADD COLUMN label_clean TINYINT;

-- formatting string values to 1 (True) or 0 (False)
UPDATE hospital_readmission
SET label_clean = 
	CASE 
        -- foramtting True values
		WHEN LOWER(TRIM(label)) IN ('true', 'yes', '1', 'y', 't') THEN 1
        
        -- formatiing False values 
        WHEN LOWER(TRIM(label)) IN ('false', 'no', '0', 'n', 'f') THEN 0
        
        -- handling missing values
        ELSE NULL
	END;
    
-- viewing distinct values
SELECT DISTINCT label_clean
FROM hospital_readmission
ORDER BY label_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE label_clean IS NULL;
        
