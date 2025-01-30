WITH MonthlyDebits AS (
    SELECT 
        EXTRACT(MONTH FROM dt) AS month,
        SUM(CASE WHEN amount < 0 THEN -amount ELSE 0 END) AS total_debits,
        COUNT(CASE WHEN amount < 0 THEN 1 END) AS debit_transactions
    FROM transactions
    GROUP BY EXTRACT(MONTH FROM dt)
),
MonthlyFees AS (
    SELECT 
        month,
        CASE 
            WHEN debit_transactions < 20 AND total_debits < 1000 THEN 5
            WHEN debit_transactions BETWEEN 20 AND 25 THEN 3
            ELSE 0
        END AS fee
    FROM MonthlyDebits
),
YearlySummary AS (
    SELECT 
        SUM(CASE WHEN amount > 0 THEN amount ELSE 0 END) AS total_credits,
        SUM(CASE WHEN amount < 0 THEN -amount ELSE 0 END) AS total_debits
    FROM transactions
),
TotalFees AS (
    SELECT SUM(fee) AS total_fees FROM MonthlyFees
)
SELECT 
    ys.total_credits - (ys.total_debits + COALESCE(tf.total_fees, 0)) AS year_end_balance
FROM YearlySummary ys, TotalFees tf;