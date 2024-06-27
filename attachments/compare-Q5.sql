-- 5. Qual o total de roubos de carro e celular em todos os
-- segmentos durante o ano de 2017?

-- NOT PARTITIONED
SELECT
    SUM(c.total_armed_robbery_cellphone) AS total_armed_robbery_cellphone_sum,
    SUM(c.total_armed_robbery_auto) AS total_armed_robbery_auto_sum
FROM
	PolRouteDS_crime c INNER JOIN
	PolRouteDS_time t ON c.time_id = t.id
WHERE
	t.year = 2017;
--[2024-06-26 21:33:23] 1 row retrieved starting from 1 in 2 s 579 ms (execution: 2 s 555 ms, fetching: 24 ms)
--[2024-06-26 21:33:45] 1 row retrieved starting from 1 in 2 s 350 ms (execution: 2 s 332 ms, fetching: 18 ms)
--[2024-06-26 21:33:54] 1 row retrieved starting from 1 in 2 s 476 ms (execution: 2 s 461 ms, fetching: 15 ms)
--[2024-06-26 21:34:02] 1 row retrieved starting from 1 in 2 s 615 ms (execution: 2 s 598 ms, fetching: 17 ms)
--[2024-06-26 21:34:14] 1 row retrieved starting from 1 in 2 s 577 ms (execution: 2 s 554 ms, fetching: 23 ms)

-- PARTITIONED
SELECT
    SUM(c.total_armed_robbery_cellphone) AS total_armed_robbery_cellphone_sum,
    SUM(c.total_armed_robbery_auto) AS total_armed_robbery_auto_sum
FROM
	PolRouteDS_crime_frag c INNER JOIN
	PolRouteDS_time_frag t ON c.time_id = t.id
WHERE
	t.year = 2017;
--[2024-06-26 21:34:25] 1 row retrieved starting from 1 in 267 ms (execution: 250 ms, fetching: 17 ms)
--[2024-06-26 21:34:35] 1 row retrieved starting from 1 in 386 ms (execution: 356 ms, fetching: 30 ms)
--[2024-06-26 21:34:42] 1 row retrieved starting from 1 in 375 ms (execution: 339 ms, fetching: 36 ms)
--[2024-06-26 21:38:19] 1 row retrieved starting from 1 in 406 ms (execution: 385 ms, fetching: 21 ms)
--[2024-06-26 21:39:10] 1 row retrieved starting from 1 in 749 ms (execution: 729 ms, fetching: 20 ms)


