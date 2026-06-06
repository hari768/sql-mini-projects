-- Dataset to support real world analytical queries on the shopeasy database

-- Drop all the tables
DROP TABLE IF EXISTS reviews;

DROP TABLE IF EXISTS order_items;

DROP TABLE IF EXISTS orders;

DROP TABLE IF EXISTS products;

DROP TABLE IF EXISTS customers;

-- Create all the tables
-- Customers table: stores customer data
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Orders table: stores each order placed by customers
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) CHECK (status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

-- Products table: stores product details
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price NUMERIC(10, 2) CHECK (price > 0)
);

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id) ON DELETE CASCADE,
    product_id INT REFERENCES products(id),
    quantity INT CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) CHECK (unit_price > 0)
);

-- Reviews table: stores customer reviews for products
CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(id),
    customer_id INT REFERENCES customers(id),
    review_text TEXT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert data into all the tables

INSERT INTO customers (first_name, last_name, email)
VALUES
    ('Emily', 'Davis', 'emily.davis@example.com'),
    ('Jin', 'Lee', 'jin.lee@example.com'),
    ('Raj', 'Sharma', 'raj.sharma@example.com'),
    ('Fatima', 'Al-Hassan', 'fatima.alhassan@example.com'),
    ('Luis', 'Martinez', 'luis.martinez@example.com'),
    ('Amara', 'Ndiaye', 'amara.ndiaye@example.com'),
    ('Yuki', 'Tanaka', 'yuki.tanaka@example.com'),
    ('Ivan', 'Petrov', 'ivan.petrov@example.com'),
    ('Zara', 'Khan', 'zara.khan@example.com'),
    ('Carlos', 'Silva', 'carlos.silva@example.com');

INSERT INTO orders (customer_id, order_date, status)
VALUES
    (1, '2024-09-01 10:00:00', 'Delivered'),
    (2, '2024-09-02 12:30:00', 'Shipped'),
    (3, '2024-09-03 14:15:00', 'Pending'),
    (1, '2024-09-05 16:00:00', 'Delivered'),
    (4, '2024-09-06 10:30:00', 'Cancelled'),
    (5, '2024-09-07 18:00:00', 'Shipped'),
    (6, '2024-09-08 09:45:00', 'Delivered'),
    (7, '2024-09-10 11:30:00', 'Shipped'),
    (8, '2024-09-12 13:00:00', 'Pending'),
    (9, '2024-09-14 15:00:00', 'Shipped'),
    (2, '2024-09-16 17:00:00', 'Shipped');


INSERT INTO products (product_name, category, price)
VALUES 
    ('Laptop', 'Electronics', 1200.00),
    ('Smartphone', 'Electronics', 800.00),
    ('Headphones', 'Electronics', 150.00),
    ('T-Shirt', 'Clothing', 20.00),
    ('Jeans', 'Clothing', 45.00),
    ('Blender', 'Appliances', 60.00),
    ('Toaster', 'Appliances', 30.00),
    ('Cookware Set', 'Appliances', 100.00),
    ('Sneakers', 'Footwear', 75.00),
    ('Gaming Console', 'Electronics', 300.00);


INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 1, 1200.00),
    (1, 2, 2, 800.00),
    (2, 3, 1, 150.00),
    (3, 4, 3, 20.00),
    (4, 5, 2, 45.00),
    (5, 6, 1, 60.00),
    (6, 7, 1, 30.00),
    (7, 8, 1, 100.00),
    (8, 9, 2, 75.00),
    (9, 10, 1, 300.00),
    (10, 1, 1, 1200.00),
    (11, 2, 1, 800.00);

