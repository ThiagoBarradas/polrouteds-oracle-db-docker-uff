-- count by subpartition
WITH ids AS (
    SELECT dbms_rowid.rowid_object(ROWID) AS data_object_id FROM POLROUTEDS_TIME_FRAG
)

SELECT
    COUNT(*), subobject_name
FROM
    user_objects uo INNER JOIN
    ids ON uo.data_object_id = ids.data_object_id
WHERE uo.object_name = 'POLROUTEDS_TIME_FRAG'
GROUP BY subobject_name
ORDER BY 2;

-- check which partition has some row
SELECT * FROM POLROUTEDS_TIME_FRAG WHERE year = 2010 and month != 11; --20
SELECT * FROM POLROUTEDS_TIME_FRAG WHERE year = 2010 and month = 11; --248
SELECT * FROM POLROUTEDS_TIME_FRAG WHERE year = 2018 and weekday = 'monday'; --655
SELECT * FROM POLROUTEDS_TIME_FRAG WHERE year = 2018 and weekday = 'sunday'; --1881
SELECT * FROM user_objects WHERE data_object_id IN
    (SELECT dbms_rowid.rowid_object(ROWID) data_object_id
     FROM POLROUTEDS_TIME_FRAG WHERE id IN (20,248,655,1881));

-- test count by year partition

SELECT
    COUNT(*)
FROM
    PolRouteDS_crime;

SELECT
    COUNT(*)
FROM
    PolRouteDS_crime c INNER JOIN
	PolRouteDS_time t ON c.time_id = t.id
WHERE year between 2006 AND 2016;

SELECT
    COUNT(*)
FROM
    PolRouteDS_crime c INNER JOIN
	PolRouteDS_time t ON c.time_id = t.id
WHERE year = 2016;

SELECT
    COUNT(*)
FROM
    PolRouteDS_crime c INNER JOIN
	PolRouteDS_time t ON c.time_id = t.id
WHERE year = 2015;

SELECT
    COUNT(*)
FROM
    PolRouteDS_crime c INNER JOIN
	PolRouteDS_time t ON c.time_id = t.id
WHERE year = 2010;

SELECT
    COUNT(*)
FROM
    PolRouteDS_crime c INNER JOIN
	PolRouteDS_time t ON c.time_id = t.id
WHERE year = 2010 AND month = 11;

SELECT
    COUNT(*)
FROM
    PolRouteDS_crime c INNER JOIN
	PolRouteDS_time t ON c.time_id = t.id
WHERE year = 2012;