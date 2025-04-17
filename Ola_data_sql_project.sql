use ola;
ALTER TABLE ola_table Rename Ola_rides ;
select *  from ola_rides;

SHOW CREATE TABLE ola_rides;
ALTER TABLE ola_rides
DROP COLUMN `MyUnknownColumn_[0]`;
-- Retrieve all successful bookings 
select * from ola_rides where booking_status = "Success" ;
-- 2.Find the total number of rides for each booking status
select Booking_status,  Count(*) As Total_Rides from ola_rides Group by Booking_status ;
-- 3.Count the total number of rides booked by each customer.
select   Customer_ID ,count(*) As Total_Rides  from ola_rides Group by Customer_ID Order by Total_Rides DESC;
-- 4.List all rides for a specific vehicle type (e.g., Mini).
select * from ola_rides where Vehicle_Type = "Mini";
-- 5. Retrieve the top 5 most common pickup locations.alter
select pickup_Location,count(*) as Total from  ola_rides Group by pickup_Location order by Total desc limit 5;
--  6.Find the total number of rides per vehicle type .
select Vehicle_type, count(*) as Total_Rides from ola_rides  Group by vehicle_type order by Total_Rides Desc;
-- 7.Retrieve all rides canceled by drivers.
select * from ola_rides where Booking_status = 'canceled by Driver';
 -- 8.Count the total number of rides where the drop location is "Koramangala."
 select Drop_Location ,count(*) as Rides_to_Koramangala from ola_rides where Drop_Location = "Koramangala";
 -- 9.List the 10 most frequent pickup-to-drop location pairs.
SELECT a.Pickup_Location, a.Drop_Location, COUNT(*) AS Total 
FROM ola_rides as a
GROUP BY Pickup_Location, Drop_Location
ORDER BY Total DESC 
LIMIT 10;
-- 10.Retrieve all rides where the average VTAT exceeded 15 minutes. VTAT > 900 seconds 
select * From ola_rides where V_TAT > 900;
-- 11.Calculate the total revenue (Booking Value) for all successful rides.
select sum(Booking_value) as Total_Revenue 
From ola_rides 
where Booking_Status = "Success";
-- 12.Find the average ride distance for each vehicle type.
SELECT Vehicle_Type, AVG(Ride_Distance) AS Avg_Distance 
FROM ola_rides 
GROUP BY Vehicle_Type;
-- 13.Retrieve the maximum and minimum booking values for rides in January.
select max(Booking_value) as Max_Booking_Value, Min(Booking_value) as Min_Booking_Value From ola_rides as a where MONTH(Date) = 1;
-- 	14.Find the total number of canceled rides by customers.
select count(*) as Canceled_by_customer from ola_rides where booking_status = 'canceled by customer';
-- 15.Count the total rides canceled by drivers due to customer-related issues
select count(*) as Driver_canceled_customer_Issues from ola_rides where Booking_status = 'Canceled by Driver' and Canceled_Rides_by_Driver like '%customer%';
-- 16. Find the average customer rating for successful bookings .
select vehicle_Type , Avg(Driver_Ratings) as AVg_Driver_Rating From ola_rides where Driver_Ratings Is Not Null 
Group by Vehicle_Type;
-- 17.Calculate the average customer rating for successful bookings.
select avg(Customer_Rating) as Avg_Customer_Rating  from ola_rides where Booking_status = "Success" and Customer_Rating is not Null;
-- 18.Find the total number of rides canceled due to "Driver asked to cancel."
select count(*) as Total_Driver_Asked_To_Cancel From ola_rides Where canceled_Rides_by_Driver = 'Driver asked to cancel';
-- 19.Calculate the percentage of rides that were incomplete.
select Round(100 * Sum(CASE When INComplete_Rides = "Yes" Then 1 else 0 END ) /Count(*),2)  as  Incomplete_percentage from ola_rides;
-- 20.Retrieve the average CTAT for all successful bookings
select avg(C_TAT) as AVg_CTAT from ola_rides where C_TAT is not null and Booking_Status = "Success";
-- 21.Retrieve all rides canceled for the reason "Driver is not moving towards pickup location."
select * From ola_rides where Canceled_Rides_by_Customer = 'Driver is not moving towards pickup location';
-- 22.List all incomplete rides along with their reasons
select * from ola_rides where INcomplete_Rides =  'Yes' or Incomplete_Rides_Reason Is Not Null;
-- 23. Group rides by pickup location and count the number of rides for each 
select Pickup_Location, Count(*) as Total_Rides from ola_rides Group by pickup_Location order by Total_Rides Desc;
-- 24 .Find the most common reason for ride cancellations by customers.
select Canceled_Rides_by_Customer , count(*) as Total from ola_rides where Canceled_Rides_by_Customer is not null Group by Canceled_Rides_by_Customer ORDER BY Total  DESC Limit 1;
-- 25.Group rides by vehicle type and calculate the average booking value for each.
select Vehicle_Type , avg(Booking_Value) as AVG_Booking_VAl from ola_rides group by Vehicle_Type;
-- 26.Retrieve the total number of rides for each day of the week
SELECT 
  CASE DAYOFWEEK(Date)
    WHEN 1 THEN 'Sunday'
    WHEN 2 THEN 'Monday'
    WHEN 3 THEN 'Tuesday'
    WHEN 4 THEN 'Wednesday'
    WHEN 5 THEN 'Thursday'
    WHEN 6 THEN 'Friday'
    WHEN 7 THEN 'Saturday'
  END AS DayOfWeek,
  COUNT(*) AS Total_Rides
