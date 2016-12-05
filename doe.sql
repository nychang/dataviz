-- CREATE TABLE doe(
-- 	districtCode int,
-- 	employeeId varchar(20) NOT NULL	PRIMARY KEY,
-- 	lastName varchar(50),
-- 	firstName varchar(50),
-- 	motpPoints int,
-- 	motpRating varchar(20),
-- 	moslPointsState int,
-- 	moslRatingState varchar(20),
-- 	moslPointsLocal int,
-- 	moslRatingLocal varchar(20),
-- 	overallPoints int,
-- 	overallRating varchar(20)
-- );

-- COPY doe FROM '/Users/daianachang/learning-d3/doe.csv' DELIMITER ',' CSV HEADER;

-- Overall aggregates:
SELECT MIN(motpPoints) AS Min_MOTP, MAX(motpPoints) Max_MOTP, AVG(motpPoints) AS Avg_MOTP, SUM(motpPoints) AS Total_MOTP FROM doe;
SELECT MIN(moslPointsState) AS Min_MOSL_State, MAX(moslPointsState) Max_MOSL_State, AVG(moslPointsState) AS Avg_MOSL_State, SUM(moslPointsState) AS Total_MOSL_State FROM doe;
SELECT MIN(moslPointsLocal) AS Min_MOSL_Local, MAX(moslPointsLocal) Max_MOTSL_Local, AVG(moslPointsLocal) AS Avg_MOSL_Local, SUM(moslPointsLocal) AS Total_MOSL_Local FROM doe;
SELECT MIN(overallPoints) AS Min_Overall, MAX(overallPoints) Max_Overall, AVG(overallPoints) AS Avg_Overall, SUM(overallPoints) AS Total_Overall FROM doe;


SELECT COUNT(*) AS Num_MOTP_Effective FROM (SELECT * FROM doe WHERE motpRating = 'Effective') as foo;

SELECT districtCode, motpRating, COUNT(employeeId) AS Count_Of_Rating FROM doe GROUP BY districtCode, motpRating ORDER BY districtCode;

SELECT districtCode, COUNT(employeeId) AS Effective_Count FROM (SELECT * FROM doe WHERE motpRating = 'Effective') AS foo GROUP BY districtCode ORDER BY districtCode;

-- http://stackoverflow.com/questions/15689350/select-query-with-multiple-sub-queries-for-counts

-- MOTP Count
SELECT districtCode, 
SUM(CASE WHEN motpRating = 'Highly Ineffective' THEN 1 ELSE 0 END) AS Highly_Ineffective, 
SUM(CASE WHEN motpRating = 'Ineffective' THEN 1 ELSE 0 END) AS Ineffective, 
SUM(CASE WHEN motpRating = 'Developing' THEN 1 ELSE 0 END) AS Developing, 
SUM(CASE WHEN motpRating = 'Effective' THEN 1 ELSE 0 END) AS Effective, 
SUM(CASE WHEN motpRating = 'Highly Effective' THEN 1 ELSE 0 END) AS Highly_Effective,
COUNT(employeeId) AS Total
FROM doe GROUP BY districtCode ORDER BY districtCode;

-- Write results of above to file:
COPY (
SELECT districtCode, 
SUM(CASE WHEN motpRating = 'Highly Ineffective' THEN 1 ELSE 0 END) AS Highly_Ineffective, 
SUM(CASE WHEN motpRating = 'Ineffective' THEN 1 ELSE 0 END) AS Ineffective, 
SUM(CASE WHEN motpRating = 'Developing' THEN 1 ELSE 0 END) AS Developing, 
SUM(CASE WHEN motpRating = 'Effective' THEN 1 ELSE 0 END) AS Effective, 
SUM(CASE WHEN motpRating = 'Highly Effective' THEN 1 ELSE 0 END) AS Highly_Effective,
COUNT(employeeId) AS Total
FROM doe GROUP BY districtCode ORDER BY districtCode
) TO '/Users/daianachang/doe-dataviz/doe-stack-count-motp.csv' DELIMITER ',' CSV HEADER;

