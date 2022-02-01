-- 1
CREATE TABLE `logs` (
  `datetime` datetime NOT NULL,
  `table_name` enum('catalogs','products','users') NOT NULL,
  `object_id` bigint unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=ARCHIVE;

DELIMITER //
CREATE TRIGGER log_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
  INSERT INTO logs VALUES(NOW(), 'products', NEW.id, NEW.name);
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER log_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
  INSERT INTO logs VALUES(NOW(), 'catalogs', NEW.id, NEW.name);
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER log_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
  INSERT INTO logs VALUES(NOW(), 'users', NEW.id, NEW.name);
END //
DELIMITER ;



-- 2 Insert 1m users with random name
set @@cte_max_recursion_depth = 1000000;
INSERT INTO users(name) SELECT MD5(v) FROM (WITH RECURSIVE seq AS (   SELECT 1 AS v UNION ALL SELECT v + 1 FROM seq WHERE v < 1000000
 ) SELECT v FROM seq) rng;
