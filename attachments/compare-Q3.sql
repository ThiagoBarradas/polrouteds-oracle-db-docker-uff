-- 3. Qual o total de ocorrências de Roubo de Celular e roubo de carro
-- no bairro de SANTA EFIGÊNIA em 2015?

-- NOT PARTITIONED
SELECT
    SUM(c.total_armed_robbery_cellphone) AS total_armed_robbery_cellphone_sum,
    SUM(c.total_armed_robbery_auto) AS total_armed_robbery_auto_sum
FROM
	PolRouteDS_crime c INNER JOIN
	PolRouteDS_time t ON c.time_id = t.id INNER JOIN
	PolRouteDS_segment s ON c.segment_id = s.id INNER JOIN
	PolRouteDS_vertice v ON (s.start_vertice_id = v.id OR s.final_vertice_id = v.id) INNER JOIN
	PolRouteDS_neighborhood n ON v.neighborhood_id = n.id
WHERE
	n.name = 'Santa Efig�nia' AND
	t.year = 2015;
--[2024-06-26 21:25:49] 1 row retrieved starting from 1 in 5 s 982 ms (execution: 5 s 954 ms, fetching: 28 ms)
--[2024-06-26 21:26:04] 1 row retrieved starting from 1 in 5 s 497 ms (execution: 5 s 470 ms, fetching: 27 ms)
--[2024-06-26 21:26:21] 1 row retrieved starting from 1 in 5 s 635 ms (execution: 5 s 615 ms, fetching: 20 ms)
--[2024-06-26 21:26:37] 1 row retrieved starting from 1 in 5 s 282 ms (execution: 5 s 256 ms, fetching: 26 ms)
--[2024-06-26 21:26:59] 1 row retrieved starting from 1 in 5 s 321 ms (execution: 5 s 302 ms, fetching: 19 ms)

-- PARTITIONED
SELECT
    SUM(c.total_armed_robbery_cellphone) AS total_armed_robbery_cellphone_sum,
    SUM(c.total_armed_robbery_auto) AS total_armed_robbery_auto_sum
FROM
	PolRouteDS_crime_frag c INNER JOIN
	PolRouteDS_time_frag t ON c.time_id = t.id INNER JOIN
	PolRouteDS_segment s ON c.segment_id = s.id INNER JOIN
	PolRouteDS_vertice v ON (s.start_vertice_id = v.id OR s.final_vertice_id = v.id) INNER JOIN
	PolRouteDS_neighborhood n ON v.neighborhood_id = n.id
WHERE
	n.name = 'Santa Efig�nia' AND
	t.year = 2015;
--[2024-06-26 21:27:54] 1 row retrieved starting from 1 in 3 s 141 ms (execution: 3 s 110 ms, fetching: 31 ms)
--[2024-06-26 21:28:07] 1 row retrieved starting from 1 in 3 s 382 ms (execution: 3 s 364 ms, fetching: 18 ms)
--[2024-06-26 21:28:20] 1 row retrieved starting from 1 in 3 s 639 ms (execution: 3 s 617 ms, fetching: 22 ms)
--[2024-06-26 21:28:33] 1 row retrieved starting from 1 in 3 s 697 ms (execution: 3 s 673 ms, fetching: 24 ms)
--[2024-06-26 21:28:47] 1 row retrieved starting from 1 in 3 s 658 ms (execution: 3 s 639 ms, fetching: 19 ms)





