-- 1. Qual o total de crimes por tipo e por segmento das ruas do
-- distrito de IGUATEMI durante o ano de 2016?

-- NOT PARTITIONED
SELECT
	s.id AS segment_id,
	SUM(c.total_feminicide) AS total_feminicide_sum,
    SUM(c.total_homicide) AS total_homicide_sum,
    SUM(c.total_felony_murder) AS total_felony_murder_sum,
    SUM(c.total_bodily_harm) AS total_bodily_harm_sum,
    SUM(c.total_theft_cellphone) AS total_theft_cellphone_sum,
    SUM(c.total_armed_robbery_cellphone) AS total_armed_robbery_cellphone_sum,
    SUM(c.total_theft_auto) AS total_theft_auto_sum,
    SUM(c.total_armed_robbery_auto) AS total_armed_robbery_auto_sum
FROM
	PolRouteDS_crime c INNER JOIN
	PolRouteDS_time t ON c.time_id = t.id INNER JOIN
	PolRouteDS_segment s ON c.segment_id = s.id INNER JOIN
	PolRouteDS_vertice v ON (s.start_vertice_id = v.id OR s.final_vertice_id = v.id) INNER JOIN
	PolRouteDS_district d ON v.district_id = d.id
WHERE
	d.name = 'IGUATEMI' AND
	t.year = 2016
GROUP BY
	s.id;
--[2024-06-26 20:44:03] 500 rows retrieved starting from 1 in 40 s 111 ms (execution: 39 s 956 ms, fetching: 155 ms)
--[2024-06-26 20:44:59] 500 rows retrieved starting from 1 in 38 s 183 ms (execution: 38 s 83 ms, fetching: 100 ms)
--[2024-06-26 20:47:32] 500 rows retrieved starting from 1 in 43 s 345 ms (execution: 43 s 234 ms, fetching: 111 ms)
--[2024-06-26 20:49:16] 500 rows retrieved starting from 1 in 40 s 421 ms (execution: 40 s 361 ms, fetching: 60 ms)
--[2024-06-26 20:52:24] 500 rows retrieved starting from 1 in 39 s 543 ms (execution: 39 s 448 ms, fetching: 95 ms)

-- PARTITIONED
SELECT
	s.id AS segment_id,
	SUM(c.total_feminicide) AS total_feminicide_sum,
    SUM(c.total_homicide) AS total_homicide_sum,
    SUM(c.total_felony_murder) AS total_felony_murder_sum,
    SUM(c.total_bodily_harm) AS total_bodily_harm_sum,
    SUM(c.total_theft_cellphone) AS total_theft_cellphone_sum,
    SUM(c.total_armed_robbery_cellphone) AS total_armed_robbery_cellphone_sum,
    SUM(c.total_theft_auto) AS total_theft_auto_sum,
    SUM(c.total_armed_robbery_auto) AS total_armed_robbery_auto_sum
FROM
	PolRouteDS_crime_frag c INNER JOIN
	PolRouteDS_time_frag t ON c.time_id = t.id INNER JOIN
	PolRouteDS_segment s ON c.segment_id = s.id INNER JOIN
	PolRouteDS_vertice v ON (s.start_vertice_id = v.id OR s.final_vertice_id = v.id) INNER JOIN
	PolRouteDS_district d ON v.district_id = d.id
WHERE
	d.name = 'IGUATEMI' AND
	t.year = 2016
GROUP BY
	s.id;
--[2024-06-26 20:53:26] 500 rows retrieved starting from 1 in 28 s 477 ms (execution: 28 s 414 ms, fetching: 63 ms)
--[2024-06-26 20:54:35] 500 rows retrieved starting from 1 in 32 s 509 ms (execution: 32 s 434 ms, fetching: 65 ms)
--[2024-06-26 20:55:30] 500 rows retrieved starting from 1 in 31 s 94 ms (execution: 31 s 41 ms, fetching: 53 ms)
--[2024-06-26 20:56:21] 500 rows retrieved starting from 1 in 31 s 59 ms (execution: 30 s 973 ms, fetching: 86 ms)
--[2024-06-26 20:57:13] 500 rows retrieved starting from 1 in 32 s 397 ms (execution: 32 s 336 ms, fetching: 61 ms)




