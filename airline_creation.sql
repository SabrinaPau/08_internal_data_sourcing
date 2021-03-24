DROP TABLE IF EXISTS flights CASCADE;

    CREATE TABLE flights (  
      year smallint DEFAULT NULL,
      month smallint DEFAULT NULL,
      day smallint DEFAULT NULL,
      flightdate date DEFAULT NULL,
      dep_time varchar(4) NOT NULL DEFAULT '',
      sched_dep_time smallint DEFAULT NULL,
      dep_delay smallint DEFAULT NULL,
      arr_time varchar(4) NOT NULL DEFAULT '',
      sched_arr_time smallint DEFAULT NULL,
      arr_delay smallint DEFAULT NULL,
      carrier varchar(2) NOT NULL DEFAULT '',
      tailnum varchar(6) DEFAULT NULL,
      flight smallint DEFAULT NULL,
      origin varchar(3) NOT NULL DEFAULT '',
      dest varchar(3) NOT NULL DEFAULT '',
      air_time smallint DEFAULT NULL,
      distance smallint DEFAULT NULL,
      cancelled smallint DEFAULT NULL,
      diverted smallint DEFAULT NULL
    );

    CREATE INDEX IF NOT EXISTS year_idx ON flights (year);
    CREATE INDEX IF NOT EXISTS date_idx ON flights (year, month, day);
    CREATE INDEX IF NOT EXISTS origin_idx ON flights (origin);
    CREATE INDEX IF NOT EXISTS dest_idx ON flights (dest);
    CREATE INDEX IF NOT EXISTS carrier_idx ON flights (carrier);
    CREATE INDEX IF NOT EXISTS tailnum_idx ON flights (tailnum);

DROP TABLE IF EXISTS carriers;

CREATE TABLE carriers (
  carrier varchar(7) NOT NULL DEFAULT '',
  name varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (carrier)
);

DROP TABLE IF EXISTS airports;

CREATE TABLE airports (
  faa varchar(3) NOT NULL DEFAULT '',
  name varchar(255),
  lat decimal(10,7) DEFAULT NULL,
  lon decimal(10,7) DEFAULT NULL,
  alt int DEFAULT NULL,
  tz smallint DEFAULT NULL,
  dst char(1),
  city varchar(255) DEFAULT NULL,
  country varchar(255) DEFAULT NULL,
  PRIMARY KEY (faa)
);

DROP TABLE IF EXISTS planes;

CREATE TABLE planes (
  tailnum varchar(6) NOT NULL DEFAULT '',
  year int DEFAULT NULL,
  type text,
  manufacturer text,
  model text,
  engines int DEFAULT NULL,
  seats int DEFAULT NULL,
  speed int DEFAULT NULL,
  engine text,
  PRIMARY KEY (tailnum)
);

DROP TABLE IF EXISTS flights

select count(*) from flights;
select * from flights limit 2

select day, count(*) from flights group by 1

select count(*) from airports;
select * from airports_alt limit 2;


select count(*) from nyflights

select * from carriers limit 2

drop table nyflights

