CREATE TABLE IF NOT EXISTS t1(
    ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    col1 VARCHAR(100)  CHARACTER SET latin1 COLLATE latin1_german1_ci,
    col2 VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci
) ENGINE = MYISAM;
truncate t1;