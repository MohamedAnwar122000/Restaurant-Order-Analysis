# Restaurant-Order-Analysis

## Project Purpose

The purpose of this project is to analyze the operations and customer behavior of the "Taste of the World Café." Specifically, the goal is to:
- Understand which menu items and categories perform well and which do not.
- Identify the restaurant’s top revenue-generating items and orders.
- Provide actionable insights into customer preferences and operational efficiency to optimize the menu and drive sales.

---

## the Dataset

The dataset consists of two primary tables:

### `menu_items`
- Contains details about the café's menu items, including:
  - **`menu_item_id`**: Unique identifier for each menu item.
  - **`item_name`**: Name of the item.
  - **`category`**: Category of the item (e.g., Italian, Dessert).
  - **`price`**: Price of the item.

### `order_details`
- Contains information about customer orders, including:
  - **`order_id`**: Unique identifier for each order.
  - **`order_date`** and **`order_time`**: When the order was placed.
  - **`item_id`**: The `menu_item_id` corresponding to the item ordered.

---

## Questions Answered

This project answers the following key questions:

### **Menu Analysis**
- What are the least and most expensive items on the menu?
- How many dishes are in each category, and what is the average price within each category?
- What are the least and most ordered items? What categories are they in?

### **Order Analysis**
- What is the date range of the orders dataset?
- How many orders were made within a specific date range? How many items were ordered in total?
- Which orders had the most number of items? How many orders contained more than 12 items?
- What were the top 5 highest spend orders? What were their total costs?

### **Customer Behavior Insights**
- What specific items were purchased in the highest spend orders?
- What are the top-performing menu categories based on order volume and revenue?

---

## Skills and Techniques Used

The following skills and techniques were applied during this analysis:

### **SQL Queries**
- **Joins**: Combined the `menu_items` and `order_details` tables to connect menu item details with order data.
- **Aggregation**: Used functions like `SUM()`, `COUNT()`, and `MAX()` to calculate totals, and identify extremes.
- **Grouping**: Utilized `GROUP BY` to aggregate data by categories, items, or orders.
- **Sorting**: Used `ORDER BY` to rank items and orders based on various metrics.
- **Filtering**: Applied `WHERE` clauses to analyze specific date ranges or categories.
- **Subqueries**: Identified top-performing or specific orders and retrieved additional details.


