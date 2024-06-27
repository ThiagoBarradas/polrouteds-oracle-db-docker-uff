-- 6. Quais os IDs de segmentos que possuíam o maior índice criminal
-- (soma de ocorrências de todos os tipos de crimes), durante o mês de Novembro de 2010?

-- NOT PARTITIONED
SELECT
	c.segment_id AS segment_id,
	SUM(c.total_feminicide) +
		SUM(c.total_homicide) +
		SUM(c.total_felony_murder) +
		SUM(c.total_bodily_harm) +
		SUM(c.total_theft_cellphone) +
		SUM(c.total_armed_robbery_cellphone) +
		SUM(c.total_theft_auto) +
		SUM(c.total_armed_robbery_auto) AS crimes_sum
FROM
	PolRouteDS_crime c INNER JOIN
	PolRouteDS_time t ON c.time_id = t.id
WHERE
	t.month = 11 AND
	t.year = 2010
GROUP BY
    c.segment_id
ORDER BY
	2 DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
--[2024-06-26 21:40:54] 10 rows retrieved starting from 1 in 3 s 808 ms (execution: 3 s 794 ms, fetching: 14 ms)
--[2024-06-26 21:42:55] 10 rows retrieved starting from 1 in 3 s 407 ms (execution: 3 s 391 ms, fetching: 16 ms)
--[2024-06-26 21:43:08] 10 rows retrieved starting from 1 in 3 s 880 ms (execution: 3 s 865 ms, fetching: 15 ms)
--[2024-06-26 21:43:50] 10 rows retrieved starting from 1 in 3 s 72 ms (execution: 3 s 57 ms, fetching: 15 ms)
--[2024-06-26 21:45:31] 10 rows retrieved starting from 1 in 2 s 939 ms (execution: 2 s 924 ms, fetching: 15 ms)

-- PARTITIONED
SELECT
	c.segment_id AS segment_id,
	SUM(c.total_feminicide) +
		SUM(c.total_homicide) +
		SUM(c.total_felony_murder) +
		SUM(c.total_bodily_harm) +
		SUM(c.total_theft_cellphone) +
		SUM(c.total_armed_robbery_cellphone) +
		SUM(c.total_theft_auto) +
		SUM(c.total_armed_robbery_auto) AS crimes_sum
FROM
	PolRouteDS_crime_frag c INNER JOIN
	PolRouteDS_time_frag t ON c.time_id = t.id
WHERE
	t.month = 11 AND
	t.year = 2010
GROUP BY
    c.segment_id
ORDER BY
	2 DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
--[2024-06-26 21:41:25] 10 rows retrieved starting from 1 in 40 ms (execution: 10 ms, fetching: 30 ms)
--[2024-06-26 21:41:37] 10 rows retrieved starting from 1 in 52 ms (execution: 9 ms, fetching: 43 ms)
--[2024-06-26 21:41:48] 10 rows retrieved starting from 1 in 34 ms (execution: 8 ms, fetching: 26 ms)
--[2024-06-26 21:42:10] 10 rows retrieved starting from 1 in 68 ms (execution: 13 ms, fetching: 55 ms)
--[2024-06-26 21:42:25] 10 rows retrieved starting from 1 in 37 ms (execution: 9 ms, fetching: 28 ms)