FROM ola_rides
GROUP BY DayOfWeek
ORDER BY FIELD(DayOfWeek, 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');

-- 27.Count the number of rides canceled by drivers due to "Personal and car-related issues."
select count(*) as Total_personal_car_Issues From ola_rides where Booking_status = "Canceled by Driver"
and canceled_Rides_by_Driver = "Personal & Car related issue";
-- 28.Group  all incomplete rides by reason and count the occurrences.
select Incomplete_Rides_Reason, Count(*) As Total From ola_rides Where Incomplete_Rides_Reason IS NOT NULL Group by Incomplete_Rides_Reason ORDER by Total DESC;
-- 29.Find the top 3 vehicle types with the highest number of successful rides
select Vehicle_Type, count(*) As Successful_Rides From ola_rides Where Booking_status = "Success"
Group by Vehicle_Type Order by  Successful_Rides Desc limit 3;
-- 30.Retrieve all rides where the ride distance exceeded 25 km
select * from ola_rides where Ride_Distance > 25;
-- 31.Identify the top 5 customers who booked the highest number of rides
select Customer_ID, Count(*) As Total_Rides From ola_rides Group by Customer_ID order by  Total_Rides Desc limit 5;
-- 32.Calculate the total revenue generated by each vehicle type
select Vehicle_Type ,sum(Booking_Value) as Total_Revenue  from ola_rides Where Booking_Status = "Success"  Group by Vehicle_Type order by Total_Revenue DESC;
-- 33.	33.Find the hour of the day with the highest number of bookings.
SELECT 
  HOUR(Time) AS Booking_Hour,
  COUNT(*) AS Total_Bookings
FROM ola_rides
GROUP BY Booking_Hour
ORDER BY Total_Bookings DESC
LIMIT 1;
-- 34.Retrieve all rides with driver ratings below 2
select * from ola_rides Where Driver_Ratings < 2;
-- 35.	35.Find the maximum and minimum driver ratings for Prime Sedan bookings.
select MAx(Driver_Ratings) as Max_Rating , MIN(Driver_Ratings) as Min_Rating  From ola_rides Where vehicle_Type = 'Prime Sedan' and Driver_Ratings IS NOt NULL;
-- 36.	36.Calculate the average booking value for each payment method (e.g., Cash, UPI, Credit Card).
select Payment_Method ,Avg(Booking_Value) as Avg_Booking_value from ola_rides where Payment_Method Is NOt NULL Group by Payment_Method ;
-- 37.Identify the top 5 most frequent drop locations.
select Drop_Location, count(*) as Total  from ola_rides Group by Drop_Location order by Total  Desc limit 5;
--  38.Calculate the percentage of rides canceled by drivers.
select Round( 100 * sum(CASE When Booking_Status = 'Canceled by Driver' then 1 Else 0 End) / Count(*),3) as Driver_Cancellation_Percentage From ola_rides ;
-- 39.Retrieve all rides where the customer rating was below 3
select * from ola_rides where Customer_Rating < 3;
-- 40.Find the average for Prime Plus bookings.
select Avg(Booking_Value) as Avg_Booking_Value, 
Avg(Ride_Distance) as Avg_Ride_Distance from ola_rides where Vehicle_Type = 'Prime Plus';
-- 41.Calculate the average ride distance and booking value for customers with more than 10 rides
 -- Step 1: Get customers with more than 10 rides
CREATE TEMPORARY TABLE active_customers AS
SELECT Customer_ID
FROM ola_rides
GROUP BY Customer_ID
HAVING COUNT(*) > 10;

-- Step 2: Calculate averages using the filtered customers
SELECT 
    ROUND(AVG(Ride_Distance), 2) AS Avg_Ride_Distance,
    ROUND(AVG(Booking_Value), 2) AS Avg_Booking_Value
FROM ola_rides
WHERE Customer_ID IN (SELECT Customer_ID FROM active_customers);
 -- 42.Retrieve the top 5 locations with the most ride cancellations.
 select Pickup_Location , COUNT(*) as Total_Cancellations From ola_rides where Booking_Status Like 'Canceled%' Group by Pickup_Location ORder by Total_Cancellations DESC limit 5;
-- 43.Compare the average driver rating for 4-wheelers and 2-wheelers.
select
 CASE
    When Vehicle_type In ('Bike','eBike') THEN '2-Wheeler'
    Else '4-Wheeler'
 END As Vehicle_Category ,
 AVG(Driver_Ratings) as Avg_Driver_Rating
 from ola_rides 
 Where Driver_Ratings IS NOT NULL 
 Group by Vehicle_Category;
-- 44.Find the most common cancellation reason for Prime SUVs
select Canceled_Rides_by_Driver , Count(*) as Total From ola_rides where Vehicle_Type = 'Prime SUv' and Booking_Status = 'Canceled by Driver' and Canceled_Rides_by_Driver IS NOT NULL Group by Canceled_Rides_by_Driver order by Total DESC Limit 1;
-- 45.Retrieve all rides canceled by customers for the reason "Change of plans."
select * from ola_rides Where Canceled_Rides_by_Customer = 'Change of plans';
-- 46.Compare the average ride distances for successful vs. canceled rides.
select Booking_Status, Avg(Ride_Distance) as Avg_Distance From ola_rides where Booking_Status IN ('Success','Canceled by Driver' , 'Canceled by Customer')
Group by Booking_Status ;
-- 47.Identify the day of the week with the highest number of ride cancellations.
SELECT 
  CASE DAYOFWEEK(Date)
    WHEN 1 THEN 'Sunday'
    WHEN 2 THEN 'Monday'
    WHEN 3 THEN 'Tuesday'
    WHEN 4 THEN 'Wednesday'
    WHEN 5 THEN 'Thursday'
    WHEN 6 THEN 'Friday'
    WHEN 7 THEN 'Saturday'
  END AS DayOfWeek,
  COUNT(*) AS Total_Cancellations
FROM ola_rides
WHERE Booking_Status LIKE 'Canceled%'
GROUP BY DayOfWeek
ORDER BY Total_Cancellations DESC
LIMIT 1;

-- 48.Find the total number of rides canceled due to vehicle breakdowns.
select Count(*) as Total_Breakdowns from ola_rides where Canceled_Rides_by_Driver = 'Vehicle breakdown';
-- 49.Retrieve the total revenue for each week of the month.
SELECT 
  CASE 
    WHEN DAY(Date) BETWEEN 1 AND 7 THEN 'Week 1'
    WHEN DAY(Date) BETWEEN 8 AND 14 THEN 'Week 2'
    WHEN DAY(Date) BETWEEN 15 AND 21 THEN 'Week 3'
    WHEN DAY(Date) >= 22 THEN 'Week 4'
  END AS Week,
  SUM(Booking_Value) AS Total_Revenue
FROM ola_rides
WHERE Booking_Status = 'Success'
GROUP BY Week
ORDER BY Week;

-- 50.Identify the top 5 drivers with the highest average ratings.
SELECT Booking_ID, AVG(Driver_Ratings) AS Avg_Rating
FROM ola_rides
WHERE Booking_ID IS NOT NULL AND Driver_Ratings IS NOT NULL
GROUP BY Booking_ID
ORDER BY Avg_Rating DESC
LIMIT 5;
--