-- 2 task

create database example;
use example;
create table users (id int auto_increment primary key, name varchar(120));


-- 3 task
\! mysqldump example > /tmp/example.sql
create database sample;
\! mysql sample < /tmp/example.sql

-- 4 task
\! mysqldump mysql help_keyword --where="1 limit 100" > /tmp/mysql.sql
