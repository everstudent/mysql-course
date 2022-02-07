-- 1. Total events count by event type within date range
SELECT SUM(value)
FROM events
WHERE type = (SELECT id FROM event_types WHERE name = 'add_to_cart') AND
      at BETWEEN '2022-01-01' AND '2022-01-30';



-- 2. Show only products that were viewed within data range
SELECT DISTINCT p.id, p.name
FROM products p
JOIN context c ON (c.object_id = p.id AND c.type = 'product')
JOIN events e ON (e.context_id = c.id AND e.type = (SELECT id FROM event_types WHERE name = 'view_product'))
WHERE e.at BETWEEN '2022-01-25' AND '2022-01-30';



-- 3. Select total views for each category based on a date range
SELECT DISTINCT cat.id, MAX(cat.name), sum(value) views
FROM categories cat
JOIN context c ON (c.object_id = cat.id AND c.type = 'category')
JOIN events e ON (e.context_id = c.id AND e.type = (SELECT id FROM event_types WHERE name = 'view_category'))
WHERE e.at BETWEEN '2022-01-25' AND '2022-01-30'
GROUP BY cat.id;



-- 4. Build daily chart for specific event_type and date span
SELECT date(at) date, sum(value) views
FROM events
WHERE type = (SELECT id FROM event_types WHERE name = 'add_to_cart')
GROUP BY date
ORDER BY date DESC;



-- 5. Select products there weren't added to cart within date range
SELECT p.id, p.name
FROM products p
LEFT JOIN context c ON (c.object_id = p.id AND c.type = 'product')
LEFT JOIN events e ON (
  e.context_id = c.id AND
  e.type = (SELECT id FROM event_types WHERE name = 'add_to_cart') AND
  e.at BETWEEN '2022-01-29' AND '2022-01-30'
)
WHERE e.id IS NULL
GROUP BY p.id;



-- 6. Total events count by tag
SELECT t.name, SUM(e.value) events
FROM events e
LEFT JOIN event_tags et ON (e.id = et.event_id)
LEFT JOIN tags t ON (t.id = et.tag_id)
GROUP BY t.name;
