-- 4. Qual o total de crimes por tipo em vias de
-- mão única da cidade durante o ano de 2012?

-- NOT PARTITIONED
SELECT
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
	PolRouteDS_segment s ON c.segment_id = s.id
WHERE
	s.oneway = 'yes' AND
	t.year = 2012;
--[2024-06-26 14:42:37] 1 row retrieved starting from 1 in 4 s 161 ms (execution: 4 s 126 ms, fetching: 35 ms)

-- PARTITIONED
SELECT
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
	PolRouteDS_segment s ON c.segment_id = s.id
WHERE
	s.oneway = 'yes' AND
	t.year = 2012;
--[2024-06-26 14:45:34] 1 row retrieved starting from 1 in 982 ms (execution: 945 ms, fetching: 37 ms)
