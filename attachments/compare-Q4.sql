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
	s.oneway IN ('yes', 'oneway') AND
	t.year = 2012;
--[2024-06-26 21:29:47] 1 row retrieved starting from 1 in 4 s 851 ms (execution: 4 s 816 ms, fetching: 35 ms)
--[2024-06-26 21:30:03] 1 row retrieved starting from 1 in 4 s 515 ms (execution: 4 s 490 ms, fetching: 25 ms)
--[2024-06-26 21:30:13] 1 row retrieved starting from 1 in 4 s 238 ms (execution: 4 s 215 ms, fetching: 23 ms)
--[2024-06-26 21:30:27] 1 row retrieved starting from 1 in 5 s 726 ms (execution: 5 s 705 ms, fetching: 21 ms)
--[2024-06-26 21:30:41] 1 row retrieved starting from 1 in 5 s 44 ms (execution: 5 s 19 ms, fetching: 25 ms)

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
	s.oneway IN ('yes', 'oneway') AND
	t.year = 2012;
--[2024-06-26 21:31:56] 1 row retrieved starting from 1 in 1 s 234 ms (execution: 1 s 205 ms, fetching: 29 ms)
--[2024-06-26 21:32:04] 1 row retrieved starting from 1 in 1 s 471 ms (execution: 1 s 443 ms, fetching: 28 ms)
--[2024-06-26 21:32:13] 1 row retrieved starting from 1 in 1 s 205 ms (execution: 1 s 183 ms, fetching: 22 ms)
--[2024-06-26 21:32:23] 1 row retrieved starting from 1 in 1 s 281 ms (execution: 1 s 254 ms, fetching: 27 ms)
--[2024-06-26 21:33:06] 1 row retrieved starting from 1 in 1 s 282 ms (execution: 1 s 239 ms, fetching: 43 ms)

