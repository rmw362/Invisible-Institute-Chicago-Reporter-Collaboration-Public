Checkpoint 1: Hawkins Gay, Alex Leidner, Ramsey Wehbe


Theme:
 	As members of the healthcare community our team would like to look into complaints and use of force in which injury was reported. 
 Either alleged or sustained injury has the possibility to incite EMS or healthcare resource allocation for physical or mental treatment.  
 Interesting topics within this overarching theme include assessing differences in race, gender and neighborhood as it relates to injury 
 prevalence.  This can be examined for officer injury as well as complainant; in particular, it would be interesting to explore these 
 demographics and potentially elicit patterns of abuse that could prevent further injury. The severity and immediacy of EMS services could 
 speak to restraint, or lack thereof, in the extreme, and even potentially to officer regret and responsibility in trying to immediately 
 alleviate mistakes.
	As the course advances this topic would lend itself to traversing through the data parsing and visualization modules
planned.While these are enumerated below, the ultimate task would be to try to parse through reports, using NLP, 
to add medical resource utilization to the known outcomes of TRR reports, either through parsing reports or inclusion of 
civil suits. This data, currently not included in attributes,  would provide strong additional evidence to explore individual
and societal impact.
 
 1)	What percentage of use of force incidents result in injury for citizens? Police officers? Broken down by race, age, neighborhood, 
 use of force (physical, taser, firearm, etc.), and other demographics? 
 2)	Are there differences in injury pattern in relation to different types of uses of force, i.e. taser vs. physical vs. firearms, 
 stratified as above?
 3)	Are neighborhoods with higher rates of officer injury reports more likely to be associated with complaints and use of force fillings? 
 4)	Are individual officers more likely to be involved in use of force incidents that lead to injury?
 5)	Are individual officers more likely to underreport injuries - ie are they less likely to report injury in TRR when injury is alleged 
 by a complainant?

Question 3:Are neighborhoods with higher rates of officer injury reports more likely to be associated with subject 
injuries or total number of events.  

-- This code will answer question 3 of checkpoint 1:
-- Please open question_3.sql and run the code: code as follows:
  -- to view the tables in different orders, just replace order by with the appropriate column header
	SELECT beat, count(*) total_events,
		count(case when officer_injured = 'True' then 1 end) as officer_injured,
		count(case when officer_injured = 'True' then 1 end)*100/count(*) as percent_officer_injured,
		count(case when subject_injured = 'True' then 1 end) as subject_injured,
		count(case when subject_injured = 'True' then 1 end)*100/count(*) as percent_subject_injured
	from trr_trr
	group by beat
	order by officer_injured desc;


Question 4:Are individual officers more likely to be involved with in use of force incidents that lead to injury?

-- This code will answer question 4 of checkpoint 1:
-- Please open question_4.sql : code as follows
  -- to view the tables in different orders, just replace order by with the appropriate column header
	
	SELECT officer_id, count(*) as total_use_of_force_events,
		count(case when subject_injured = 'True' then 1 end) as subject_injured,
		count(case when subject_injured = 'True' then 1 end)*100/count(*) as_percent_of_events
	from trr_trr
	group by officer_id
	order by subject_injured desc;
  
Question 5: Are individual officers more likely to underreport injuries - ie are they less likely to report injury in TRR when injury is alleged 
by a complainant?
 
For question 5 code is found in the question_5.sql file.
First generate temporary tables by running Code from question_5.sql lines 0-52: Code as follows

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
		count(CASE WHEN subject_injured = 'true' AND subject_alleged_injury = 'true' THEN 1 END) AS subject_injuries,
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
	ORDER BY total_use_of_force_events DESC)
	;

	DROP TABLE IF EXISTS complaint_percentages;
	CREATE TEMP TABLE  complaint_percentages AS
	(
		SELECT ot.officer_ID,
		total_use_of_force_events,
		fac.total_use_of_force_complaints,
		(100 * fac.total_use_of_force_complaints / ot.total_use_of_force_events) AS Percent_complaint
	FROM officer_trrs ot
		JOIN force_allegation_counts fac on ot.officer_id = fac.officer_id
	order by Percent_complaint DESC
	);

	DROP TABLE IF EXISTS alleged_injuries_not_counted;
	CREATE TEMP TABLE  alleged_injuries_not_counted AS
	(
	SELECT officer_ID, alleged_injuries,subject_injuries, percent_subject_alleged_injuries_not_counted
	FROM officer_trrs
	WHERE percent_subject_alleged_injuries_not_counted is NOT NULL and alleged_injuries >9
	order by percent_subject_alleged_injuries_not_counted DESC)
	;

Then to view complaint percentages table as above please run codes from line 55 to 57
	SELECT *
	from complaint_percentages
	Limit 20;

To view the average numberof complaints referenced above run the code from line 60 to 61
	SELECT AVG(percent_complaint)
	FROM complaint_percentages;

To view table 5.2 “Alleged Injuries not counted” run the code from line 64 to 66
	SELECT *
	from alleged_injuries_not_counted
	limit 20;

To view the average of all officers percentage of alleged_injureis not counted run the code from line 69 to 70
	SELECT AVG(percent_subject_alleged_injuries_not_counted)
	FROM officer_trrs;

To view the average of officers percentage of alleged_injureis not counted who have 10 or more injuries alleged, run the code from line 73 to 74

	SELECT AVG(percent_subject_alleged_injuries_not_counted)
	FROM alleged_injuries_not_counted;
