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
--[2024-06-26 14:17:09] 1 row retrieved starting from 1 in 8 s 696 ms (execution: 8 s 678 ms, fetching: 18 ms)

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
--[2024-06-26 14:42:11] 1 row retrieved starting from 1 in 2 s 964 ms (execution: 2 s 938 ms, fetching: 26 ms)
