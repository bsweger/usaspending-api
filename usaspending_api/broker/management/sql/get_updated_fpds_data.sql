--Create table in website database to select rows in transaction_fpds need to be updated
--Alter table to include which rows have a change in location for place of performance or recipient
CREATE TEMPORARY TABLE fpds_transactions_to_update AS
SELECT * from dblink('broker_server','
    SELECT
        detached_award_procurement_id,
		detached_award_proc_unique,
		legal_entity_address_line1,
		legal_entity_address_line2,
		legal_entity_address_line3,
		legal_entity_city_name,
		legal_entity_congressional,
		legal_entity_country_code,
		legal_entity_country_name,
--		legal_entity_county_code, TODO: Uncomment when fields added to broker
--		legal_entity_county_name, TODO: Uncomment when fields added to broker
		legal_entity_state_code ,
		legal_entity_state_descrip,
--		legal_entity_zip5, TODO: Uncomment when fields added to broker
		legal_entity_zip4,
		place_of_perform_city_name,
		place_of_performance_congr,
		place_of_perform_country_c,
		place_of_perf_country_desc,
--		place_of_perform_county_co, TODO: Uncomment when fields added to broker
		place_of_perform_county_na,
		place_of_performance_state,
		place_of_perfor_state_desc,
--		place_of_performance_zip5, TODO: Uncomment when fields added to broker
		place_of_performance_zip4a
        from detached_award_procurement
        where action_date::date >= '%(fy_start)s'::date and
        action_date::date <= '%(fy_end)s'::date;
')
AS (
		detached_award_procurement_id  text,
        detached_award_proc_unique  text,
        legal_entity_address_line1  text,
        legal_entity_address_line2  text,
        legal_entity_address_line3  text,
        legal_entity_city_name  text,
        legal_entity_congressional  text,
        legal_entity_country_code  text,
        legal_entity_country_name  text,
--      legal_entity_county_code  text, TODO: Uncomment when fields added to broker
--      legal_entity_county_name  text, TODO: Uncomment when fields added to broker
        legal_entity_state_code  text,
        legal_entity_state_descrip  text,
--		legal_entity_zip5 text, TODO: Uncomment when fields added to broker
        legal_entity_zip4  text,
        place_of_perform_city_name  text,
        place_of_performance_congr  text,
        place_of_perform_country_c  text,
        place_of_perf_country_desc  text,
--      place_of_perform_county_co  text, TODO: Uncomment when fields added to broker
        place_of_perform_county_na  text,
        place_of_performance_state  text,
        place_of_perfor_state_desc  text,
--		place_of_performance_zip5 text, TODO: Uncomment when fields added to broker
        place_of_performance_zip4a  text
      )
       EXCEPT
      	SELECT
      	detached_award_procurement_id,
		detached_award_proc_unique,
		legal_entity_address_line1,
		legal_entity_address_line2,
		legal_entity_address_line3,
		legal_entity_city_name,
		legal_entity_congressional,
		legal_entity_country_code,
		legal_entity_country_name,
--		legal_entity_county_code, TODO: Uncomment when fields added to broker
--		legal_entity_county_name, TODO: Uncomment when fields added to broker
		legal_entity_state_code,
		legal_entity_state_descrip,
--		legal_entity_zip5, TODO: Uncomment when fields added to broker
		legal_entity_zip4,
		place_of_perform_city_name,
		place_of_performance_congr,
		place_of_perform_country_c,
		place_of_perf_country_desc,
--		place_of_perform_county_co, TODO: Uncomment when fields added to broker
		place_of_perform_county_na,
		place_of_performance_state,
		place_of_perfor_state_desc,
--		place_of_performance_zip5 text, TODO: Uncomment when fields added to broker
		place_of_performance_zip4a
        from transaction_fpds
        where action_date::date >= %(fy_start)s::date and
        action_date::date <= %(fy_end)s::date;



-- Adding index to table to improve speed
CREATE INDEX fpds_unique_idx  ON fpds_transactions_to_update(detached_award_proc_unique);



-- Include columns to determine whether we need a place of performance change or recipient location
ALTER TABLE fpds_transactions_to_update
add COLUMN pop_change boolean, add COLUMN le_loc_change boolean;

UPDATE fpds_transactions_to_update broker
SET
    le_loc_change = (
	CASE  WHEN
		transaction_fpds.legal_entity_address_line1 IS DISTINCT FROM broker.legal_entity_address_line1 or
		transaction_fpds.legal_entity_address_line2 IS DISTINCT FROM broker.legal_entity_address_line2 or
		transaction_fpds.legal_entity_address_line3 IS DISTINCT FROM broker.legal_entity_address_line3 or
		transaction_fpds.legal_entity_city_name IS DISTINCT FROM broker.legal_entity_city_name or
		transaction_fpds.legal_entity_congressional IS DISTINCT FROM broker.legal_entity_congressional or
		transaction_fpds.legal_entity_country_code IS DISTINCT FROM broker.legal_entity_country_code or
		transaction_fpds.legal_entity_country_name IS DISTINCT FROM broker.legal_entity_country_name or
--		transaction_fpds.legal_entity_county_code IS DISTINCT FROM broker.legal_entity_county_code or TODO: Uncomment when fields added to broker
--		transaction_fpds.legal_entity_county_name IS DISTINCT FROM broker.legal_entity_county_name or TODO: Uncomment when fields added to broker
		transaction_fpds.legal_entity_state_code IS DISTINCT FROM broker.legal_entity_state_code or
		transaction_fpds.legal_entity_state_descrip IS DISTINCT FROM broker.legal_entity_state_descrip or
--		transaction_fpds.legal_entity_zip5 IS DISTINCT FROM broker.legal_entity_zip5 or TODO: Uncomment when fields added to broker
		transaction_fpds.legal_entity_zip4 IS DISTINCT FROM broker.legal_entity_zip4
		THEN TRUE ELSE FALSE END
	),
	pop_change = (
	CASE  WHEN
        transaction_fpds.place_of_perform_city_name IS DISTINCT FROM broker.place_of_perform_city_name or
        transaction_fpds.place_of_performance_congr IS DISTINCT FROM broker.place_of_performance_congr or
        transaction_fpds.place_of_perform_country_c IS DISTINCT FROM broker.place_of_perform_country_c or
        transaction_fpds.place_of_perf_country_desc IS DISTINCT FROM broker.place_of_perf_country_desc or
--		transaction_fpds.place_of_perform_county_co IS DISTINCT FROM broker.place_of_perform_county_co or TODO: Uncomment when fields added to broker
        transaction_fpds.place_of_perform_county_na IS DISTINCT FROM broker.place_of_perform_county_na or
        transaction_fpds.place_of_performance_state IS DISTINCT FROM broker.place_of_performance_state or
        transaction_fpds.place_of_perfor_state_desc IS DISTINCT FROM broker.place_of_perfor_state_desc or
--		transaction_fpds.place_of_performance_zip5 IS DISTINCT FROM broker.place_of_performance_zip5 or   TODO: Uncomment when fields added to broker
        transaction_fpds.place_of_performance_zip4a IS DISTINCT FROM broker.place_of_performance_zip4a
		THEN TRUE ELSE FALSE END
	)
	FROM transaction_fpds
	WHERE broker.detached_award_proc_unique = transaction_fpds.detached_award_proc_unique;



-- Delete rows where there is no transaction in the table
DELETE FROM fpds_transactions_to_update where pop_change is null and le_loc_change is null;


-- Adding index to table to improve speed
CREATE INDEX fpds_le_loc_idx ON fpds_transactions_to_update(le_loc_change);
CREATE INDEX fpds_pop_idx ON fpds_transactions_to_update(pop_change);
ANALYZE fpds_transactions_to_update;
