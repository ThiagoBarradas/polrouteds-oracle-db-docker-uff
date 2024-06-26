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
-- [2024-06-26 14:14:53] 500 rows retrieved starting from 1 in 30 s 507 ms (execution: 30 s 432 ms, fetching: 75 ms)


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
