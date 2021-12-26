-- 1. Fill in all tables (-> data.sql)

-- 2. Unique first names
SELECT DISTINCT firstname from users ORDER BY firstname ASC;

-- 3. Mark first 5 as deleted
-- Here we might also have and use created_at column (but we don't have it currently)
UPDATE users SET is_deleted = 1 ORDER BY id ASC LIMIT 5;

-- 4. Remove future messages
DELETE FROM messages WHERE created_at > NOW();

-- 5. Course diploma
Online shop event tracking system
