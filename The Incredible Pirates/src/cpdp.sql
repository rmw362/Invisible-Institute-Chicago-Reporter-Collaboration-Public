SELECT subject_race,
       officer_injured,
       (Count(officer_injured)* 100 / (SELECT Count(*) FROM trr_trr)) AS officer_injuries
From trr_trr
GROUP BY officer_injured, subject_race
ORDER BY subject_race
;

SELECT subject_race,
       subject_injured,
       (Count(subject_injured)* 100 / (SELECT Count(*) FROM trr_trr)) AS subject_injuries
FROM trr_trr
GROUP BY subject_race, subject_injured
ORDER BY subject_race, subject_injured
;

SELECT subject_race,
       count(*) AS total_use_of_force_events,
       count(CASE WHEN subject_injured = 'true' THEN 1 END) AS subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END) AS officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS alleged_injuries,
       count(CASE WHEN subject_injured = 'true' THEN 1 END)*100/count(*) AS percent_subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END)*100/count(*) AS percent_officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' AND subject_injured != 'true' THEN 1 END)*100/
       count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS percent_subject_alleged_injuries_not_counted,
       count(CASE WHEN firearm_used = 'true' THEN 1 END)*100/count(*) AS firearm_dicharged,
       count(CASE WHEN taser = 'true' THEN 1 END)*100/count(*) AS taser_used,
       cast(count(CASE WHEN subject_alleged_injury = 'true'THEN 1 END) AS FLOAT)/
            cast(count(CASE WHEN subject_injured = 'true'THEN 1 END) AS FLOAT) AS ratio_of_alleged_to_reported_injury
FROM trr_trr
GROUP BY subject_race
ORDER BY subject_race
;

SELECT subject_race,
       d.race AS officer_race,
       count(*) AS total_use_of_force_events,
       count(CASE WHEN subject_injured = 'true' THEN 1 END) AS subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END) AS officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS alleged_injuries,
       count(CASE WHEN subject_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' AND subject_injured != 'true' THEN 1 END)*100/
       nullif(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END), 0) AS percent_subject_alleged_injuries_not_counted,
       count(CASE WHEN firearm_used = 'true' THEN 1 END)*100/nullif(count(*),0) AS firearm_dicharged,
       count(CASE WHEN taser = 'true' THEN 1 END)*100/nullif(count(*),0) AS taser_used,
       cast(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS FLOAT)/
            nullif(cast(count(CASE WHEN subject_injured = 'true' THEN 1 END) AS FLOAT), 0) AS ratio_of_alleged_to_reported_injury
FROM trr_trr
JOIN data_officer d on d.id = trr_trr.officer_id
GROUP BY subject_race, d.race
ORDER BY subject_race, d.race;

SELECT subject_race,
       firearm_used,
       count(*) AS total_use_of_force_events,
       count(CASE WHEN subject_injured = 'true' THEN 1 END) AS subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END) AS officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS alleged_injuries,
       count(CASE WHEN subject_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' AND subject_injured != 'true' THEN 1 END)*100/
       nullif(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END), 0) AS percent_subject_alleged_injuries_not_counted,
       count(CASE WHEN firearm_used = 'true' THEN 1 END)*100/nullif(count(*),0) AS firearm_dicharged,
       count(CASE WHEN taser = 'true' THEN 1 END)*100/nullif(count(*),0) AS taser_used,
       cast(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS FLOAT)/
            nullif(cast(count(CASE WHEN subject_injured = 'true' THEN 1 END) AS FLOAT), 0) AS ratio_of_alleged_to_reported_injury
FROM trr_trr
JOIN data_officer d on d.id = trr_trr.officer_id
GROUP BY subject_race, firearm_used
ORDER BY subject_race, firearm_used;


SELECT subject_race,
       taser,
       count(*) AS total_use_of_force_events,
       count(CASE WHEN subject_injured = 'true' THEN 1 END) AS subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END) AS officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS alleged_injuries,
       count(CASE WHEN subject_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' AND subject_injured != 'true' THEN 1 END)*100/
       nullif(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END), 0) AS percent_subject_alleged_injuries_not_counted,
       count(CASE WHEN firearm_used = 'true' THEN 1 END)*100/nullif(count(*),0) AS firearm_dicharged,
       count(CASE WHEN taser = 'true' THEN 1 END)*100/nullif(count(*),0) AS taser_used,
       cast(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS FLOAT)/
            nullif(cast(count(CASE WHEN subject_injured = 'true' THEN 1 END) AS FLOAT), 0) AS ratio_of_alleged_to_reported_injury
FROM trr_trr
JOIN data_officer d on d.id = trr_trr.officer_id
GROUP BY subject_race, taser
ORDER BY subject_race, taser;

