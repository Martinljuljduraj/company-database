LOAD DATA LOCAL INFILE '/Users/martinlulgjuraj/Downloads/company/employee.dat'
INTO TABLE employee
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';