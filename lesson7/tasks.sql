-- 1.
SELECT u.id
FROM users u
JOIN orders o ON (u.id = o.user_id)
GROUP BY u.id



-- 2.
SELECT p.*, c.name
FROM products p
JOIN catalogs c ON (c.id = p.catalog_id)



-- 3.
SELECT f.id, cf.name as from_name, ct.name as to_name
FROM flights f
JOIN cities cf ON (cf.label = f.from)
JOIN cities ct ON (ct.label = f.to)
