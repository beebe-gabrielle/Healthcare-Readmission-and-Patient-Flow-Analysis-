USE hospital_project;

-- adding column insurance_type_clean
ALTER TABLE hospital_readmission
ADD COLUMN insurance_type_clean VARCHAR(20);

-- setting data equal to insurance_type and formatting 
UPDATE hospital_readmission
SET insurance_type_clean = 
    CASE 
        -- replacing nulls with 'Unknown'
        WHEN insurance_type IS NULL THEN 'Unknown'
        
        -- trimming white space 
        WHEN TRIM(insurance_type) = '' THEN 'Unknown'
        
        -- standardizing insurance types
        WHEN LOWER(TRIM(insurance_type)) IN ('Mcaid', 'Med.') THEN 'Medicaid'
        WHEN LOWER(TRIM(insurance_type)) = ('Pvt.') THEN 'Private'
		WHEN LOWER(TRIM(insurance_type)) = ('uninsured') THEN 'Uninsured'
		WHEN LOWER(TRIM(insurance_type)) = ('MEDICARE') THEN 'Medicare'
        
        -- standardizing remaining values 
	    ELSE CONCAT(UPPER(LEFT(TRIM(insurance_type), 1)), LOWER(SUBSTRING(TRIM(insurance_type), 2)))
    END;

-- viewing distinct values
SELECT DISTINCT insurance_type_clean
FROM hospital_readmission
ORDER BY insurance_type_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE insurance_type_clean IS NULL OR insurance_type_clean = '';