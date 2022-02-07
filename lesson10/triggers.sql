-- Trigger to check context object on insertion
DELIMITER //
CREATE TRIGGER check_context BEFORE INSERT ON context
FOR EACH ROW
BEGIN
  IF NEW.type = 'product' AND NOT EXISTS (SELECT id FROM products WHERE id = NEW.object_id) THEN
    SIGNAL SQLSTATE '45000' set message_text = 'Product not found';
  ELSEIF NEW.type = 'category' AND NOT EXISTS (SELECT id FROM categories WHERE id = NEW.object_id) THEN
    SIGNAL SQLSTATE '45000' set message_text = 'Category not found';
  ELSEIF NEW.type = 'order' AND NOT EXISTS (SELECT id FROM orders WHERE id = NEW.object_id) THEN
    SIGNAL SQLSTATE '45000' set message_text = 'Order not found';
  END IF;
END //
DELIMITER ;
