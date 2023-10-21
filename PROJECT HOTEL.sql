use theap44a_hotel;

SELECT * FROM hotel2018;
SELECT * FROM hotel2019;
SELECT * FROM hotel2020;
SELECT * FrOM market_segment;
SELECT * FROM meal_cost;


-- ****************************
-- EXPLORATION
-- ****************************
-- Tables  hotel2018, hotel2019, hotel2020, market_segment, meal_cost
-- ****************************

-- no of booking AND cancelled
SELECT arrival_date_year, count(*) as booked    -- booked 2018
FROM hotel2018;

SELECT arrival_date_year, count(*) as booked
FROM hotel2018 where is_canceled = 1;           -- cancelled 2018


SELECT arrival_date_year, count(*) as booked     -- booked 2019
FROM hotel2019;

SELECT arrival_date_year, count(*) as booked
FROM hotel2019 where is_canceled = 1;              -- cancelled 2019

SELECT arrival_date_year, count(*) as booked        -- booked 2020
FROM hotel2020;

SELECT arrival_date_year, count(*) as booked
FROM hotel2020 where is_canceled = 1;              -- cancelled 2020

-- no of booking by hotel
SELECT hotel, count(*) as booked
FROM hotel2018
GROUP BY hotel;

SELECT hotel, count(*) as booked
FROM hotel2019
GROUP BY hotel;

SELECT hotel, count(*) as booked
FROM hotel2020
GROUP BY hotel;

-- combining discount
SELECT
    *, market_segment.discount
FROM hotel2018
inner join market_segment on hotel2018.market_segment = market_segment.market_segment;

-- checking duplicates
select distinct arrival_date_year from hotel2018;
select distinct arrival_date_year from hotel2019;
select distinct arrival_date_year from hotel2020;
select distinct year(reservation_status_date) from hotel2018;
select distinct year(reservation_status_date) from hotel2019;
select distinct year(reservation_status_date) from hotel2020;

-- EXPLORATION ENDS
-- **************************** 




-- 1.Is hotel revenue increasing year on year?

-- ROUGH WORK
-- revenue in 2018

SELECT
    SUM(adr * (stays_in_weekend_nights + stays_in_week_nights)) AS total_revenue_2018
FROM hotel2018;

SELECT
  hotel2018.arrival_date_year, sum(hotel2018.adr * (hotel2018.stays_in_weekend_nights + hotel2018.stays_in_week_nights) + 
    (meal_cost.cost *(hotel2018.adults + hotel2018. children + hotel2018.babies) * (hotel2018.stays_in_weekend_nights + hotel2018.stays_in_week_nights)) *
    (1 - market_segment.discount))
    AS total_revenue_2018
FROM hotel2018
inner join market_segment on hotel2018.market_segment = market_segment.market_segment
inner join meal_cost on hotel2018.meal = meal_cost.meal;

-- revenue in 2019
SELECT
  hotel2019.arrival_date_year, sum(hotel2019.adr * (hotel2019.stays_in_weekend_nights + hotel2019.stays_in_week_nights) + 
    (meal_cost.cost *(hotel2019.adults + hotel2019. children + hotel2019.babies) * (hotel2019.stays_in_weekend_nights + hotel2019.stays_in_week_nights)) *
    (1 - market_segment.discount))
    AS total_revenue_2019
FROM hotel2019
inner join market_segment on hotel2019.market_segment = market_segment.market_segment
inner join meal_cost on hotel2019.meal = meal_cost.meal;

-- revenue in 2020
SELECT
  hotel2020.arrival_date_year, sum(hotel2020.daily_room_rate * (hotel2020.stays_in_weekend_nights + hotel2020.stays_in_week_nights) + 
    (meal_cost.cost *(hotel2020.adults + hotel2020. children + hotel2020.babies) * (hotel2020.stays_in_weekend_nights + hotel2020.stays_in_week_nights)) *
    (1 - market_segment.discount))
    AS total_revenue_2020
FROM hotel2020
inner join market_segment on hotel2020.market_segment = market_segment.market_segment
inner join meal_cost on hotel2020.meal = meal_cost.meal;


-- finalized revenue query for total revenue
-- ANSWER
------------      ----------------------------------    -------------------------------   -------------------------

