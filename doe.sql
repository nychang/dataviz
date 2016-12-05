-- https://data.cityofchicago.org/Transportation/CTA-Ridership-Avg-Weekday-Bus-Stop-Boardings-in-Oc/mq3i-nnqe

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

-- See how many stops have zero boardings:
-- SELECT COUNT(*) AS NumStopsWithMinBoardings FROM (SELECT * FROM doe WHERE boardings = (SELECT MIN(boardings) FROM doe)) AS foo;

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

-- -- Write results of above to file:
-- COPY (
-- SELECT districtCode, 
-- SUM(CASE WHEN motpRating = 'Highly Ineffective' THEN 1 ELSE 0 END) AS HI_Count, 
-- SUM(CASE WHEN motpRating = 'Ineffective' THEN 1 ELSE 0 END) AS I_Count, 
-- SUM(CASE WHEN motpRating = 'Developing' THEN 1 ELSE 0 END) AS D_Count, 
-- SUM(CASE WHEN motpRating = 'Effective' THEN 1 ELSE 0 END) AS E_Count, 
-- SUM(CASE WHEN motpRating = 'Highly Effective' THEN 1 ELSE 0 END) AS HE_Count 
-- FROM doe GROUP BY districtCode ORDER BY districtCode
-- ) TO '/Users/daianachang/learning-d3/doe-stack.csv' DELIMITER ',' CSV HEADER;

