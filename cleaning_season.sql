USE hospital_project;

-- adding column 'season_clean'
ALTER TABLE hospital_readmission
ADD COLUMN season_clean VARCHAR(20);

-- setting data equal to season 
UPDATE hospital_readmission
SET season_clean = season;

-- trimming whitespace 
-- normalizing casing
UPDATE hospital_readmission
SET season_clean = LOWER(TRIM(season));

-- converting to title case
UPDATE hospital_readmission
SET season_clean = CONCAT(
	UPPER(LEFT(season, 1)),
    LOWER(SUBSTRING(season, 2))
    );

-- viewing distinct values
SELECT DISTINCT season_clean
FROM hospital_readmission
ORDER BY season_clean;

-- viewing null values
SELECT COUNT(*) AS null_count
FROM hospital_readmission
WHERE season IS NULL OR season = '';