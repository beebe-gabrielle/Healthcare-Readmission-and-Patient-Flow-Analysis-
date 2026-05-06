USE hospital_project;

-- adding column readmission_risk_score_clean
ALTER TABLE hospital_readmission
ADD COLUMN readmission_risk_score_clean VARCHAR(20);

-- setting data equal to readmission_risk_score and formatting  
UPDATE hospital_readmission
SET readmission_risk_score_clean = 
	CASE
		-- removing % sign and converting to decimal
		WHEN readmission_risk_score LIKE '%\%%' THEN CAST(REPLACE(readmission_risk_score, '%', '') AS DECIMAL(4,2)) / 100.0
		
        -- handling null and missing values 
        WHEN readmission_risk_score IS NULL OR TRIM(readmission_risk_score) = '' THEN NULL
        
        -- standardizing remaining values 
		ELSE CAST(readmission_risk_score AS DECIMAL(4,2))
	END;

-- changing data type to DECIMAL(4,2) 
ALTER TABLE hospital_readmission
MODIFY COLUMN readmission_risk_score_clean DECIMAL(4,2);

-- viewing distinct values
SELECT DISTINCT readmission_risk_score_clean
FROM hospital_readmission
ORDER BY readmission_risk_score_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE readmission_risk_score_clean IS NULL;
