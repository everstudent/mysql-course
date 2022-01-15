-- 1. Task

-- user_id = 11 (who we search most active messaging friend for)
-- logic:
-- find all approved friends of 11
-- count all messages for each friend
-- sort by most messages
-- limit to 1 row

SELECT IF(m.from_user_id = 11, m.to_user_id, m.from_user_id) most_active_friend_id, count(distinct m.id) messages
FROM friend_requests fr
JOIN messages m ON (m.from_user_id = 11 OR m.to_user_id = 11)
WHERE (fr.initiator_user_id = 11 OR fr.target_user_id = 11) AND fr.status = 'approved'
GROUP BY most_active_friend_id
ORDER BY messages DESC
LIMIT 1;

-- +-----------------------+----------+
-- | most_active_friend_id | messages |
-- +-----------------------+----------+
-- |                     3 |        4 |
-- +-----------------------+----------+



-- 2.

-- logic:
-- joining users and profiles to filter users < than 11 years old
-- joining media and media_likes to count() all likes received by media owned by selected users

SELECT count(*)
FROM users u
JOIN profiles p ON (p.user_id = u.id AND TIMESTAMPDIFF(YEAR, p.birthday, CURDATE()) < 11)
JOIN media m ON (m.owner_id = u.id)
JOIN media_likes ml ON (m.id = ml.media_id);

-- +----------+
-- | count(*) |
-- +----------+
-- |       10 |
-- +----------+



-- 3.

-- logic:
-- join users and profiles to aggregate by gender
-- join media_likes to count all likes set by users
-- group by gender
-- sort by likes (descending) to see top gender

SELECT p.gender, count(*) likes
FROM users u
JOIN profiles p ON (p.user_id = u.id)
JOIN media_likes ml ON (ml.user_id = u.id)
GROUP BY p.gender
ORDER BY likes DESC

-- +--------+-------+
-- | gender | likes |
-- +--------+-------+
-- | f      |    10 |
-- | m      |     8 |
-- +--------+-------+
