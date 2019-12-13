/* question 1 */
CREATE TABLE officer_years_worked AS
    SELECT id, EXTRACT(year from appointed_date) AS appointed_year,
       EXTRACT(year from COALESCE(resignation_date, '2019-11-18')) AS final_date FROM data_officer;

SELECT oyw.id as officer_id, oyw.final_date - oyw.appointed_year AS years_worked, count(d.id) as count_arrests
from officer_years_worked oyw LEFT JOIN data_officerarrest doa
ON doa.officer_id = oyw.id
LEFT JOIN data_arrest d
ON d.id = doa.arrest_id
Group by oyw.id, years_worked;
-- limit 15;




/* question 2 */
select d.officer_id, count(da.id) as count_arrests, count(d.allegation_id) as count_compaints
from data_officerarrest doa LEFT JOIN data_arrest da
ON doa.arrest_id = da.id
LEFT JOIN data_officerallegation d
ON d.officer_id = doa.officer_id
group by d.officer_id;
-- Limit 15;

/* question 3 */
SELECT dc.race,count(doa.allegation_id) as count_complaints, count(dar.id) as count_arrests
FROM data_complainant dc INNER JOIN data_officerallegation doa
ON dc.id = doa.id
INNER JOIN data_allegation da
ON doa.allegation_id = da.id
LEFT JOIN data_officerarrest doa2
ON doa2.officer_id = doa.officer_id
LEFT JOIN data_arrest dar
ON doa2.arrest_id = dar.id
GROUP BY dc.race;

/* question 4 */

SELECT current_category, count(current_category) AS category_count FROM copa_officer
GROUP BY current_category;

/*This does not work because beat join id are different types, currently consulting with prof Rogers to figure it out */
-- SELECT co.current_category, count(co.current_category) AS category_count, count(da.id) as count_arrests, cast(co.beat as int), cast(da.beat as int)
-- -- FROM copa_officer co LEFT JOIN data_arrest da
-- -- ON co.beat = da.beat
-- -- GROUP BY current_category
-- -- limit 15;