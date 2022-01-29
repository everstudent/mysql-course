-- 1.
CREATE USER shop@localhost IDENTIFIED BY 'pwd';
GRANT ALL PRIVILEGES ON shop.* TO shop@localhost;
CREATE USER shop_read@localhost IDENTIFIED BY 'pwd';
GRANT SELECT ON shop.* TO shop_read@localhost;
FLUSH PRIVILEGES;



-- 2.
CREATE VIEW username AS SELECT id, name FROM accounts;
CREATE USER user_read@localhost IDENTIFIED BY 'pwd';
GRANT SELECT ON shop.username TO user_read@localhost;
FLUSH PRIVILEGES;
