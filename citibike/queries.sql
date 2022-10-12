/* Common table expression to add description to gender values */
with t_1 as (SELECT *, CASE
            WHEN gender = 0 THEN 'unknown'
            WHEN gender = 1 THEN 'male'
            WHEN gender = 2 THEN 'female'
            END AS sex
            FROM bike_trips)

/*Aggregates the total riders by gender using previous CTE*/
SELECT sex, COUNT(total) as total_gender
FROM t_1
GROUP BY 1

/* Query to aggrergate the users by gender for each month*/
SELECT sex, DATE_TRUNC('month',start_time) AS months, COUNT(sex) AS total
FROM t_1
GROUP BY 1,2


/*Extracting the count of riders for each weekday based on user type*/
SELECT  EXTRACT(DOW from start_time) as day, COUNT(usertype),usertype
FROM bike_trips
WHERE EXTRACT(DOW from start_time) between 1 and 5 and usertype='Customer'
GROUP BY 1,3
ORDER BY 2

/*Compares average trip length for rides that start and end at the same station
with those that end at a different station */
SELECT ROUND(avg(tripduration_sec)/60) AS AVG_MINUTES, count(*) as num_rides, 'SAME' AS DESTINATION
FROM bike_trips
WHERE start_station_id=end_station_id and EXTRACT(DOW from start_time) between 1 and 5
UNION
SELECT ROUND(avg(tripduration_sec)/60) AS AVG_MINUTES, count(*) as num_rides, 'DIFFERENT' AS DESTINATION
FROM bike_trips
WHERE start_station_id<>end_station_id and EXTRACT(DOW from start_time) between 1 and 5