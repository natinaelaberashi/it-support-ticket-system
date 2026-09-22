-- Transaction Operations Analytics
-- Synthetic dataset: data/transactions.csv
SELECT COUNT(*) AS total_transactions,
 SUM(CASE WHEN status = 'Approved' THEN 1 ELSE 0 END) AS approved,
 SUM(CASE WHEN status = 'Declined' THEN 1 ELSE 0 END) AS declined,
 ROUND(100.0 * SUM(CASE WHEN status = 'Approved' THEN 1 ELSE 0 END) / COUNT(*), 2) AS approval_rate_pct
FROM transactions;

SELECT channel, COUNT(*) AS transactions,
 ROUND(AVG(processing_ms), 0) AS avg_processing_ms,
 ROUND(100.0 * SUM(CASE WHEN status='Approved' THEN 1 ELSE 0 END) / COUNT(*), 2) AS approval_rate_pct
FROM transactions GROUP BY channel ORDER BY approval_rate_pct DESC;

SELECT decline_code, COUNT(*) AS decline_count,
 ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM transactions WHERE status='Declined'), 2) AS share_of_declines_pct
FROM transactions WHERE status='Declined' GROUP BY decline_code ORDER BY decline_count DESC;

SELECT date, COUNT(*) AS transactions,
 SUM(CASE WHEN status='Declined' THEN 1 ELSE 0 END) AS declines,
 ROUND(AVG(processing_ms), 0) AS avg_processing_ms
FROM transactions GROUP BY date ORDER BY date;