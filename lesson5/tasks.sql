-- 1. task
UPDATE users SET created_at = NOW(), updated_at = NOW();


-- 2. task
-- frist we convert old format string to correct datetime format string
UPDATE users SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'),
updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i');

-- second - update column types
ALTER TABLE users MODIFY created_at DATETIME, MODIFY updated_at DATETIME;


-- 3. task
-- we assume 1000 is the highest value possible
SELECT * FROM storehouses_products ORDER BY IF(value > 0, value, 1000);

-- if we are not sure what's the highest possible amount:
-- SELECT * FROM storehouses_products ORDER BY IF(value > 0, value, (SELECT max(value) + 1 FROM storehouses_products));


-- 4. task
SELECT * FROM users WHERE birth_month IN ('may', 'august');


-- 5. task
SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY IF(id = 5, 1, IF(id=1, 2, 3));


-- 6. task
-- we assume birthday is a datetime column
SELECT AVG(TIMESTAMPDIFF(YEAR, birthday, NOW())) FROM users;


-- 7. task
SELECT DAYOFWEEK(MAKEDATE(YEAR(NOW()), DAYOFYEAR(birthday))) day, count(*) FROM users GROUP BY day;


-- 8. task
SELECT EXP(SUM(LOG(value))) FROM storehouses_products WHERE value > 0;
