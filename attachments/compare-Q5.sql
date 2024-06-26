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
--[2024-06-26 14:51:23] 1 row retrieved starting from 1 in 2 s 687 ms (execution: 2 s 666 ms, fetching: 21 ms)

-- PARTITIONED
SELECT
    SUM(c.total_armed_robbery_cellphone) AS total_armed_robbery_cellphone_sum,
    SUM(c.total_armed_robbery_auto) AS total_armed_robbery_auto_sum
FROM
	PolRouteDS_crime_frag c INNER JOIN
	PolRouteDS_time_frag t ON c.time_id = t.id
WHERE
	t.year = 2017;
--[2024-06-26 14:51:33] 1 row retrieved starting from 1 in 375 ms (execution: 343 ms, fetching: 32 ms)
