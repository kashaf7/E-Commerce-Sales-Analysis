WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.region,
        c.segment,
        SUM(o.revenue) AS customer_revenue
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_id,
        c.customer_name,
        c.region,
        c.segment
)
SELECT
    customer_id,
    customer_name,
    region,
    segment,
    ROUND(customer_revenue, 2) AS customer_revenue,
    ROUND(
        customer_revenue * 100.0 /
        SUM(customer_revenue) OVER (),
        2
    ) AS revenue_contribution_percentage
FROM customer_revenue
ORDER BY customer_revenue DESC
LIMIT 10;