/*1. Lists the total number of allegations received by each officer over the course of their careers */

select officer_id, count (*)
from data_officerallegation
group by officer_id having count(*) > 1
order by count desc;




/* 2. Sorts the number of allegations received by each year per officer*/

SELECT officer_id, date_part('year', da.incident_date) as year, count(*)
FROM data_officerallegation doa, data_allegation da
WHERE da.id = doa.allegation_id
group by officer_id, year
order by count desc


/* 3. This returns the highest frequency of complaints against an officer by demographic group (race and gender) over their entire career, with a count of the frequency of complaints for each respective demographic category. */

/* BY RACE */

SELECT frequency, officer_id, race  FROM
(
 SELECT
   count(*) AS frequency
   ,MAX(COUNT(*)) OVER (PARTITION BY officer_id) AS Rnk
   ,officer_id
   ,race
 FROM data_officerallegation doa, data_victim dv
 WHERE dv.allegation_id = doa.allegation_id
 GROUP BY officer_id, race
) x
WHERE frequency=Rnk
ORDER BY frequency DESC

/* BY GENDER */

SELECT frequency, officer_id, gender  FROM
(
 SELECT
   count(*) AS frequency
   ,MAX(COUNT(*)) OVER (PARTITION BY officer_id) AS Rnk
   ,officer_id
   ,gender
 FROM data_officerallegation doa, data_victim dv
 WHERE dv.allegation_id = doa.allegation_id
 GROUP BY officer_id, gender
) x
WHERE frequency=Rnk
ORDER BY frequency DESC

/* 4. This returns the most frequent complaint category for each officer over their entire career, as well as a count for the frequency for each respective complaint category. */

SELECT frequency, officer_id, category  FROM
(
 SELECT
   count(*) AS frequency
   ,MAX(COUNT(*)) OVER (PARTITION BY officer_id) AS Rnk
   ,officer_id
   ,category
 FROM data_officerallegation doa, data_allegationcategory dac
 WHERE dac.id = doa.allegation_category_id
 GROUP BY officer_id, category
) x
WHERE frequency=Rnk
ORDER BY frequency DESC
