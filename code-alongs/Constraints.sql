--Make sure to change employee_sabrina to employee_yourname. Same with devices_yourname

--SERIAL

CREATE TABLE employee_sabrina (
	emp_id SERIAL,
	name VARCHAR(45),
	age INT,
	dev_id INT);
	
INSERT INTO employee_sabrina VALUES
(DEFAULT, 'Abby', 100, 12456);

DROP TABLE employee_sabrina;

--DEFAULT

CREATE TABLE employee_sabrina (
	emp_id SERIAL,
	name VARCHAR(45),
	age INT DEFAULT (21),
	dev_id INT);

INSERT INTO employee_sabrina(name, dev_id) VALUES
('Betty',1457);

ALTER TABLE employee_sabrina 
ALTER COLUMN age SET DEFAULT (24);		-- SET/change the default

INSERT INTO employee_sabrina(name, dev_id) VALUES
('Bettina',1457);

--NOT NULL

CREATE TABLE employee_sabrina (
	emp_id SERIAL,
	name VARCHAR(45),
	age INT NOT NULL,
	dev_id INT);

INSERT INTO employee_sabrina (name) VALUES
('sabrina');

ALTER TABLE employee_sabrina
ALTER COLUMN age DROP NOT NULL;			-- SET OR DROP NOT NULL

DROP TABLE employee_sabrina;

--UNIQUE

CREATE TABLE employee_sabrina (
	emp_id SERIAL,
	name VARCHAR(45) UNIQUE,
	age INT DEFAULT (21),
	dev_id INT);

INSERT INTO employee_sabrina (name) VALUES
('sabrina');

--PRIMARY KEY

ALTER TABLE employee_sabrina
ADD PRIMARY KEY (emp_id);

ALTER TABLE employee_sabrina 
DROP CONSTRAINT employee_sabrina_pkey;

ALTER TABLE employee_sabrina 
ADD CONSTRAINT emp_id_pk PRIMARY KEY (emp_id);

ALTER TABLE employee_sabrina 
DROP CONSTRAINT emp_id_pk;

ALTER TABLE employee_sabrina
ADD PRIMARY KEY (emp_id, name);

--FOREIGN KEY

ALTER TABLE employee_sabrina
ADD CONSTRAINT emp_dev_fkey FOREIGN KEY (dev_id) REFERENCES devices_sabrina(dev_id);

CREATE TABLE devices_sabrina (
	dev_id SERIAL PRIMARY KEY,
	dev_name VARCHAR(45));

INSERT INTO devices_sabrina VALUES
(DEFAULT, 'Laptop')

TRUNCATE employee_sabrina;
--DROP TABLE devices_sabrina;

INSERT INTO employee_sabrina (name, dev_id) VALUES
('Jug', 2);

INSERT INTO employee_sabrina (name, dev_id) VALUES
('Jug', 1);

--CHECK

DROP TABLE employee_sabrina;

CREATE TABLE employee_sabrina 
(
	emp_id SERIAL PRIMARY KEY,
	name VARCHAR(45) UNIQUE,
	age INT NOT NULL CHECK(age > 18),
	dev_id int REFERENCES devices_sabrina(dev_id)
);

INSERT INTO employee_sabrina (name) VALUES
('sabrina');

INSERT INTO employee_sabrina (name, age) VALUES
('sabrina', 16);

INSERT INTO employee_sabrina (name, age) VALUES
('sabrina', 19);

INSERT INTO employee_sabrina (name, age, dev_id) VALUES
('Jug', 19, 2);

INSERT INTO devices_sabrina VALUES
(DEFAULT, 'Laptop');

INSERT INTO employee_sabrina (name, age, dev_id) VALUES
('Jug', 19, 1);




--Extra

DROP TABLE employee_sabrina;
DROP TABLE devices_sabrina;

CREATE TABLE employee_sabrina 
(
	emp_id SERIAL,
	name VARCHAR(45) UNIQUE,
	age INT NOT NULL CHECK(age > 18),
	dev_id int REFERENCES devices_sabrina(dev_id),
	CONSTRAINT emp_name_pk PRIMARY KEY (emp_id, name)
);