-- MOTP %
SELECT districtCode, 
100*SUM(CASE WHEN motpRating = 'Highly Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Ineffective, 
100*SUM(CASE WHEN motpRating = 'Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Ineffective, 
100*SUM(CASE WHEN motpRating = 'Developing' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Developing, 
100*SUM(CASE WHEN motpRating = 'Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Effective, 
100*SUM(CASE WHEN motpRating = 'Highly Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Effective
FROM doe GROUP BY districtCode ORDER BY districtCode;

-- -- Write results of above to file:
-- COPY (
-- SELECT districtCode, 
-- 100*SUM(CASE WHEN motpRating = 'Highly Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Ineffective, 
-- 100*SUM(CASE WHEN motpRating = 'Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Ineffective, 
-- 100*SUM(CASE WHEN motpRating = 'Developing' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Developing, 
-- 100*SUM(CASE WHEN motpRating = 'Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Effective, 
-- 100*SUM(CASE WHEN motpRating = 'Highly Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Effective
-- FROM doe GROUP BY districtCode ORDER BY districtCode
-- ) TO '/Users/daianachang/doe-dataviz/doe-stack-percent-motp.csv' DELIMITER ',' CSV HEADER;

-- MOSL State %
SELECT districtCode, 
100*SUM(CASE WHEN moslRatingState = 'Highly Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Ineffective, 
100*SUM(CASE WHEN moslRatingState = 'Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Ineffective, 
100*SUM(CASE WHEN moslRatingState = 'Developing' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Developing, 
100*SUM(CASE WHEN moslRatingState = 'Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Effective, 
100*SUM(CASE WHEN moslRatingState = 'Highly Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Effective
FROM doe GROUP BY districtCode ORDER BY districtCode;

-- -- Write results of above to file:
-- COPY (
-- SELECT districtCode, 
-- 100*SUM(CASE WHEN moslRatingState = 'Highly Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Ineffective, 
-- 100*SUM(CASE WHEN moslRatingState = 'Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Ineffective, 
-- 100*SUM(CASE WHEN moslRatingState = 'Developing' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Developing, 
-- 100*SUM(CASE WHEN moslRatingState = 'Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Effective, 
-- 100*SUM(CASE WHEN moslRatingState = 'Highly Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Effective
-- FROM doe GROUP BY districtCode ORDER BY districtCode
-- ) TO '/Users/daianachang/doe-dataviz/doe-stack-percent-mosl-state.csv' DELIMITER ',' CSV HEADER;


-- MOSL Local %
SELECT districtCode, 
100*SUM(CASE WHEN moslRatingLocal = 'Highly Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Ineffective, 
100*SUM(CASE WHEN moslRatingLocal = 'Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Ineffective, 
100*SUM(CASE WHEN moslRatingLocal = 'Developing' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Developing, 
100*SUM(CASE WHEN moslRatingLocal = 'Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Effective, 
100*SUM(CASE WHEN moslRatingLocal = 'Highly Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Effective
FROM doe GROUP BY districtCode ORDER BY districtCode;

-- -- Write results of above to file:
-- COPY (
-- SELECT districtCode, 
-- 100*SUM(CASE WHEN moslRatingLocal = 'Highly Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Ineffective, 
-- 100*SUM(CASE WHEN moslRatingLocal = 'Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Ineffective, 
-- 100*SUM(CASE WHEN moslRatingLocal = 'Developing' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Developing, 
-- 100*SUM(CASE WHEN moslRatingLocal = 'Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Effective, 
-- 100*SUM(CASE WHEN moslRatingLocal = 'Highly Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Effective
-- FROM doe GROUP BY districtCode ORDER BY districtCode
-- ) TO '/Users/daianachang/doe-dataviz/doe-stack-percent-mosl-local.csv' DELIMITER ',' CSV HEADER;












