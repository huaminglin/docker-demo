CREATE TABLE IF NOT EXISTS t4(
    ID int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    col1 VARCHAR(100)  CHARACTER SET latin1 COLLATE latin1_german1_ci,
    col2 VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci
);

TRUNCATE t4;
INSERT INTO t4(col1, col2) VALUES(_utf8 X'c2a5', _utf8 X'c2a5');

SET character_set_results=NULL;
SELECT col1, col2, col1 = col2 FROM t4 WHERE col1=col2;
