

----------------------Early aviation accident data analysing-----------------

SELECT * FROM [dbo].[airline_DB]

-- What was the total number of fatalities in accidents in each year?

SELECT Year, SUM(Fatalities) AS ' Total Fatalities each year'
FROM airline_DB
GROUP BY Year ORDER BY Year

---Top years for highest fatalities incidents

SELECT TOP 5 YEAR, SUM(Fatalities) AS 'Top Highest Fatalities' 
FROM airline_DB
GROUP BY Year ORDER BY SUM(Fatalities) desc

--What was the average number of fatalities per accident over the whole period?
-- To maintain less decimal numbers, the ROUND function is used

SELECT Year, ROUND(AVG(Fatalities),2) AS 'Average Fatalities By Years' 
FROM airline_DB
GROUP BY Year ORDER BY AVG(Fatalities) Desc


-- How many accidents occurred in military vs civilian flights?

SELECT * FROM [dbo].[airline_DB]

Exec sp_rename 'dbo.airline_db.Flight #', 'Flight_Number','Flight #'

---By using the '%' wildcard, we can identify the specific military term that we are searching for.

SELECT
  SUM(CASE WHEN Operator LIKE 'Military%' THEN 1 ELSE 0 END) AS Military_Accidents,
  SUM(CASE WHEN Operator NOT LIKE 'Military%' THEN 1 ELSE 0 END) AS Civilian_Accidents
FROM airline_db

-- What was the accident with the highest number of fatalities?

SELECT TOP 3 * FROM airline_DB
ORDER BY Fatalities Desc

--Which aircraft models were involved in more than one accident? 

SELECT Registration,COUNT(*) AS 'Aircraft Model'
FROM airline_DB
GROUP BY Registration
HAVING COUNT(*)>1 ORDER BY COUNT(*) Desc

-- What was the deadliest aviation accident in terms of both onboard and ground fatalities?

SELECT TOP 1 *,(Aboard + Ground) AS 'Total_Fatalities'
FROM airline_DB
ORDER BY Total_Fatalities Desc

---Deadliest aviation accident in respective of fatalities

SELECT TOP 1 * FROM airline_DB 
ORDER BY Fatalities Desc

--How many accidents involved airships (Zeppelin), and what was their average number of fatalities?

SELECT COUNT(*) AS 'Total Airship Accident',
	   avg(Fatalities) AS 'Average Fatalities' 
	   FROM airline_DB 
WHERE Type LIKE '%Zeppelin%'

----Which operator had the highest number of accidents, 
--and what was the most common aircraft type they operated?

SELECT TOP 5 Operator, 
			 COUNT(*) AS 'number of accidents',
		     MAX(Type) As 'Aircraft Type'
FROM airline_DB GROUP BY Operator ORDER BY COUNT(*) Desc

--What was the most common location for aviation accidents in the dataset?

SELECT TOP 1 Location,
			 COUNT(*) AS 'Total Accidents',
			 DENSE_RANK() OVER (ORDER BY COUNT(*) Desc) AS 'Accident_Rank'
FROM airline_DB
			 GROUP BY Location ORDER BY [Total Accidents] Desc

--How many accidents involved Airbus aircraft?

SELECT COUNT(*) AS 'Total Airbus Accidents'
FROM airline_DB 
WHERE Type Like '%Airbus%'

--Which year had the highest number of aviation accidents?

SELECT TOP 1 Year, COUNT(*) As 'Highest Accidents' 
FROM airline_DB
GROUP BY Year ORDER BY COUNT(*) Desc

--How many accidents occurred during test flights?

SELECT COUNT(*) AS 'Total Test Flight Accidents'
FROM airline_DB
WHERE Summary Like '%test flight%'