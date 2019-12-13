-- Query to get data for Checkpoint 5, Questions 1 and 2
-- This query was exported as a CSV as found in the src folder
CREATE TABLE checkpoint5_final AS
    SELECT
        oyw.id AS officer_id,
        oyw.final_date - oyw.appointed_year AS years_worked,
        ob.race AS victim_race,
        count(dam.id) AS count_arrests,
        do2.race AS officer_race,
        do2.rank AS officer_rank,
        count(doa.id) AS count_allegations
    FROM data_officerallegation doa
    LEFT JOIN officer_years_worked oyw
        ON doa.officer_id = oyw.id
    LEFT JOIN officer_bias ob
        ON doa.id = ob.officer_id
    LEFT JOIN data_officerarrest_mine doam
        ON doa.id = doam.arrest_id
    LEFT JOIN data_arrest_mine dam
        ON dam.id = doam.arrest_id
    LEFT JOIN data_officer do2
        ON doa.officer_id = do2.id
    GROUP BY oyw.id, years_worked, ob.race, officer_race, officer_rank
    ORDER BY years_worked DESC;

-- Query to get labels for Checkpoint 5, Questions 1 and 2 for officer ranks
-- This query was exported as a CSV as found in the src folder
CREATE TABLE officer_rank_list AS
    SELECT officer_rank FROM checkpoint5_final
    GROUP BY officer_rank;