CREATE TABLE PolRouteDS_time_frag (
    id INTEGER,
    period VARCHAR2(128),
    day INTEGER,
    month INTEGER,
    year INTEGER,
    weekday VARCHAR2(128),
    month_weekday AS (
        COALESCE(TO_CHAR(month, 'FM00'), '-1') || '_' || COALESCE(weekday, 'unknown')
    ),
    CONSTRAINT PolRouteDS_time_frag_pk PRIMARY KEY (id)
)
PARTITION BY LIST (year)
SUBPARTITION BY LIST (month_weekday)
(
    PARTITION p2010 VALUES (2010)
    (
        SUBPARTITION p2010_nov VALUES
            ('11_unknown',
             '11_monday',
             '11_tuesday',
             '11_wednesday',
             '11_thursday',
             '11_friday',
             '11_saturday',
             '11_sunday'),
        SUBPARTITION p2010_rest VALUES (DEFAULT)
    ),
    PARTITION p2012 VALUES (2012)
    (
        SUBPARTITION p2012_all_month_weekday VALUES (DEFAULT)
    ),
    PARTITION p2015 VALUES (2015)
    (
        SUBPARTITION p2015_all_month_weekday VALUES (DEFAULT)
    ),
    PARTITION p2016 VALUES (2016)
    (
        SUBPARTITION p2016_all_month_weekday VALUES (DEFAULT)
    ),
    PARTITION p_others VALUES (2006, 2007, 2008, 2009, 2011, 2013, 2014)
    (
        SUBPARTITION p_others_all_month_weekday VALUES (DEFAULT)
    ),
    PARTITION p2017 VALUES (2017)
    (
        SUBPARTITION p2017_all_month_weekday VALUES (DEFAULT)
    ),
    PARTITION p2018 VALUES (2018)
    (
        SUBPARTITION p2018_weekends VALUES
            ('01_sunday', '01_saturday',
             '02_sunday', '02_saturday',
             '03_sunday', '03_saturday',
             '04_sunday', '04_saturday',
             '05_sunday', '05_saturday',
             '06_sunday', '06_saturday',
             '07_sunday', '07_saturday',
             '08_sunday', '08_saturday',
             '09_sunday', '09_saturday',
             '10_sunday', '10_saturday',
             '11_sunday', '11_saturday',
             '12_sunday', '12_saturday'),
        SUBPARTITION p2018_weekdays VALUES (DEFAULT)
    ),
    PARTITION p_other_years VALUES (DEFAULT)
    (
        SUBPARTITION p_other_years_all_month_weekday VALUES (DEFAULT)
    )
);

CREATE TABLE PolRouteDS_crime_frag
(
    id integer,
    total_feminicide integer,
    total_homicide integer,
    total_felony_murder integer,
    total_bodily_harm integer,
    total_theft_cellphone integer,
    total_armed_robbery_cellphone integer,
    total_theft_auto integer,
    total_armed_robbery_auto integer,
    segment_id integer,
    time_id integer NOT NULL,
    CONSTRAINT PolRouteDS_crime_frag_pk PRIMARY KEY (id),
    CONSTRAINT PolRouteDS_crime_frag_PolRouteDS_segment_fk
        FOREIGN KEY (segment_id) REFERENCES PolRouteDS_segment(id),
    CONSTRAINT PolRouteDS_crime_frag_PolRouteDS_time_frag_fk
        FOREIGN KEY (time_id) REFERENCES PolRouteDS_time_frag(id)
)
ENABLE ROW MOVEMENT
PARTITION BY REFERENCE(PolRouteDS_crime_frag_PolRouteDS_time_frag_fk);
