-- 1. Products with views for the last 30 days
CREATE VIEW monthly_product_views AS
SELECT p.id, p.name, p.price, IFNULL(sum(e.value), 0) views
FROM products p
LEFT JOIN context c ON (c.object_id = p.id AND c.type = 'product')
LEFT JOIN events e ON (
  e.context_id = c.id AND
  e.type = (SELECT id FROM event_types WHERE name = 'view_product') AND
  e.at > NOW() - INTERVAL 30 DAY
)
GROUP BY p.id

-- sample
SELECT * FROM monthly_product_views WHERE id = 10;



-- 2. Orders that were created but never checked out (abandoned)
CREATE VIEW abandoned_orders AS
SELECT o.id, o.created_at, o.user_id
FROM orders o
JOIN context c ON (c.object_id = o.id AND c.type = 'order')
JOIN events e ON (
  e.context_id = c.id AND
  e.type = (SELECT id FROM event_types WHERE name = 'create_order')
)
LEFT JOIN events en ON (
  en.context_id = c.id AND
  en.type = (SELECT id FROM event_types WHERE name = 'checkout_order')
)
WHERE en.id IS NULL
GROUP BY o.id

-- sample
SELECT * FROM abandoned_orders WHERE created_at > NOW() - INTERVAL 15 DAY;
