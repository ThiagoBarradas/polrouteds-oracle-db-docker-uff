-- 1. Qual o total de crimes por tipo e por segmento das ruas do distrito de IGUATEMI durante o ano de 2016?

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

-- 2. Qual o total de crimes por tipo e por segmento das ruas do distrito de IGUATEMI entre 2006 e 2016?

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

-- 3. Qual o total de ocorrências de Roubo de Celular e roubo de carro no bairro de SANTA EFIGÊNIA em 2015?

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

-- 4. Qual o total de crimes por tipo em vias de mão única da cidade durante o ano de 2012?

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

-- 5. Qual o total de roubos de carro e celular em todos os segmentos durante o ano de 2017?

SELECT 
    SUM(c.total_armed_robbery_cellphone) AS total_armed_robbery_cellphone_sum,
    SUM(c.total_armed_robbery_auto) AS total_armed_robbery_auto_sum
FROM 
	PolRouteDS_crime c INNER JOIN 
	PolRouteDS_time t ON c.time_id = t.id
WHERE 
	t.year = 2017;

-- 6. Quais os IDs de segmentos que possuíam o maior índice criminal (soma de ocorrências de todos os tipos de crimes), durante o mês de Novembro de 2010?

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

-- 7. Quais os IDs dos segmentos que possuíam o maior índice criminal (soma de ocorrências de todos os tipos de crimes) durante os finais de semana do ano de 2018?

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
