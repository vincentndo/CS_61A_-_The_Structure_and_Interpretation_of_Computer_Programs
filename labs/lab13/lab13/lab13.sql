.read data.sql

-- Q1
create table flight_costs as
  with helper( day, today, tomorrow ) as (
    select 1, 20, 30 union
    select day + 1, tomorrow, (today + tomorrow) / 2 + 5 * ((day + 2) % 7) from helper where day < 25
  )
  select day, today from helper;

-- Q2
-- create table schedule as
--   with all_iternaries(iterary, price) as (
--     select a.departure || ", " || a.arrival || ", " || b.arrival, a.price + b.price from flights as a, flights as b where a.departure = "SFO" and b.arrival = "PDX" and a.arrival = b.departure union
--     select departure || ", " || arrival, price from flights where departure = "SFO" and arrival = "PDX"
--   )
--   select iterary, price from all_iternaries order by price;

create table schedule as
  with all_iternaries(n, arrival, iterary, price) as (
    select 0, "SFO", "SFO", 0 union
    select n + 1, b.arrival, a.iterary || ", " || b.arrival, a.price + b.price from all_iternaries as a, flights as b where a.arrival = b.departure and n < 2
  )
  select iterary, price from all_iternaries where arrival = "PDX" order by price;

-- Q3
create table shopping_cart as
  with enumerate(itemList, lastPrice, leftBudget) as (
    select item, price, 60 - price from supermarket where price <= 60 union
    select itemList || ", " || item, price, leftBudget - price from enumerate, supermarket where price >= lastPrice and leftBudget >= price
  )
  select itemList, leftBudget from enumerate order by leftBudget, itemList;

-- Q4
create table number_of_options as
  select count(distinct meat) from main_course;

-- Q5
create table calories as
  select count(*) from main_course as a, pies as b where a.calories + b.calories < 2500;

-- Q6
create table healthiest_meats as
  select meat, min(a.calories + b.calories) from main_course as a, pies as b group by meat having max(a.calories + b.calories) < 3000;

-- Q7
create table average_prices as
  select category, avg(MSRP) from products group by category;

-- Q8
create table lowest_prices as
  select item, store, min(price) from inventory group by item;

-- Q9
-- create table shopping_list as
--   with should_buy(name) as (
--     select name from products group by category having min(MSRP / rating)
--   )
--   select name, store from should_buy, lowest_prices where name = item;

create table shopping_list as
  select name, store from products, lowest_prices where name = item group by category having min(MSRP / rating);

-- Q10
create table total_bandwidth as
  select sum(Mbs) from stores a, shopping_list b where a.store = b.store;
