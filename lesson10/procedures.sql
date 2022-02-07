-- Track product view
DELIMITER //
DROP PROCEDURE IF EXISTS track_product_view;
CREATE PROCEDURE track_product_view(IN product_id INT, IN session_uuid TEXT, IN visitor_uuid TEXT, IN user_id INT)
BEGIN
  DECLARE visitor_id, session_id, context_id INT;

  -- get/insert visitor
  SET @visitor_id = (SELECT id FROM visitors WHERE uuid = visitor_uuid LIMIT 1);
  IF @visitor_id IS NULL THEN
    INSERT INTO visitors SET uuid = visitor_uuid;
    SET @visitor_id = LAST_INSERT_ID();
  END IF;

  -- SELECT @visitor_id;

  -- get/insert session
  SET @session_id = (SELECT id FROM sessions WHERE suid = session_uuid LIMIT 1);
  IF @session_id IS NULL THEN
    INSERT INTO sessions SET suid = session_uuid, visitor_id = @visitor_id, user_id = user_id;
    SET @session_id = LAST_INSERT_ID();
  END IF;

  -- get/insert context
  SET @context_id = (SELECT id FROM context WHERE object_id = product_id AND type = 'product' LIMIT 1);
  IF @context_id IS NULL THEN
    INSERT INTO context SET type = 'product', object_id = product_id;
    SET @context_id = LAST_INSERT_ID();
  END IF;

  -- track event
  INSERT INTO events SET
    type = (SELECT id FROM event_types WHERE name = 'view_product'),
    session_id = @session_id,
    context_id = @context_id;
END //
DELIMITER ;
