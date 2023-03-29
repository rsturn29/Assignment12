
CREATE DATABASE IF NOT EXISTS pizza_palace;
USE pizza_palace;

CREATE TABLE pizzas (pizza_id INT NOT NULL AUTO_INCREMENT, pizza_name VARCHAR(30),price DECIMAL(8,2),
    PRIMARY KEY (pizza_id));
    
 CREATE TABLE customer (customer_id INT NOT NULL AUTO_INCREMENT, first_name VARCHAR(50),last_name VARCHAR(50),phone VARCHAR(50) NOT NULL,
		PRIMARY KEY (customer_id));

 CREATE TABLE orders( order_id INT NOT NULL AUTO_INCREMENT,order_date DATETIME,customer_id INT,
		PRIMARY KEY (order_id),
        FOREIGN KEY (customer_id) REFERENCES customer (customer_id));
        
  CREATE TABLE pizza_orders (order_id INT NOT NULL,pizza_id INT NOT NULL,quantity INT NOT NULL,
	PRIMARY KEY (order_id, pizza_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id));
 
 CREATE TABLE customer_orders (customer_id INT NOT NULL,order_id INT NOT NULL,
	PRIMARY KEY (customer_id, order_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id));
    
INSERT INTO pizzas (pizza_name, price)
VALUES( 'Pepperoni & Cheese', 7.99),( 'Vegetarian', 9.99),('Meat Lovers' , 14.99),('Hawaiian', 12.99); 
            
INSERT INTO customer (first_name, last_name, phone)
VALUES ('Trevor', 'Page','226-555-4982'),('John','Doe','555-555-9498');
SELECT * FROM customer;
INSERT INTO orders(order_date, customer_id) VALUE ('2014-09-10  09:47:00', 1),('2014-09-10 13:20:00',2), ('2014-09-10 09:47:00',1);
SELECT * FROM orders;
SELECT * FROM pizzas;
INSERT INTO pizza_orders (order_id,pizza_id,quantity)
VALUES(1,1,1),(1,3,1),(2,2,1),(2,3,2),(3,3,1),(3,4,1);

INSERT INTO customer_orders(customer_id, order_id)
VALUES (1,1),(2,2),(1,3);

SELECT customer.first_name, SUM(pizzas.price * pizza_orders.quantity) AS total_amout
FROM pizzas
JOIN pizza_orders ON pizzas.pizza_id = pizza_orders.pizza_id
JOIN customer_orders ON pizza_orders.order_id = customer_orders.order_id
JOIN customer ON customer_orders.customer_id = customer.customer_id
JOIN orders ON customer_orders.order_id = orders.order_id
GROUP BY  customer.first_name;

SELECT  DATE(orders.order_date), customer.first_name, SUM(pizzas.price * pizza_orders.quantity) AS total_amount
FROM pizzas
JOIN pizza_orders ON pizzas.pizza_id = pizza_orders.pizza_id
JOIN customer_orders ON pizza_orders.order_id = customer_orders.order_id
JOIN customer ON customer_orders.customer_id = customer.customer_id
JOIN orders ON customer_orders.order_id = orders.order_id
GROUP BY (orders.order_date), customer.first_name;

 