-- TOTAL revenue FOR 3 YEARS
SELECT SUM(total_revenue) AS whole_revenue FROM(
SELECT
  hotel2018.arrival_date_year AS year, sum(hotel2018.adr * (hotel2018.stays_in_weekend_nights + hotel2018.stays_in_week_nights) + 
    (meal_cost.cost *(hotel2018.adults + hotel2018. children + hotel2018.babies) * (hotel2018.stays_in_weekend_nights + hotel2018.stays_in_week_nights)) *
    (1 - market_segment.discount))
    AS total_revenue
FROM hotel2018
inner join market_segment on hotel2018.market_segment = market_segment.market_segment
inner join meal_cost on hotel2018.meal = meal_cost.meal
UNION ALL 
SELECT
  hotel2019.arrival_date_year, sum(hotel2019.adr * (hotel2019.stays_in_weekend_nights + hotel2019.stays_in_week_nights) + 
    (meal_cost.cost *(hotel2019.adults + hotel2019. children + hotel2019.babies) * (hotel2019.stays_in_weekend_nights + hotel2019.stays_in_week_nights)) *
    (1 - market_segment.discount))
    AS total_revenue
FROM hotel2019
inner join market_segment on hotel2019.market_segment = market_segment.market_segment
inner join meal_cost on hotel2019.meal = meal_cost.meal
UNION ALL
SELECT
  hotel2020.arrival_date_year, sum(hotel2020.daily_room_rate * (hotel2020.stays_in_weekend_nights + hotel2020.stays_in_week_nights) + 
    (meal_cost.cost *(hotel2020.adults + hotel2020. children + hotel2020.babies) * (hotel2020.stays_in_weekend_nights + hotel2020.stays_in_week_nights)) *
    (1 - market_segment.discount))
    AS total_revenue
FROM hotel2020
inner join market_segment on hotel2020.market_segment = market_segment.market_segment
inner join meal_cost on hotel2020.meal = meal_cost.meal) AS whole_revenue;

-- finalized query REVENUE BY YEAR

SELECT
  hotel2018.arrival_date_year AS year, sum(hotel2018.adr * (hotel2018.stays_in_weekend_nights + hotel2018.stays_in_week_nights) + 
    (meal_cost.cost *(hotel2018.adults + hotel2018. children + hotel2018.babies) * (hotel2018.stays_in_weekend_nights + hotel2018.stays_in_week_nights)) *
    (1 - market_segment.discount))
    AS total_revenue
FROM hotel2018
inner join market_segment on hotel2018.market_segment = market_segment.market_segment
inner join meal_cost on hotel2018.meal = meal_cost.meal
UNION ALL 
SELECT
  hotel2019.arrival_date_year, sum(hotel2019.adr * (hotel2019.stays_in_weekend_nights + hotel2019.stays_in_week_nights) + 
    (meal_cost.cost *(hotel2019.adults + hotel2019. children + hotel2019.babies) * (hotel2019.stays_in_weekend_nights + hotel2019.stays_in_week_nights)) *
    (1 - market_segment.discount))
    AS total_revenue
FROM hotel2019
inner join market_segment on hotel2019.market_segment = market_segment.market_segment
inner join meal_cost on hotel2019.meal = meal_cost.meal
UNION ALL
SELECT
  hotel2020.arrival_date_year, sum(hotel2020.daily_room_rate * (hotel2020.stays_in_weekend_nights + hotel2020.stays_in_week_nights) + 
    (meal_cost.cost *(hotel2020.adults + hotel2020. children + hotel2020.babies) * (hotel2020.stays_in_weekend_nights + hotel2020.stays_in_week_nights)) *
    (1 - market_segment.discount))
    AS total_revenue
FROM hotel2020
inner join market_segment on hotel2020.market_segment = market_segment.market_segment
inner join meal_cost on hotel2020.meal = meal_cost.meal;

------------      ----------------------------------    -------------------------------   -------------------------
-- 5.Are families with kids more likely to cancel the hotel booking?
-- ROUGH WORK
-- FOR 2018
SELECT
    CASE
        WHEN children > 0 or babies > 0 or children > 0 THEN 'With Kids'
        ELSE 'Without Kids'
    END AS family_type,
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS canceled_bookings,
    SUM(is_canceled) / COUNT(*) AS cancellation_rate
