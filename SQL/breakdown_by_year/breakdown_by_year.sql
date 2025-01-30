WITH yearly_counts AS (
    SELECT
        TO_CHAR(o.ord_datetime, 'YYYY') AS year, -- Преобразуем год в строку
        a.an_id,
        COUNT(a.an_id) AS cnt
    FROM Orders o
    INNER JOIN Analysis a ON o.ord_id = a.an_id
    GROUP BY TO_CHAR(o.ord_datetime, 'YYYY'), a.an_id
),
ranked_data AS (
    SELECT
        year,
        an_id,
        cnt,
        ROW_NUMBER() OVER (PARTITION BY year ORDER BY cnt DESC, an_id ASC) AS rnk
    FROM yearly_counts
)
SELECT
    year,
    an_id,
    cnt
FROM ranked_data
WHERE rnk = 1
ORDER BY year, an_id;

-- year    an_id    cnt    
--------------------
-- 2018    6        50     
-- 2019    9        47     
-- 2019    13       47     
-- 2020    7        51     

