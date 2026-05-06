USE hospital_project;

-- adding column discharge_disposition_clean
ALTER TABLE hospital_readmission
ADD COLUMN discharge_disposition_clean VARCHAR(50);

-- setting data equal to discharge_disposition and formatting  
UPDATE hospital_readmission
SET discharge_disposition_clean = 
    CASE 
        -- replacing nulls with 'Unknown'
        -- trimming white space 
        WHEN discharge_disposition IS NULL THEN 'Unknown'
        WHEN TRIM(discharge_disposition) = '' THEN 'Unknown'
        
        -- standardizing insurance types
        WHEN LOWER(TRIM(discharge_disposition)) = ('Rehab') THEN 'Rehabilitation'
		WHEN LOWER(TRIM(discharge_disposition)) = ('Home health') THEN 'Home Health'
        WHEN LOWER(TRIM(discharge_disposition)) IN ('skilled nursing', 'SNF') THEN 'Skilled Nursing Facility'
        
        -- standardizing remaining values 
	    ELSE CONCAT(UPPER(LEFT(TRIM(discharge_disposition), 1)), LOWER(SUBSTRING(TRIM(discharge_disposition), 2)))
    END;

-- viewing distinct values
SELECT DISTINCT discharge_disposition_clean
FROM hospital_readmission
ORDER BY discharge_disposition_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE discharge_disposition_clean IS NULL OR discharge_disposition_clean = '';