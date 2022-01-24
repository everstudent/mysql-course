-- 1. Top messaging friend
-- user_id = 11

SELECT IF(fr.initiator_user_id = 11, fr.target_user_id, fr.initiator_user_id) most_active_friend_id,
       count(*) messages
FROM friend_requests fr
JOIN messages m ON (
  (m.from_user_id = IF(fr.initiator_user_id = 11, fr.target_user_id, fr.initiator_user_id))
  OR
  (m.to_user_id = IF(fr.initiator_user_id = 11, fr.target_user_id, fr.initiator_user_id))
)
WHERE (m.to_user_id = 11 OR m.from_user_id = 11) AND fr.status = 'approved'
GROUP BY most_active_friend_id
ORDER BY messages DESC
LIMIT 1;

-- +-----------------------+----------+
-- | most_active_friend_id | messages |
-- +-----------------------+----------+
-- |                     3 |        4 |
-- +-----------------------+----------+



-- 2. likes from age < 11 years

SELECT count(*)
FROM profiles p
JOIN media m ON (m.owner_id = p.user_id)
JOIN likes ml ON (m.id = ml.media_id)
WHERE TIMESTAMPDIFF(YEAR, p.birthday, CURDATE()) < 11;

-- +----------+
-- | count(*) |
-- +----------+
-- |       10 |
-- +----------+



-- 3. most likers gender: female or female

SELECT p.gender, count(*) likes
FROM profiles p
JOIN likes ml ON (ml.user_id = p.user_id)
GROUP BY p.gender
ORDER BY likes DESC

-- +--------+-------+
-- | gender | likes |
-- +--------+-------+
-- | f      |    10 |
-- | m      |     8 |
-- +--------+-------+
