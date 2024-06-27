-- 7. Quais os IDs dos segmentos que possuíam o maior índice criminal (soma de
-- ocorrências de todos os tipos de crimes) durante os finais de semana do ano de 2018?

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
	t.weekday IN ('sunday', 'saturday') AND
	t.year = 2018
GROUP BY
    c.segment_id
ORDER BY
	2 DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
--[2024-06-26 21:43:52] 10 rows retrieved starting from 1 in 3 s 405 ms (execution: 3 s 358 ms, fetching: 47 ms)
--[2024-06-26 21:45:10] 10 rows retrieved starting from 1 in 2 s 217 ms (execution: 2 s 195 ms, fetching: 22 ms)
--[2024-06-26 21:45:53] 10 rows retrieved starting from 1 in 2 s 332 ms (execution: 2 s 312 ms, fetching: 20 ms)
--[2024-06-26 21:46:47] 10 rows retrieved starting from 1 in 2 s 756 ms (execution: 2 s 737 ms, fetching: 19 ms)
--[2024-06-26 21:47:03] 10 rows retrieved starting from 1 in 2 s 818 ms (execution: 2 s 794 ms, fetching: 24 ms)

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
	t.weekday IN ('sunday', 'saturday') AND
	t.year = 2018
GROUP BY
    c.segment_id
ORDER BY
	2 DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
--[2024-06-26 21:47:39] 10 rows retrieved starting from 1 in 115 ms (execution: 94 ms, fetching: 21 ms)
--[2024-06-26 21:48:10] 10 rows retrieved starting from 1 in 152 ms (execution: 122 ms, fetching: 30 ms)
--[2024-06-26 21:48:29] 10 rows retrieved starting from 1 in 103 ms (execution: 81 ms, fetching: 22 ms)
--[2024-06-26 21:49:19] 10 rows retrieved starting from 1 in 127 ms (execution: 102 ms, fetching: 25 ms)
--[2024-06-26 21:47:50] 10 rows retrieved starting from 1 in 141 ms (execution: 108 ms, fetching: 33 ms)

