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


#====== now based on table2 , we need to update table 1