FROM hotel2018
GROUP BY family_type;

-- ANSWER
-----------------        --------------          ---------------        -----------------
-- COMBINED
SELECT
    CASE
        WHEN children > 0 or babies > 0 or children > 0 THEN 'With Kids'
        ELSE 'Without Kids'
    END AS family_type,
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS canceled_bookings,
    SUM(is_canceled) / COUNT(*) AS cancellation_rate
FROM (
    SELECT * FROM hotel2018
    UNION ALL
    SELECT * FROM hotel2019
    UNION ALL
    SELECT * FROM hotel2020
) AS com_hotel_data
GROUP BY family_type;

--------------       -----------------        ---------------- ---------------------------
-- 4.When are people cancelling the most?
-- rough work
-- for 2018
SELECT
    arrival_date_year AS year,
    arrival_date_month AS month,
    COUNT(*) AS cancel_count
FROM hotel2018
WHERE is_canceled = 1
GROUP BY month
ORDER BY cancel_count;

-- for 2019
SELECT
    arrival_date_year AS year,
    arrival_date_month AS month,
    COUNT(*) AS cancel_count
FROM hotel2019
WHERE is_canceled = 1
GROUP BY year, month
ORDER BY cancel_count;

-- for 2020

SELECT
    arrival_date_year AS year,
    arrival_date_month AS month,
    COUNT(*) AS cancel_count
FROM hotel2020
WHERE is_canceled = 1
GROUP BY year, month
ORDER BY cancel_count;

-- combined by month
SELECT
    arrival_date_year AS year,
    arrival_date_month AS month,
    COUNT(*) AS cancel_count
FROM (
    SELECT arrival_date_year, arrival_date_month
    FROM hotel2018
    WHERE is_canceled = 1
    UNION ALL
    SELECT arrival_date_year, arrival_date_month
    FROM hotel2019
    WHERE is_canceled = 1
    UNION ALL
    SELECT arrival_date_year, arrival_date_month
    FROM hotel2020
    WHERE is_canceled = 1
) AS combined_canceled_data
GROUP BY year, month
ORDER BY year, cancel_count;

-- ANSWER
-------------         --------------------        --------------------    ------------------
-- finalized query by month

SELECT
    arrival_date_year AS year,
    arrival_date_month AS month,
    COUNT(*) AS cancel_count
FROM (
select * from hotel2018
WHERE is_canceled = 1
UNION ALL
select * from hotel2019
WHERE is_canceled = 1
UNION ALL
select * from hotel2020
WHERE is_canceled = 1
) AS combined_cancel
GROUP BY year, month
ORDER BY year, cancel_count;

-- finalized query by year

SELECT
    arrival_date_year AS year,

    COUNT(*) AS cancel_count
FROM (
select * from hotel2018
WHERE is_canceled = 1
UNION ALL
select * from hotel2019
WHERE is_canceled = 1
UNION ALL
select * from hotel2020
WHERE is_canceled = 1
) AS combined_cancel
GROUP BY year
ORDER BY year;
---------------- ---------------------------   ---------------------------    ------------------

-- 3.When is the hotel at maximum occupancy? Is the period consistent across the years?
-- rough work
SELECT
        arrival_date_year,
        arrival_date_month,
        count(*) AS occupancy
    FROM hotel2018 WHERE is_canceled = 0
    GROUP BY arrival_date_month;
    
    
-- for 2018
SELECT
    arrival_date_year AS year,
    arrival_date_month AS month,
    (SUM(adults) + SUM(children) + SUM(babies)) AS occupancy
FROM 
    hotel2018 
    GROUP BY year, month
    ORDER BY year, occupancy DESC;

-- for 2019

SELECT
    arrival_date_year AS year,
    arrival_date_month AS month,
    count(*) AS occupancy
    FROM hotel2019 WHERE is_canceled = 0
    GROUP BY year, month
    ORDER BY year, occupancy DESC;

-- for 2020

SELECT
    arrival_date_year AS year,
    arrival_date_month AS month,
    count(*) AS occupancy
    FROM hotel2020 WHERE is_canceled = 0
    GROUP BY year, month
    ORDER BY year, occupancy DESC;