INSERT INTO reviews (product_id, customer_id, review_text, rating, review_date)
VALUES
    (1, 1, 'Great laptop! Worth every penny.', 5, '2024-09-01 11:00:00'),
    (2, 1, 'The smartphone is good but could be faster.', 4, '2024-09-01 11:15:00'),
    (3, 2, 'Headphones are decent for the price.', 3, '2024-09-02 13:00:00'),
    (4, 3, 'T-shirt material is soft and comfortable.', 4, '2024-09-03 15:30:00'),
    (5, 4, 'Jeans fit well and are of good quality.', 4, '2024-09-06 17:00:00'),
    (6, 5, 'Blender works fine for smoothies, easy to use.', 4, '2024-09-07 18:30:00'),
    (7, 6, 'Toaster is a bit slow but works fine.', 3, '2024-09-08 10:00:00'),
    (8, 7, 'Cookware set is of good quality and perfect for my kitchen.', 5, '2024-09-10 12:00:00'),
    (9, 8, 'Sneakers are comfortable and stylish.', 5, '2024-09-12 13:30:00'),
    (10, 9, 'Gaming console is amazing, totally worth the buy.', 5, '2024-09-14 14:30:00'),
    (1, 10, 'Laptop is very fast and sleek. Totally recommend.', 5, '2024-09-15 16:00:00'),
    (2, 2, 'Smartphone works great, but camera could be better.', 4, '2024-09-16 17:30:00');


select * from order_items;

	--Task 1 cal total revenue--
SELECT
	SUM(quantity * unit_price) AS total_name
FROM
	order_items;



    --Task 2__

SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
LEFT JOIN order_items oi
    ON p.id = oi.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;


--Task 3 --

SELECT AVG(order_value) AS avg_order_value
FROM (
    SELECT 
        oi.order_id,
        SUM(unit_price * quantity) AS order_value
    FROM order_items oi
    GROUP BY oi.order_id
) ;





SELECT
	c.first_name,
	c.last_name,
	SUM(quantity * unit_price) AS lifetime_value
FROM
	customers AS c
	INNER JOIN orders AS o ON c.id = o.customer_id
	INNER JOIN order_items AS oi ON o.id = oi.order_id
GROUP BY
	c.first_name,
	c.last_name
ORDER BY
	SUM(quantity * unit_price) DESC;



--Task 5 -- 

SELECT
	c.first_name,
	c.last_name,
	MAX(o.order_date) AS last_order_date
FROM
	customers AS c
	LEFT JOIN orders AS o ON c.id = o.customer_id
GROUP BY
	c.id
HAVING
	MAX(o.order_date) < '2024-09-08'
	OR MAX(o.order_date) IS NULL;



--Task 6--

SELECT 
    p.id,
    p.product_name,
    r.review_text,
    r.rating,
    r.review_date,
    CASE
        WHEN r.rating IN (4, 5) THEN 'Positive'
        WHEN r.rating = 3 THEN 'Neutral'
        WHEN r.rating IN (1, 2) THEN 'Negative'
        ELSE 'Unknown'
    END AS rating_label
FROM products p
JOIN reviews r
    ON p.id = r.product_id
WHERE r.review_date = (
    SELECT MAX(review_date)
    FROM reviews
    WHERE product_id = r.product_id
);



--Task 7 --

SELECT
	p.product_name,
	AVG(r.rating) :: INT AS avg_rating,
	CASE
		WHEN AVG(r.rating) >= 4 THEN 'Top rated'
		ELSE 'regular'
	END AS product_type
FROM
	products AS p
	INNER JOIN reviews AS r ON p.id = r.product_id
GROUP BY
	p.id;



  --Task 8--

 SELECT 
   Oi.order_id , SUM(quantity * unit_price) AS total_value ,
   CASE 
     WHEN SUM(quantity * unit_price) > 500 THEN '10% discount'
	 WHEN SUM(quantity * unit_price) > 1000 THEN '20% discount'
	 else 'No discount'
	 END as Discount
  FROM order_items AS Oi
     GROUP BY order_id
	 ORDER BY SUM(quantity * unit_price) DESC ;





                      -- END PROJECT --



	

	

	

	
	