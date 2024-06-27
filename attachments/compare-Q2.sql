-- 2. Qual o total de crimes por tipo e por segmento das ruas do
-- distrito de IGUATEMI entre 2006 e 2016?

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
	t.year >= 2006 AND
	t.year <= 2016
GROUP BY
	s.id;
--[2024-06-26 21:01:03] 500 rows retrieved starting from 1 in 37 s 507 ms (execution: 37 s 432 ms, fetching: 75 ms)
--[2024-06-26 21:02:38] 500 rows retrieved starting from 1 in 38 s 164 ms (execution: 38 s 95 ms, fetching: 69 ms)
--[2024-06-26 21:03:41] 500 rows retrieved starting from 1 in 37 s 500 ms (execution: 37 s 440 ms, fetching: 60 ms)
--[2024-06-26 21:04:49] 500 rows retrieved starting from 1 in 39 s 434 ms (execution: 39 s 374 ms, fetching: 60 ms)
--[2024-06-26 21:05:58] 500 rows retrieved starting from 1 in 38 s 269 ms (execution: 38 s 214 ms, fetching: 55 ms)

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
	t.year >= 2006 AND
	t.year <= 2016
GROUP BY
	s.id;
--[2024-06-26 14:15:32] 500 rows retrieved starting from 1 in 25 s 749 ms (execution: 25 s 690 ms, fetching: 59 ms)
--[2024-06-26 21:06:39] 500 rows retrieved starting from 1 in 27 s 229 ms (execution: 27 s 150 ms, fetching: 79 ms)
--[2024-06-26 21:19:49] 500 rows retrieved starting from 1 in 29 s 855 ms (execution: 29 s 802 ms, fetching: 53 ms)
--[2024-06-26 21:23:31] 500 rows retrieved starting from 1 in 28 s 233 ms (execution: 28 s 187 ms, fetching: 46 ms)
--[2024-06-26 21:24:31] 500 rows retrieved starting from 1 in 27 s 485 ms (execution: 27 s 440 ms, fetching: 45 ms)