-- ANSWER
---------------     ------------------         -------------------        -------------------------
-- combined  BY MONTH
SELECT
    arrival_date_year AS year,
    arrival_date_month AS month,
    count(*)  AS occupancy
FROM (
    SELECT * FROM hotel2018
    WHERE is_canceled = 0
	UNION ALL
    SELECT * FROM hotel2019   
    WHERE is_canceled = 0
    UNION ALL
    SELECT * FROM hotel2020
   WHERE is_canceled = 0
) AS occupancy_TOT
GROUP BY year, month
ORDER BY year, occupancy DESC;

-- COMBINED BY YEAR

SELECT
    arrival_date_year AS year,
     count(*)  AS occupancy
FROM (
    SELECT * FROM hotel2018
    WHERE is_canceled = 0
	UNION ALL
    SELECT * FROM hotel2019   
    WHERE is_canceled = 0
    UNION ALL
    SELECT * FROM hotel2020
   WHERE is_canceled = 0  
) AS occupancy_TOT
GROUP BY year
ORDER BY year, occupancy DESC;

-------------------        ---------------------           --------------------            -------------- 

-- 2. What market segment are major contributors of the revenue per year? In there a change year on year?
-- rough work modified the 1st question query

-- ANSWER
-------------------- -------------------------      -----------------------           -----------
-- for 2018
SELECT
   arrival_date_year AS year,
   market_segment,
    SUM(revenue) AS total_revenue
FROM (
    SELECT
        hotel2018.arrival_date_year,
        hotel2018.market_segment,
          sum(hotel2018.adr * (hotel2018.stays_in_weekend_nights + hotel2018.stays_in_week_nights) + 
          (meal_cost.cost *(hotel2018.adults + hotel2018. children + hotel2018.babies) * (hotel2018.stays_in_weekend_nights + hotel2018.stays_in_week_nights)) *
          (1 - market_segment.discount))
    AS revenue
FROM hotel2018
         inner join market_segment on hotel2018.market_segment = market_segment.market_segment
         inner join meal_cost on hotel2018.meal = meal_cost.meal
    GROUP BY  hotel2018.market_segment
) AS combined_data
    GROUP BY market_segment
	ORDER BY  revenue DESC
    limit 3;

-- for 2019
SELECT
   arrival_date_year AS year,
   market_segment,
    SUM(revenue) AS total_revenue
FROM (
    SELECT
        hotel2019.arrival_date_year,
        hotel2019.market_segment,
         sum(hotel2019.adr * (hotel2019.stays_in_weekend_nights + hotel2019.stays_in_week_nights) + 
         (meal_cost.cost *(hotel2019.adults + hotel2019. children + hotel2019.babies) * (hotel2019.stays_in_weekend_nights + hotel2019.stays_in_week_nights)) *
         (1 - market_segment.discount))
    AS revenue
FROM hotel2019
       inner join market_segment on hotel2019.market_segment = market_segment.market_segment
	   inner join meal_cost on hotel2019.meal = meal_cost.meal
    GROUP BY  hotel2019.market_segment
) AS combined_data
    GROUP BY market_segment
    ORDER BY  revenue DESC
     limit 3;


-- for 2020

SELECT
   arrival_date_year AS year,
   market_segment,
    SUM(revenue) AS total_revenue
FROM (
    SELECT
        hotel2020.arrival_date_year,
        hotel2020.market_segment,
              sum(hotel2020.daily_room_rate * (hotel2020.stays_in_weekend_nights + hotel2020.stays_in_week_nights) + 
               (meal_cost.cost *(hotel2020.adults + hotel2020. children + hotel2020.babies) * (hotel2020.stays_in_weekend_nights + hotel2020.stays_in_week_nights)) *
               (1 - market_segment.discount))
    AS revenue
FROM hotel2020
      inner join market_segment on hotel2020.market_segment = market_segment.market_segment
      inner join meal_cost on hotel2020.meal = meal_cost.meal
    GROUP BY  hotel2020.market_segment
) AS combined_data
    GROUP BY market_segment
	ORDER BY  revenue DESC
     limit 3;


---------------- -------------------- ---------------------------- ---------------


















