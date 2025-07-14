# Average Rolling solution.
WITH daily_totals AS (
    SELECT 
        DATE(transaction_time) AS transaction_date,
        SUM(transaction_amount) AS total_amount
    FROM transactions
    WHERE DATE(transaction_time) BETWEEN '2021-01-29' AND '2021-01-31'
    GROUP BY DATE(transaction_time)
)
SELECT 
    transaction_date,
    AVG(total_amount) OVER (
        ORDER BY transaction_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_3day_avg
FROM daily_totals
WHERE transaction_date = '2021-01-31';
