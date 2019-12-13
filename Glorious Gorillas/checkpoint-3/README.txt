Hello and thanks for reading :)\
We have included an sql file \'93cp3\'94 with all the code and their respective questions that they address. Simply highlight each segment and run. Each segment ends it a semicolon.\
\
1.How does years worked as a police officer correlate to the amount of arrests they have over their career?\
First, create a table with each officer and how many years that they have worked in the force. Them take the count of arrests for that officer.\
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f1\b\fs24 \cf4 \cb1 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 CREATE TABLE 
\f2\b0 \cf0 officer_years_worked 
\f1\b \cf4 AS\
    SELECT \cf5 id
\f2\b0 \cf0 , 
\f3\i \cf4 EXTRACT
\f2\i0 \cf0 (
\f1\b \cf4 year from \cf5 appointed_date
\f2\b0 \cf0 ) 
\f1\b \cf4 AS 
\f2\b0 \cf0 appointed_year,\
       
\f3\i \cf4 EXTRACT
\f2\i0 \cf0 (
\f1\b \cf4 year from 
\f3\i\b0 COALESCE
\f2\i0 \cf0 (
\f1\b \cf5 resignation_date
\f2\b0 \cf0 , 
\f1\b \cf6 '2019-11-18'
\f2\b0 \cf0 )) 
\f1\b \cf4 AS 
\f2\b0 \cf0 final_date 
\f1\b \cf4 FROM 
\f2\b0 \cf0 data_officer;\
\

\f1\b \cf4 SELECT 
\f2\b0 \cf0 oyw.
\f1\b \cf5 id \cf4 as 
\f2\b0 \cf0 officer_id, oyw.
\f1\b \cf5 final_date 
\f2\b0 \cf0 - oyw.
\f1\b \cf5 appointed_year \cf4 AS 
\f2\b0 \cf0 years_worked, 
\f3\i count
\f2\i0 (
\f1\b \cf4 d
\f2\b0 \cf0 .
\f1\b \cf5 id
\f2\b0 \cf0 ) 
\f1\b \cf4 as 
\f2\b0 \cf0 count_arrests\

\f1\b \cf4 from 
\f2\b0 \cf0 officer_years_worked oyw 
\f1\b \cf4 LEFT JOIN 
\f2\b0 \cf0 data_officerarrest doa\

\f1\b \cf4 ON 
\f2\b0 \cf0 doa.
\f1\b \cf5 officer_id 
\f2\b0 \cf0 = oyw.
\f1\b \cf5 id\
\cf4 LEFT JOIN 
\f2\b0 \cf0 data_arrest 
\f1\b \cf4 d\
ON d
\f2\b0 \cf0 .
\f1\b \cf5 id 
\f2\b0 \cf0 = doa.
\f1\b \cf5 arrest_id\
\cf4 Group by 
\f2\b0 \cf0 oyw.
\f1\b \cf5 id
\f2\b0 \cf0 , years_worked;\
\pard\pardeftab720\sl340\partightenfactor0

\f0\fs30 \cf2 \cb3 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 \
\
2. Is there any significance between how many complaints an officer has with the amount of arrests they have?\
This gets the amount of complaints versus arrests made per officer. Note that some of these numbers go really high, likely due to badges being passed down.\
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f1\b\fs24 \cf4 \cb1 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 select d
\f2\b0 \cf0 .
\f1\b \cf5 officer_id
\f2\b0 \cf0 , 
\f3\i count
\f2\i0 (da.
\f1\b \cf5 id
\f2\b0 \cf0 ) 
\f1\b \cf4 as 
\f2\b0 \cf0 count_arrests, 
\f3\i count
\f2\i0 (
\f1\b \cf4 d
\f2\b0 \cf0 .
\f1\b \cf5 allegation_id
\f2\b0 \cf0 ) 
\f1\b \cf4 as 
\f2\b0 \cf0 count_compaints\

\f1\b \cf4 from 
\f2\b0 \cf0 data_officerarrest doa 
\f1\b \cf4 LEFT JOIN 
\f2\b0 \cf0 data_arrest da\

