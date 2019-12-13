/* Question 1 */

/* this chunk of code gives the most frequent complaints from specific race/demographic group per officer - this generates the nodes of the graph*/
select distinct on (officer_id) officer_id, most_frequent_value from (
SELECT doa.officer_id, dc.race AS most_frequent_value, count(*) as _count
FROM data_officerallegation doa, data_complainant dc
where doa.allegation_id = dc.allegation_id
GROUP BY doa.officer_id, dc.race) a
ORDER BY officer_id, _count DESC;

/* this chunk generates the links - the relationships between officers based on volume of complaints per demographic */
SELECT      dc.race, doa.officer_id, dob.officer_id
FROM        data_officerallegation doa
INNER JOIN  data_officerallegation dob on doa.allegation_id = dob.allegation_id
inner join  data_complainant dc on doa.allegation_id = dc.allegation_id
WHERE       doa.officer_id < dob.officer_id
ORDER BY    doa.officer_id, dob.officer_id
limit 200;



/* Question 2 */

/* this chunk gives officers based on seniority and the number of accusations that they have during their time  - this generates the nodes, where we group based on the years worked (floor of years worked)*/

SELECT oyw.id as officer_id, oyw.final_date - oyw.appointed_year AS years_worked, count(da.allegation_id) as count_allegations
from officer_years_worked oyw LEFT JOIN data_officerallegation da
on oyw.id = da.officer_id
GROUP BY oyw.id, years_worked
limit 200;

/* this chunk gives the links between officers and count of allegations */

SELECT      doa.allegation_id, doa.officer_id, dob.officer_id
FROM        data_officerallegation doa
INNER JOIN  data_officerallegation dob on doa.allegation_id = dob.allegation_id
WHERE       doa.officer_id < dob.officer_id
ORDER BY    doa.officer_id, dob.officer_id
limit 200;