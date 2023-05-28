-- Create table1 with 15 entries
CREATE TABLE table1 (
  name VARCHAR(50),
  income DECIMAL(10, 2)
);

-- Insert 15 records into table1
INSERT INTO table1 (name, income)
VALUES
  ('John', 5000),
  ('Jane', 6000),
  ('Michael', 5500),
  ('Emily', 7000),
  ('David', 4500),
  ('Sarah', 8000),
  ('James', 6500),
  ('Olivia', 5500),
  ('Daniel', 7000),
  ('Sophia', 6000),
  ('Matthew', 4500),
  ('Emma', 7500),
  ('Benjamin', 5500),
  ('Ava', 6500),
  ('Henry', 5000);

-- Create table2 with 20 entries (12 same as table1, 3 with different income, and 5 additional records)
CREATE TABLE table2 (
  name VARCHAR(50),
  income DECIMAL(10, 2)
);

-- Insert 12 same records from table1 into table2
INSERT INTO table2 (name, income)
SELECT name, income
FROM table1
LIMIT 12;

-- Insert 3 records with same names but different income compared to table1
INSERT INTO table2 (name, income)
VALUES
  ('Benjamin', 5500),
  ('Ava', 6500),
  ('Henry', 6000);

-- Insert 5 additional records into table2
INSERT INTO table2 (name, income)
VALUES
  ('Liam', 4000),
  ('Mia', 5500),
  ('Ethan', 6000),
  ('Isabella', 7000),
  ('Jacob', 5000);


#====== SCD type 2
#==option 1

select t1.* 
, 'version1' as version
from table1 t1
union all
select t2.*
, 'version2' as version
from table2 t2

#==== option 2
with t1
as
(
select t1.* 
, current_date-1 as updated_at
from table1 t1
)
, t2
as
(
select t2.*
, current_date as updated_at
from table2 t2
)

, t3
as
(
select A.*
,lead(income) over(partition by name order by updated_at) as lead_income
,lead(updated_at) over(partition by name order by updated_at) as lead_date
from
(
  select * from t1
  union all
  select * from t2
)A
)

, t4 as
(
  select 
t3.name , t3.income 
, updated_at as start_date
,case when income = lead_income then NULL
when income <> lead_income then lead_date
end as end_date
from t3
)

, t5
as
(
select t4.* 
, row_number() over(partition by name, income order by start_date) as rw_num
from t4
)

select * from t5
where rw_num = 1