SELECT subject_race,
       count(*) AS total_use_of_force_events,
       count(CASE WHEN subject_injured = 'true' THEN 1 END) AS subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END) AS officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS alleged_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' OR subject_injured = 'true' THEN 1 END)
           AS alleged_or_documented_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' OR subject_injured = 'true' THEN 1 END)*100/count(*)
           AS percent_alleged_or_documented_injuries,
       count(CASE WHEN subject_injured = 'true' THEN 1 END)*100/count(*) AS percent_subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END)*100/count(*) AS percent_officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' AND subject_injured != 'true' THEN 1 END)*100/
       count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS percent_subject_alleged_injuries_not_counted,
       count(CASE WHEN firearm_used = 'true' THEN 1 END)*100/count(*) AS firearm_dicharged,
       count(CASE WHEN taser = 'true' THEN 1 END)*100/count(*) AS taser_used,
       cast(count(CASE WHEN subject_alleged_injury = 'true'THEN 1 END) AS FLOAT)/
            cast(count(CASE WHEN subject_injured = 'true'THEN 1 END) AS FLOAT) AS ratio_of_alleged_to_reported_injury
FROM trr_trr
GROUP BY subject_race
ORDER BY subject_race
;

SELECT d.race AS officer_race,
       count(*) AS total_use_of_force_events,
       count(CASE WHEN subject_injured = 'true' THEN 1 END) AS subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END) AS officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS alleged_injuries,
       count(CASE WHEN subject_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' AND subject_injured != 'true' THEN 1 END)*100/
       nullif(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END), 0) AS percent_subject_alleged_injuries_not_counted,
       count(CASE WHEN firearm_used = 'true' THEN 1 END)*100/nullif(count(*),0) AS firearm_dicharged,
       count(CASE WHEN taser = 'true' THEN 1 END)*100/nullif(count(*),0) AS taser_used,
       cast(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS FLOAT)/
            nullif(cast(count(CASE WHEN subject_injured = 'true' THEN 1 END) AS FLOAT), 0) AS ratio_of_alleged_to_reported_injury
FROM trr_trr
JOIN data_officer d on d.id = trr_trr.officer_id
GROUP BY d.race
ORDER BY d.race;

SELECT d.gender AS officer_gender,
       count(*) AS total_use_of_force_events,
       count(CASE WHEN subject_injured = 'true' THEN 1 END) AS subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END) AS officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS alleged_injuries,
       count(CASE WHEN subject_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' AND subject_injured != 'true' THEN 1 END)*100/
       nullif(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END), 0) AS percent_subject_alleged_injuries_not_counted,
       count(CASE WHEN firearm_used = 'true' THEN 1 END)*100/nullif(count(*),0) AS firearm_dicharged,
       count(CASE WHEN taser = 'true' THEN 1 END)*100/nullif(count(*),0) AS taser_used,
       cast(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS FLOAT)/
            nullif(cast(count(CASE WHEN subject_injured = 'true' THEN 1 END) AS FLOAT), 0) AS ratio_of_alleged_to_reported_injury
FROM trr_trr
JOIN data_officer d on d.id = trr_trr.officer_id
GROUP BY d.gender
ORDER BY d.gender;


SELECT officer_id,
       count(*) AS total_use_of_force_events,
       count(CASE WHEN subject_injured = 'true' THEN 1 END) AS subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END) AS officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS alleged_injuries,
       count(CASE WHEN subject_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' AND subject_injured != 'true' THEN 1 END)*100/
       nullif(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END), 0) AS percent_subject_alleged_injuries_not_counted,
       count(CASE WHEN firearm_used = 'true' THEN 1 END)*100/nullif(count(*),0) AS firearm_dicharged,
       count(CASE WHEN taser = 'true' THEN 1 END)*100/nullif(count(*),0) AS taser_used,
       cast(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS FLOAT)/
            nullif(cast(count(CASE WHEN subject_injured = 'true' THEN 1 END) AS FLOAT), 0) AS ratio_of_alleged_to_reported_injury
FROM trr_trr
JOIN data_officer d on d.id = trr_trr.officer_id
GROUP BY officer_id
ORDER BY subject_injuries DESC
LIMIT 10;

SELECT officer_id,
       count(*) AS total_use_of_force_events,
       count(CASE WHEN subject_injured = 'true' THEN 1 END) AS subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END) AS officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS alleged_injuries,
       count(CASE WHEN subject_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' AND subject_injured != 'true' THEN 1 END)*100/
       nullif(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END), 0) AS percent_subject_alleged_injuries_not_counted,
       count(CASE WHEN firearm_used = 'true' THEN 1 END)*100/nullif(count(*),0) AS firearm_dicharged,
       count(CASE WHEN taser = 'true' THEN 1 END)*100/nullif(count(*),0) AS taser_used,
       cast(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS FLOAT)/
            nullif(cast(count(CASE WHEN subject_injured = 'true' THEN 1 END) AS FLOAT), 0) AS ratio_of_alleged_to_reported_injury
FROM trr_trr
JOIN data_officer d on d.id = trr_trr.officer_id
GROUP BY officer_id
HAVING count(*)>10
ORDER BY percent_subject_injuries DESC
LIMIT 10;


