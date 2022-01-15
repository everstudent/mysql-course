-- 1. Task

-- user_id = 11 (who we search most active messaging friend for)
-- logic:
-- first find all approved friends of 11 user
-- count all messages for each friend
-- sort by most messages
-- limit to 1 row

SELECT IF(from_user_id = 11, to_user_id, from_user_id) most_active_friend_id, count(*) messages
FROM messages
WHERE IF(to_user_id = 11, from_user_id, to_user_id) IN (
  (SELECT target_user_id FROM friend_requests WHERE initiator_user_id = 11 AND status = 'approved') UNION (SELECT initiator_user_id FROM friend_requests WHERE
  target_user_id = 11 AND status = 'approved')
)
AND (to_user_id = 11 OR from_user_id = 11)
GROUP BY most_active_friend_id
ORDER BY messages DESC
LIMIT 1

-- +-----------------------+----------+
-- | most_active_friend_id | messages |
-- +-----------------------+----------+
-- |                     3 |        4 |
-- +-----------------------+----------+



-- 2.

-- logic:
-- getting profiles to filter users < than 11 years old
-- getting media to filter by media owners
-- counting all resulting likes

SELECT count(*)
FROM media_likes
WHERE (
  media_id IN (SELECT id FROM media WHERE owner_id IN (
    SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, CURDATE()) < 11
  ) )
)

-- +----------+
-- | count(*) |
-- +----------+
-- |       10 |
-- +----------+



-- 3.

-- logic:
-- first select  gender and likes count for each user
-- then aggregate it to get summary of likes by gender
-- sort by likes (descending) to see top gender

SELECT gender, SUM(likes) likes FROM (
  SELECT gender, (SELECT count(*) FROM media_likes WHERE user_id = profiles.user_id) likes
  FROM profiles
) likes_stats
GROUP BY gender
ORDER BY likes DESC

-- +--------+-------+
-- | gender | likes |
-- +--------+-------+
-- | f      |    10 |
-- | m      |     8 |
-- +--------+-------+
