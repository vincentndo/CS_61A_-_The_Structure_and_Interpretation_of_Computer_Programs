create table parents as
  select "abraham" as parent, "barack" as child union
  select "abraham"          , "clinton"         union
  select "delano"           , "herbert"         union
  select "fillmore"         , "abraham"         union
  select "fillmore"         , "delano"          union
  select "fillmore"         , "grover"          union
  select "eisenhower"       , "fillmore";

create table dogs as
  select "abraham" as name, "long" as fur, 26 as height union
  select "barack"         , "short"      , 52           union
  select "clinton"        , "long"       , 47           union
  select "delano"         , "long"       , 46           union
  select "eisenhower"     , "short"      , 35           union
  select "fillmore"       , "curly"      , 32           union
  select "grover"         , "short"      , 28           union
  select "herbert"        , "curly"      , 31;

create table sizes as
  select "toy" as size, 24 as min, 28 as max union
  select "mini",        28,        35        union
  select "medium",      35,        45        union
  select "standard",    45,        60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
create table size_of_dogs as
  select a.name, b.size from dogs as a, sizes as b where a.height > b.min and a.height <= b.max;

-- All dogs with parents ordered by decreasing height of their parent
create table by_height as
  select a.name from dogs as a, parents as b, dogs as c where a.name = b.child and b.parent = c.name order by -c.height;

  -- select child from parents, dogs where parent = name order by -height;

-- Sentences about siblings that are the same size
create table sentences as
  select a.name || ' and ' || b.name || ' are ' || a.size || ' siblings' as sentence from size_of_dogs as a, size_of_dogs as b, parents as c, parents as d where a.size = b.size and a.name = c.child and b.name = d.child and c.parent = d.parent and a.name < b.name;

-- create table sentences as
--   with siblings(first, second) as (
--     select a.child, b.child from parents as a, parents as b where a.parent = b.parent and a.child < b.child
--     )
--   select first || ' and ' || second || ' are ' || a.size || ' siblings' from siblings, size_of_dogs as a, size_of_dogs as b where first = a.name and second = b.name and a.size = b.size;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
create table stacks as
  with helper(names, num_dog, last_height, total_height) as (
    select name, 1, height, height from dogs union
    select names || ', ' || name, num_dog + 1, height, total_height + height from helper, dogs where last_height < height and num_dog < 4
    )
  select names, total_height from helper where total_height >= 170 order by total_height;

-- non_parents is an optional, but recommended question
-- All non-parent relations ordered by height difference
create table non_parents as
  select "REPLACE THIS LINE WITH YOUR SOLUTION";

create table ints as
    with i(n) as (
        select 1 union
        select n+1 from i limit 100
    )
    select n from i;

create table divisors as
    select a.n as int, count(*) as divisor_num from ints as a, ints as b where a.n = (a.n / b.n) * b.n and a.n >= b.n group by a.n;

create table primes as
    select int from divisors where divisor_num = 2;
