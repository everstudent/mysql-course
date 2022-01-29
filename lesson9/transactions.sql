-- 1.
START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
DELETE FROM shop.users WHERE id = 1;
COMMIT;



-- 2.
CREATE VIEW products_catalog AS
SELECT p.name as product_name, c.name as catalog_name
FROM products p
LEFT JOIN catalogs c ON (c.id = p.catalog_id);



-- 3. (Mysql 8+ version only!)
SELECT m.date, IF(td.created_at IS NULL, '0', '1') FROM
test_dates td
RIGHT JOIN (
  WITH RECURSIVE seq AS (
    SELECT 0 AS d UNION ALL SELECT d + 1 FROM seq WHERE d < 30
  )
  SELECT ('2021-08-01' + INTERVAL d DAY) as date FROM seq
) AS m ON (td.created_at = m.date);



-- 4.
SET @delete_from = (SELECT * FROM test_dates ORDER BY created_at DESC LIMIT 1 OFFSET 5);
DELETE FROM test_dates WHERE created_at <= @delete_from;
