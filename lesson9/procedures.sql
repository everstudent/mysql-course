-- 1.
DELIMITER //
CREATE PROCEDURE hello()
BEGIN
  SELECT CASE
    WHEN HOUR(NOW()) >= 6 AND HOUR(NOW()) <= 12 THEN 'Good morning'
    WHEN HOUR(NOW()) > 12 AND HOUR(NOW()) <= 18 THEN 'Good day'
    WHEN HOUR(NOW()) > 18 AND HOUR(NOW()) <= 0 THEN 'Good evening'
    ELSE 'Good night'
  END;
END //
DELIMITER ;



-- 2.
DELIMITER //
CREATE TRIGGER check_products_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
  IF NEW.name IS NULL AND NEW.desription IS NULL THEN
    SIGNAL SQLSTATE '45000' set message_text = 'Name or description should not be NULL both';
  END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER check_products_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
  IF NEW.name IS NULL AND OLD.desription IS NULL THEN
    SIGNAL SQLSTATE '45000' set message_text = 'Name or description should not be NULL both';
  ELSEIF OLD.name IS NULL AND NEW.desription IS NULL THEN
    SIGNAL SQLSTATE '45000' set message_text = 'Name or description should not be NULL both';
  END IF;
END //
DELIMITER ;



-- 3.
DROP PROCEDURE IF EXISTS fibonacci;
DELIMITER //
CREATE PROCEDURE fibonacci(IN LEN INT)
BEGIN
  DECLARE prev, cur, i, new INT DEFAULT 0;
  SET cur = 1;

  SELECT 0 as fibonacci;
  SELECT 1 as fibonacci;

  process: LOOP

    SET new = cur + prev;
    SELECT new as fibonacci;

    SET prev = cur;
    SET cur = new;

    IF i >= LEN - 2 THEN
      LEAVE process;
    END IF;

    SET i = i + 1;
  END LOOP;
END //
DELIMITER ;
