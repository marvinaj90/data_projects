/* Common table expression to add description to gender values */
with t_1 as (SELECT *, CASE
            WHEN gender = 0 THEN 'unknown'
            WHEN gender = 1 THEN 'male'
            WHEN gender = 2 THEN 'female'
            END AS sex
            FROM bike_trips)
SELECT sex, COUNT(total) as total_gender
FROM t_1
GROUP BY 1

/* Query to aggrergate the users by gender for each month*/
with t_1 as (SELECT *, CASE
            WHEN gender = 0 THEN 'unknown'
            WHEN gender = 1 THEN 'male'
            WHEN gender = 2 THEN 'female'
            END AS sex
            FROM bike_trips)
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
SELECT ROUND(avg(tripduration_sec)/60) AS avg_minutes, count(*) as num_rides, 'SAME' AS destination
FROM bike_trips
WHERE start_station_id=end_station_id and EXTRACT(DOW from start_time) between 1 and 5
UNION
SELECT ROUND(avg(tripduration_sec)/60) AS avg_minutes, count(*) as num_rides, 'DIFFERENT' AS destination
FROM bike_trips
WHERE start_station_id<>end_station_id and EXTRACT(DOW from start_time) between 1 and 5


/*Query to find the most active time and day for Subscribers and Customers */
WITH t1 as (SELECT usertype, extract(dow from start_time) as dayof_week,
			extract('hour' from start_time) as start_hr, COUNT(*) AS total_rides,
			Rank() OVER(PARTITION BY usertype order BY count(*) desc) as total_rank
FROM bike_trips
GROUP BY 1,2,3)
/*The above query ranks the count of riders split over the two groups of users
then it is filtered by rank*/
SELECT usertype, dayof_week, start_hr, total_rides, total_rank
FROM t1
WHERE total_rank = 1

/* Counts the users for each type by station */
SELECT start_station_name,COUNT(CASE WHEN usertype = 'Subscriber' THEN usertype END) as subscriber_count,
      COUNT(CASE WHEN usertype = 'Customer' THEN usertype END) as customer_count
FROM bike_trips
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10
