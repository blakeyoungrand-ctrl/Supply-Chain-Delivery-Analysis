-- ============================================================
-- Supply Chain Delivery Performance Analysis
-- Dataset: DataCo Smart Supply Chain (Kaggle), ~180,000 order lines
-- Tool: SQLite (DB Browser for SQLite)
-- Author: Blake Young
-- ============================================================

-- Query 1: How big is the problem?
-- Result: 180,519 order lines, 65,752 orders, 54.8% delivered late
SELECT COUNT(*) AS order_lines,
       COUNT(DISTINCT "Order Id") AS orders,
       ROUND(AVG("Late_delivery_risk") * 100, 1) AS late_pct
FROM dataco;


-- Query 2: Late delivery rate by shipping mode
-- Result: First Class 95.3% late (avg 1.0 day late), Second Class 76.6% (1.99 days),
--         Same Day 45.7%, Standard Class 38.1%
SELECT "Shipping Mode",
       COUNT(*) AS order_lines,
       ROUND(AVG("Late_delivery_risk") * 100, 1) AS late_pct,
       ROUND(AVG("Days for shipping (real)" - "Days for shipment (scheduled)"), 2) AS avg_days_late
FROM dataco
GROUP BY "Shipping Mode"
ORDER BY late_pct DESC;


-- Query 3: Late delivery rate by region
-- Result: narrow range across 23 regions (worst: Central Africa 58.0%),
--         so lateness is network-wide, not regional
SELECT "Order Region",
       COUNT(*) AS order_lines,
       ROUND(AVG("Late_delivery_risk") * 100, 1) AS late_pct
FROM dataco
GROUP BY "Order Region"
ORDER BY late_pct DESC;


-- Query 4: Top 10 product categories by sales, with profit and late rate
-- Result: all categories ~54.5-55% late; Fishing is largest ($6.9M sales, $756K profit)
SELECT "Category Name",
       COUNT(*) AS order_lines,
       ROUND(SUM("Sales"), 0) AS total_sales,
       ROUND(SUM("Order Profit Per Order"), 0) AS total_profit,
       ROUND(AVG("Late_delivery_risk") * 100, 1) AS late_pct
FROM dataco
GROUP BY "Category Name"
ORDER BY total_sales DESC
LIMIT 10;


-- Query 5: Sales value delivered late, by shipping mode
-- Result: $20.1M of $36.8M sales delivered late (54.7%);
--         premium modes (First + Second Class) = 35% of sales but 54% of late sales
SELECT "Shipping Mode",
       ROUND(SUM("Sales"), 0) AS total_sales,
       ROUND(SUM(CASE WHEN "Late_delivery_risk" = 1 THEN "Sales" ELSE 0 END), 0) AS late_sales,
       ROUND(SUM(CASE WHEN "Late_delivery_risk" = 1 THEN "Sales" ELSE 0 END) * 100.0 / SUM("Sales"), 1) AS late_sales_pct
FROM dataco
GROUP BY "Shipping Mode"
ORDER BY late_sales DESC;
