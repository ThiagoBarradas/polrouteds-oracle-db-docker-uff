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
--[2024-06-26 12:24:35] 10 rows retrieved starting from 1 in 5 s 883 ms (execution: 5 s 841 ms, fetching: 42 ms)
--[2024-06-26 12:24:55] 10 rows retrieved starting from 1 in 3 s 107 ms (execution: 3 s 91 ms, fetching: 16 ms)
--[2024-06-26 12:25:08] 10 rows retrieved starting from 1 in 2 s 880 ms (execution: 2 s 865 ms, fetching: 15 ms)
--[2024-06-26 12:25:20] 10 rows retrieved starting from 1 in 3 s 72 ms (execution: 3 s 57 ms, fetching: 15 ms)
--[2024-06-26 12:25:31] 10 rows retrieved starting from 1 in 2 s 939 ms (execution: 2 s 924 ms, fetching: 15 ms)
-- avg - 3s 576ms

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
--[2024-06-26 12:26:51] 10 rows retrieved starting from 1 in 64 ms (execution: 37 ms, fetching: 27 ms)
--[2024-06-26 12:27:08] 10 rows retrieved starting from 1 in 45 ms (execution: 8 ms, fetching: 37 ms)
--[2024-06-26 12:27:17] 10 rows retrieved starting from 1 in 44 ms (execution: 8 ms, fetching: 36 ms)
--[2024-06-26 12:27:08] 10 rows retrieved starting from 1 in 45 ms (execution: 8 ms, fetching: 37 ms)
--[2024-06-26 12:27:31] 10 rows retrieved starting from 1 in 43 ms (execution: 9 ms, fetching: 34 ms)
-- avg - 14ms