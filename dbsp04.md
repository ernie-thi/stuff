# dbsp04

## ex1

```sql
-- tabelle erstellen
CREATE TABLE reservation (
  reservation_id SERIAL PRIMARY KEY,
  customer_id INT,
  inventory_id INT,
  reserve_date DATE,
  FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
  FOREIGN KEY (inventory_id) REFERENCES inventory (inventory_id)
);

-- beispieldaten einfügen
INSERT INTO reservation (customer_id, inventory_id, reserve_date) VALUES
  (1, 1, '2023-06-01'),
  (1, 2, '2023-06-02'),
  (2, 3, '2023-06-01'),
  (3, 4, '2023-06-03'),
  (3, 5, '2023-06-04');

-- trigger funktion definieren
CREATE FUNCTION check_reservation_limit() RETURNS TRIGGER AS $$
DECLARE
  reservation_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO reservation_count
  FROM reservation
  WHERE customer_id = NEW.customer_id;
  IF reservation_count >= 5 THEN
    RAISE EXCEPTION 'Customer has already reserved 5 DVDs';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- trigger resgistrieren
CREATE TRIGGER reservation_limit_trigger
BEFORE INSERT ON reservation
FOR EACH ROW
EXECUTE FUNCTION check_reservation_limit();

-- kein fehler
INSERT INTO reservation (customer_id, inventory_id, reserve_date) VALUES
  (1, 3, '2023-06-03'),
  (1, 4, '2023-06-04'),
  (1, 5, '2023-06-05');

-- fehler: Customer has already reserved 5 DVDs
INSERT INTO reservation (customer_id, inventory_id, reserve_date) VALUES
  (1, 6, '2023-06-06');
```

## ex2

### beispiel

w2x r1x r1y r3x r2z r3y w2z r3z w1y c1 c3 c2

w2x -> r1x
w2x -> r3x
w2z -> r3z
r3y -> w1y

T2 => T3 => T1

### 1)

r3x r1x w2x r1y w1y r3y r2z r3z c3 w2z c2 c1

r3x -> w2x
r1x -> w2x
r1y -> w1y
w1y -> r3y
r2z -> w2z
r3z -> w2z

T1 => T3 => T2

### 3)

w2x r1x r1y r3x w1y c1 r2z r3y r3z w2z c2 c3

w2x -> r1x
w2x -> r3x
r1y -> w1y
w1y -> r3y
r2z -> w2z
r3z -> w2z

cycle!! (T2 => T3, T3 => T2)

### 4)

r1x r2y w2z r3z w2y w1x c1 r3y w2x c3 c2

r1x -> w1x
r1x -> w2x
w1x -> w2x
r2y -> w2y
w2y -> r3y
w2z -> r3z

T1 => T2 => T3
