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
--[2024-06-26 14:06:49] 10 rows retrieved starting from 1 in 3 s 787 ms (execution: 3 s 750 ms, fetching: 37 ms)

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
-- [2024-06-26 14:07:14] 10 rows retrieved starting from 1 in 102 ms (execution: 77 ms, fetching: 25 ms)