\f1\b \cf4 ON 
\f2\b0 \cf0 doa.
\f1\b \cf5 arrest_id 
\f2\b0 \cf0 = da.
\f1\b \cf5 id\
\cf4 LEFT JOIN 
\f2\b0 \cf0 data_officerallegation 
\f1\b \cf4 d\
ON d
\f2\b0 \cf0 .
\f1\b \cf5 officer_id 
\f2\b0 \cf0 = doa.
\f1\b \cf5 officer_id\
\cf4 group by d
\f2\b0 \cf0 .
\f1\b \cf5 officer_id
\f2\b0 \cf0 ;\
\pard\pardeftab720\sl340\partightenfactor0

\f0\fs30 \cf2 \cb3 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 \
\
3. Can the data tell us if there are any biases in officer judgments for arrest by understanding arrests as a proportion for each ethnic/racial demographic?\
This is a big one - essentially lists the complaints and arrests by race.\
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f1\b\fs24 \cf4 \cb1 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 SELECT 
\f2\b0 \cf0 dc.
\f1\b \cf5 race
\f2\b0 \cf0 ,
\f3\i count
\f2\i0 (doa.
\f1\b \cf5 allegation_id
\f2\b0 \cf0 ) 
\f1\b \cf4 as 
\f2\b0 \cf0 count_complaints, 
\f3\i count
\f2\i0 (dar.
\f1\b \cf5 id
\f2\b0 \cf0 ) 
\f1\b \cf4 as 
\f2\b0 \cf0 count_arrests\

\f1\b \cf4 FROM 
\f2\b0 \cf0 data_complainant dc 
\f1\b \cf4 INNER JOIN 
\f2\b0 \cf0 data_officerallegation doa\

\f1\b \cf4 ON 
\f2\b0 \cf0 dc.
\f1\b \cf5 id 
\f2\b0 \cf0 = doa.
\f1\b \cf5 id\
\cf4 INNER JOIN 
\f2\b0 \cf0 data_allegation da\

\f1\b \cf4 ON 
\f2\b0 \cf0 doa.
\f1\b \cf5 allegation_id 
\f2\b0 \cf0 = da.
\f1\b \cf5 id\
\cf4 LEFT JOIN 
\f2\b0 \cf0 data_officerarrest doa2\

\f1\b \cf4 ON 
\f2\b0 \cf0 doa2.
\f1\b \cf5 officer_id 
\f2\b0 \cf0 = doa.
\f1\b \cf5 officer_id\
\cf4 LEFT JOIN 
\f2\b0 \cf0 data_arrest dar\

\f1\b \cf4 ON 
\f2\b0 \cf0 doa2.
\f1\b \cf5 arrest_id 
\f2\b0 \cf0 = dar.
\f1\b \cf5 id\
\cf4 GROUP BY 
\f2\b0 \cf0 dc.
\f1\b \cf5 race
\f2\b0 \cf0 ;\
\pard\pardeftab720\sl340\partightenfactor0

\f0\fs30 \cf2 \cb3 \expnd0\expndtw0\kerning0
\outl0\strokewidth0 \strokec2 \
4. Understand how arrests relate to misconduct categories for officers and how many arrests were made for each type of misconduct.\
\
We couldn\'92t get a join key working between the Copa set and the data arrests, but we are consulting with prof Rogers to figure this one out. Currently, this just gives the count of complaints per category, we\'92d like to tie in arrests to it too.\
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardirnatural\partightenfactor0

\f1\b\fs24 \cf4 \cb1 \kerning1\expnd0\expndtw0 \outl0\strokewidth0 SELECT \cf5 current_category
\f2\b0 \cf0 , 
\f3\i count
\f2\i0 (
\f1\b \cf5 current_category
\f2\b0 \cf0 ) 
\f1\b \cf4 AS 
\f2\b0 \cf0 category_count 
\f1\b \cf4 FROM 
\f2\b0 \cf0 copa_officer\

\f1\b \cf4 GROUP BY \cf5 current_category
\f2\b0 \cf0 ;\
}