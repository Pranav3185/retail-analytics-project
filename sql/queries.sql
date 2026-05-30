USE RetailAnalytics;

-- =============================================
-- QUERY 1: Overall Business KPIs
-- =============================================
SELECT 
    COUNT(DISTINCT Customer_ID)              AS total_customers,
    COUNT(DISTINCT Invoice)                  AS total_orders,
    ROUND(SUM(Revenue), 2)                   AS total_revenue,
    ROUND(SUM(Revenue) / 
          COUNT(DISTINCT Invoice), 2)        AS avg_order_value,
    ROUND(SUM(Revenue) / 
          COUNT(DISTINCT Customer_ID), 2)    AS avg_revenue_per_customer
FROM transactions;

-- =============================================
-- QUERY 2: Revenue by Country (Top 10)
-- =============================================
SELECT TOP 10
    Country,
    COUNT(DISTINCT Customer_ID)                      AS customers,
    COUNT(DISTINCT Invoice)                          AS orders,
    ROUND(SUM(Revenue), 2)                           AS total_revenue,
    ROUND(SUM(Revenue) * 100.0 / 
         (SELECT SUM(Revenue) FROM transactions), 1) AS revenue_pct
FROM transactions
GROUP BY Country
ORDER BY total_revenue DESC;

-- =============================================
-- QUERY 3: Monthly Revenue Trend
-- =============================================
SELECT 
    FORMAT(InvoiceDate, 'yyyy-MM')           AS year_month,
    COUNT(DISTINCT Invoice)                  AS orders,
    ROUND(SUM(Revenue), 2)                   AS monthly_revenue
FROM transactions
GROUP BY FORMAT(InvoiceDate, 'yyyy-MM')
ORDER BY year_month;

-- =============================================
-- QUERY 4: Top 10 Products by Revenue
-- =============================================
SELECT TOP 10
    Description,
    COUNT(DISTINCT Invoice)                  AS times_ordered,
    SUM(Quantity)                            AS total_units_sold,
    ROUND(SUM(Revenue), 2)                   AS total_revenue
FROM transactions
GROUP BY Description
ORDER BY total_revenue DESC;