SELECT officer_id,
       count(*) AS total_use_of_force_events,
       count(CASE WHEN subject_injured = 'true' THEN 1 END) AS subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END) AS officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS alleged_injuries,
       count(CASE WHEN subject_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' AND subject_injured != 'true' THEN 1 END)*100/
       nullif(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END), 0) AS percent_subject_alleged_injuries_not_counted,
       count(CASE WHEN firearm_used = 'true' THEN 1 END)*100/nullif(count(*),0) AS firearm_dicharged,
       count(CASE WHEN taser = 'true' THEN 1 END)*100/nullif(count(*),0) AS taser_used,
       cast(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS FLOAT)/
            nullif(cast(count(CASE WHEN subject_injured = 'true' THEN 1 END) AS FLOAT), 0) AS ratio_of_alleged_to_reported_injury
FROM trr_trr
JOIN data_officer d on d.id = trr_trr.officer_id
GROUP BY officer_id
ORDER BY total_use_of_force_events DESC
LIMIT 10;


SELECT officer_id,
       count(*) AS total_use_of_force_events,
       count(CASE WHEN subject_injured = 'true' THEN 1 END) AS subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END) AS officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS alleged_injuries,
       count(CASE WHEN subject_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' AND subject_injured != 'true' THEN 1 END)*100/
       nullif(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END), 0) AS percent_subject_alleged_injuries_not_counted,
       count(CASE WHEN firearm_used = 'true' THEN 1 END)*100/nullif(count(*),0) AS firearm_dicharged,
       count(CASE WHEN taser = 'true' THEN 1 END)*100/nullif(count(*),0) AS taser_used,
       cast(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS FLOAT)/
            nullif(cast(count(CASE WHEN subject_injured = 'true' THEN 1 END) AS FLOAT), 0) AS ratio_of_alleged_to_reported_injury
FROM trr_trr
JOIN data_officer d on d.id = trr_trr.officer_id
GROUP BY officer_id
HAVING count(*)>10
ORDER BY percent_subject_injuries DESC
LIMIT 10;

SELECT beat,
       count(*) AS total_use_of_force_events,
       count(CASE WHEN subject_injured = 'true' THEN 1 END) AS subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END) AS officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS alleged_injuries,
       count(CASE WHEN subject_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' AND subject_injured != 'true' THEN 1 END)*100/
       nullif(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END), 0) AS percent_subject_alleged_injuries_not_counted,
       count(CASE WHEN firearm_used = 'true' THEN 1 END)*100/nullif(count(*),0) AS firearm_dicharged,
       count(CASE WHEN taser = 'true' THEN 1 END)*100/nullif(count(*),0) AS taser_used,
       cast(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS FLOAT)/
            nullif(cast(count(CASE WHEN subject_injured = 'true' THEN 1 END) AS FLOAT), 0) AS ratio_of_alleged_to_reported_injury

FROM trr_trr
JOIN data_officer d on d.id = trr_trr.officer_id
GROUP BY beat
HAVING count(*)>10
ORDER BY subject_injuries DESC
LIMIT 10;

DROP TABLE IF EXISTS force_allegation_counts;
CREATE TEMP TABLE force_allegation_counts AS
    (SELECT da.officer_id,
            count(CASE WHEN dc.category = 'Use Of Force' THEN 1 END) AS total_use_of_force_complaints
    FROM data_officerallegation da
    JOIN data_allegationcategory dc on dc.id = da.allegation_category_id
        GROUP BY da.officer_id
        ORDER BY total_use_of_force_complaints DESC)
;

DROP TABLE IF EXISTS officer_trrs;
CREATE TEMP TABLE  officer_trrs AS
(SELECT officer_id,
       count(*) AS total_use_of_force_events,
       count(CASE WHEN subject_injured = 'true' THEN 1 END) AS subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END) AS officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS alleged_injuries,
       count(CASE WHEN subject_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_subject_injuries,
       count(CASE WHEN officer_injured = 'true' THEN 1 END)*100/nullif(count(*),0) AS percent_officer_injuries,
       count(CASE WHEN subject_alleged_injury = 'true' AND subject_injured != 'true' THEN 1 END)*100/
       nullif(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END), 0) AS percent_subject_alleged_injuries_not_counted,
       count(CASE WHEN firearm_used = 'true' THEN 1 END)*100/nullif(count(*),0) AS firearm_dicharged,
       count(CASE WHEN taser = 'true' THEN 1 END)*100/nullif(count(*),0) AS taser_used,
       cast(count(CASE WHEN subject_alleged_injury = 'true' THEN 1 END) AS FLOAT)/
            nullif(cast(count(CASE WHEN subject_injured = 'true' THEN 1 END) AS FLOAT), 0) AS ratio_of_alleged_to_reported_injury
FROM trr_trr
JOIN data_officer d on d.id = trr_trr.officer_id
GROUP BY officer_id
HAVING count(*)>10
ORDER BY percent_subject_injuries DESC)
;

SELECT *
FROM force_allegation_counts f
JOIN officer_trrs ot on f.officer_id = ot.officer_id;

SELECT count(*)
FROM trr_trr;