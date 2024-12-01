USE restaurant_db;

-- DESCRIBE OUR TABLES 
DESCRIBE menu_items;
DESCRIBE order_details;


-- View the menu_items table
SELECT 
    *
FROM
    menu_items;
    
    
-- What is the total_items ??
SELECT 
    COUNT(*) AS total_items
FROM
    menu_items;
    

-- Most expensive item
SELECT 
    *
FROM
    menu_items
ORDER BY price DESC
LIMIT 1;


-- Least expensive item
SELECT 
    *
FROM
    menu_items
ORDER BY price ASC
LIMIT 1;


-- Count of Italian dishes
SELECT 
    COUNT(*) AS total_italian_dishes
FROM
    menu_items
WHERE
    category = 'Italian';      -- Italian
    
-- Most expensive Italian dishes
SELECT 
    *
FROM
    menu_items
WHERE
    category = 'Italian'
ORDER BY price DESC
LIMIT 1; 

-- Least expensive Italian dishes
SELECT 
    *
FROM
    menu_items
WHERE
    category = 'Italian'
ORDER BY price ASC
LIMIT 1; 


-- HOW MANY DISHES ARE IN EACH CATEGORY? 
-- WHAT IS THE AVERAGE DISH PRICE WITHIN EACH CATEGORY?
SELECT 
    category,
    COUNT(*) AS total_dishes,
    AVG(price) AS average_price
FROM
    menu_items
GROUP BY category
ORDER BY average_price;


-- View the order_details table. 
SELECT 
    *
FROM
    order_details
;


-- What is the date range of the table?  -- FROM (2023-01-01) T0 (2023-03-31)
SELECT 
    MIN(order_date) AS earliest_date, MAX(order_date) AS latest_date
FROM
    order_details;
    
    
-- Number of orders 
SELECT 
    COUNT(DISTINCT order_id) AS total_orders
FROM
    order_details
WHERE
    order_date BETWEEN '2023-01-01' AND '2023-03-31' ;


-- Number of items (regardless of whether an item_id is missing)
SELECT 
    COUNT(*) AS total_items_ordered
FROM
    order_details
WHERE
    order_date BETWEEN '2023-01-01' AND '2023-03-31' ;


-- Which orders had the most number of items?
SELECT 
    order_id, COUNT(*) AS items_count
FROM
    order_details
GROUP BY order_id
ORDER BY items_count DESC;


-- How many orders had more than 12 items?  23 orders 
SELECT COUNT(*) AS orders_with_more_than_12_items
FROM (
    SELECT order_id, COUNT(*) AS items_count
    FROM order_details
    GROUP BY order_id
    HAVING items_count > 12
) AS subquery;


-- Combine the menu_items and order_details tables into a single table 
-- by using inner join to exclude the missing values in item_id 
SELECT 
    m.*, o.*
FROM
    menu_items AS m
        JOIN
    order_details AS o ON m.menu_item_id = o.item_id;
    
    
-- Combine the menu_items and order_details tables into a single table by using left join 
SELECT 
    od.order_details_id,
    od.order_id,
    od.order_date,
    od.order_time,
    od.item_id,
    mi.item_name,
    mi.category,
    mi.price
FROM
    order_details AS od
        LEFT JOIN
    menu_items AS mi ON od.item_id = mi.menu_item_id
;


-- Most ordered items
SELECT 
    category, item_name, COUNT(item_name) AS total_orders
FROM
    menu_items AS m
        JOIN
    order_details AS o ON m.menu_item_id = o.item_id
GROUP BY category , item_name
ORDER BY total_orders DESC   -- most ordered items (Hamburger)
-- LIMIT 1 
;

-- Least ordered items
SELECT 
    category, item_name, COUNT(item_name) AS total_orders
FROM
    menu_items AS m
        JOIN
    order_details AS o ON m.menu_item_id = o.item_id
GROUP BY category , item_name
ORDER BY total_orders ASC     -- least ordered items (Chicken Tacos)
-- LIMIT 1 ; 
; 



-- What were the top 5 orders that spent the most money?
SELECT 
    order_id , SUM(price) AS total_money 
FROM
    menu_items AS m
        JOIN
    order_details AS o ON m.menu_item_id = o.item_id
GROUP BY order_id 
ORDER BY total_money DESC 
LIMIT 5 ;                         -- Top 5 orders


-- View the details of the highest spend order. Which specific items were purchased?  -- $$$$$$$ 
SELECT 
    order_id, item_name
FROM
    menu_items AS m
        JOIN
    order_details AS o ON m.menu_item_id = o.item_id
WHERE
    order_id = (SELECT 
            order_id
        FROM
            menu_items AS m
                JOIN
            order_details AS o ON m.menu_item_id = o.item_id
        GROUP BY order_id
        ORDER BY SUM(price) DESC
        LIMIT 1);
        


-- View the details of the top 5 highest spend orders.
SELECT 
    o.order_id,
    m.item_name,
    m.category,
    m.price,
    order_totals.total_spent
FROM 
    order_details AS o
JOIN 
    menu_items AS m ON o.item_id = m.menu_item_id
JOIN 
    (
        SELECT 
            order_id,
            SUM(price) AS total_spent
        FROM 
            order_details AS od
        JOIN 
            menu_items AS mi ON od.item_id = mi.menu_item_id
        GROUP BY 
            order_id
        ORDER BY 
            total_spent DESC
        LIMIT 5
    ) AS order_totals ON o.order_id = order_totals.order_id
ORDER BY 
    order_totals.total_spent DESC, o.order_id, m.item_name;


-- Most Expensive Order in the dataset 
 SELECT 
    order_id , SUM(price) AS total_spent
FROM
    menu_items AS m
        JOIN
    order_details AS o ON m.menu_item_id = o.item_id
    GROUP BY order_id 
    ORDER BY total_spent DESC
    LIMIT 1 ;
    
-- other way to determine how much the most expensive order was

SELECT 
    MAX(total_spent) AS most_expensive_order
FROM (
    SELECT 
        o.order_id,
        SUM(m.price) AS total_spent
    FROM 
        order_details AS o
    JOIN 
        menu_items AS m ON o.item_id = m.menu_item_id
    GROUP BY 
        o.order_id
) AS order_totals;