-- MOTP %
SELECT districtCode, 
100*SUM(CASE WHEN motpRating = 'Highly Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Ineffective, 
100*SUM(CASE WHEN motpRating = 'Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Ineffective, 
100*SUM(CASE WHEN motpRating = 'Developing' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Developing, 
100*SUM(CASE WHEN motpRating = 'Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Effective, 
100*SUM(CASE WHEN motpRating = 'Highly Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Effective
FROM doe GROUP BY districtCode ORDER BY districtCode;

-- Write results of above to file:
COPY (
SELECT districtCode, 
100*SUM(CASE WHEN motpRating = 'Highly Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Ineffective, 
100*SUM(CASE WHEN motpRating = 'Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Ineffective, 
100*SUM(CASE WHEN motpRating = 'Developing' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Developing, 
100*SUM(CASE WHEN motpRating = 'Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Effective, 
100*SUM(CASE WHEN motpRating = 'Highly Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Effective
FROM doe GROUP BY districtCode ORDER BY districtCode
) TO '/Users/daianachang/learning-d3/doe-stack-percent-motp.csv' DELIMITER ',' CSV HEADER;

-- MOSL State %
SELECT districtCode, 
100*SUM(CASE WHEN moslRatingState = 'Highly Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Ineffective, 
100*SUM(CASE WHEN moslRatingState = 'Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Ineffective, 
100*SUM(CASE WHEN moslRatingState = 'Developing' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Developing, 
100*SUM(CASE WHEN moslRatingState = 'Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Effective, 
100*SUM(CASE WHEN moslRatingState = 'Highly Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Effective
FROM doe GROUP BY districtCode ORDER BY districtCode;

-- Write results of above to file:
COPY (
SELECT districtCode, 
100*SUM(CASE WHEN moslRatingState = 'Highly Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Ineffective, 
100*SUM(CASE WHEN moslRatingState = 'Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Ineffective, 
100*SUM(CASE WHEN moslRatingState = 'Developing' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Developing, 
100*SUM(CASE WHEN moslRatingState = 'Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Effective, 
100*SUM(CASE WHEN moslRatingState = 'Highly Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Effective
FROM doe GROUP BY districtCode ORDER BY districtCode
) TO '/Users/daianachang/learning-d3/doe-stack-percent-mosl-state.csv' DELIMITER ',' CSV HEADER;


-- MOSL Local %
SELECT districtCode, 
100*SUM(CASE WHEN moslRatingLocal = 'Highly Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Ineffective, 
100*SUM(CASE WHEN moslRatingLocal = 'Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Ineffective, 
100*SUM(CASE WHEN moslRatingLocal = 'Developing' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Developing, 
100*SUM(CASE WHEN moslRatingLocal = 'Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Effective, 
100*SUM(CASE WHEN moslRatingLocal = 'Highly Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Effective
FROM doe GROUP BY districtCode ORDER BY districtCode;

-- Write results of above to file:
COPY (
SELECT districtCode, 
100*SUM(CASE WHEN moslRatingLocal = 'Highly Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Ineffective, 
100*SUM(CASE WHEN moslRatingLocal = 'Ineffective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Ineffective, 
100*SUM(CASE WHEN moslRatingLocal = 'Developing' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Developing, 
100*SUM(CASE WHEN moslRatingLocal = 'Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Effective, 
100*SUM(CASE WHEN moslRatingLocal = 'Highly Effective' THEN 1 ELSE 0 END)/CAST(COUNT(employeeId) AS FLOAT) AS Highly_Effective
FROM doe GROUP BY districtCode ORDER BY districtCode
) TO '/Users/daianachang/learning-d3/doe-stack-percent-mosl-local.csv' DELIMITER ',' CSV HEADER;

















-- -- Stop with most boardings:
-- SELECT stop_id, routes, on_street, boardings FROM doe WHERE boardings = (SELECT MAX(boardings) FROM doe) ORDER BY on_street;

-- -- Top 10 on-streets with most stops:
-- SELECT on_street, COUNT(stop_id) AS NumberOfStops FROM doe
-- GROUP BY on_street ORDER BY NumberOfStops DESC, on_street LIMIT 10;

-- -- Top 10 routes with most stops:
-- SELECT routes, COUNT(stop_id) AS NumberOfStops FROM doe
-- GROUP BY routes ORDER BY NumberOfStops DESC, routes LIMIT 10;

-- -- Top 10 routes with most boardings:
-- SELECT routes, SUM(boardings) AS TotalBoardings FROM doe
-- GROUP BY routes ORDER BY TotalBoardings DESC, routes LIMIT 10;

-- -- Top 10 routes with fewest boardings:
-- SELECT routes, SUM(boardings) AS TotalBoardings FROM doe
-- GROUP BY routes ORDER BY TotalBoardings, routes LIMIT 10;

-- -- Check how many routes are lists of multiple routes:
-- SELECT COUNT(*) AS MultipleRoutes FROM (SELECT routes FROM doe WHERE routes SIMILAR TO '%,%') AS foo;

-- -- SELECT regexp_split_to_array(routes, ',') AS RoutesArray FROM (SELECT routes FROM doe WHERE routes SIMILAR TO '%,%') AS foo;

-- -- CREATE TABLE doe2 AS SELECT stop_id, on_street, cross_street, regexp_split_to_array(routes, ',') AS RoutesArray, boardings, alightings FROM doe;

-- -- To find stop with most routes:
-- SELECT stop_id, array_length(RoutesArray, 1) AS NumOfRoutes, RoutesArray, on_street, cross_street FROM doe2 ORDER BY NumOfRoutes DESC LIMIT 20;

-- -- Compare number of routes:
-- SELECT NumOfRoutes, COUNT(stop_id) AS NumRoutesFreq FROM (SELECT stop_id, array_length(RoutesArray, 1) AS NumOfRoutes, RoutesArray, on_street, cross_street FROM doe2) AS foo GROUP BY NumOfRoutes ORDER BY NumRoutesFreq DESC;

-- -- Write results of above to file:
-- COPY (SELECT NumOfRoutes, COUNT(stop_id) AS NumRoutesFreq FROM (SELECT stop_id, array_length(RoutesArray, 1) AS NumOfRoutes, RoutesArray, on_street, cross_street FROM doe2) AS foo GROUP BY NumOfRoutes ORDER BY NumRoutesFreq DESC) TO '/Users/daianachang/Desktop/doe-routes-freq.csv' DELIMITER ',' CSV HEADER;

-- SELECT AVG(boardings) AS AvgBoardings, AVG(alightings) AS AvgAlightings FROM doe WHERE routes = '9';

-- SELECT COUNT(stop_id) FROM doe WHERE routes = '9';

-- SELECT stop_id, cross_street, boardings, alightings FROM doe WHERE routes = '9' AND boardings > (SELECT AVG(boardings) FROM doe WHERE routes = '9') ORDER BY boardings DESC;
