--------------------------------------------------------
-- Created using matview_sql_generator.py             --
--    The SQL definition is stored in a json file     --
--    Look in matview_generator for the code.         --
--                                                    --
--  DO NOT DIRECTLY EDIT THIS FILE!!!                 --
--------------------------------------------------------
ALTER MATERIALIZED VIEW IF EXISTS summary_transaction_month_view RENAME TO summary_transaction_month_view_old;
ALTER INDEX IF EXISTS idx_1e9d2816__date RENAME TO idx_1e9d2816__date_old;
ALTER INDEX IF EXISTS idx_1e9d2816__fy RENAME TO idx_1e9d2816__fy_old;
ALTER INDEX IF EXISTS idx_1e9d2816__fy_type RENAME TO idx_1e9d2816__fy_type_old;
ALTER INDEX IF EXISTS idx_1e9d2816__type RENAME TO idx_1e9d2816__type_old;
ALTER INDEX IF EXISTS idx_1e9d2816__pulled_from RENAME TO idx_1e9d2816__pulled_from_old;
ALTER INDEX IF EXISTS idx_1e9d2816__recipient_country_code RENAME TO idx_1e9d2816__recipient_country_code_old;
ALTER INDEX IF EXISTS idx_1e9d2816__recipient_state_code RENAME TO idx_1e9d2816__recipient_state_code_old;
ALTER INDEX IF EXISTS idx_1e9d2816__recipient_county_code RENAME TO idx_1e9d2816__recipient_county_code_old;
ALTER INDEX IF EXISTS idx_1e9d2816__recipient_zip RENAME TO idx_1e9d2816__recipient_zip_old;
ALTER INDEX IF EXISTS idx_1e9d2816__pop_country_code RENAME TO idx_1e9d2816__pop_country_code_old;
ALTER INDEX IF EXISTS idx_1e9d2816__pop_state_code RENAME TO idx_1e9d2816__pop_state_code_old;
ALTER INDEX IF EXISTS idx_1e9d2816__pop_county_code RENAME TO idx_1e9d2816__pop_county_code_old;
ALTER INDEX IF EXISTS idx_1e9d2816__pop_zip RENAME TO idx_1e9d2816__pop_zip_old;
ALTER INDEX IF EXISTS idx_1e9d2816__awarding_agency_id RENAME TO idx_1e9d2816__awarding_agency_id_old;
ALTER INDEX IF EXISTS idx_1e9d2816__funding_agency_id RENAME TO idx_1e9d2816__funding_agency_id_old;
ALTER INDEX IF EXISTS idx_1e9d2816__awarding_toptier_agency_name RENAME TO idx_1e9d2816__awarding_toptier_agency_name_old;
ALTER INDEX IF EXISTS idx_1e9d2816__awarding_subtier_agency_name RENAME TO idx_1e9d2816__awarding_subtier_agency_name_old;
ALTER INDEX IF EXISTS idx_1e9d2816__funding_toptier_agency_name RENAME TO idx_1e9d2816__funding_toptier_agency_name_old;
ALTER INDEX IF EXISTS idx_1e9d2816__funding_subtier_agency_name RENAME TO idx_1e9d2816__funding_subtier_agency_name_old;
ALTER INDEX IF EXISTS idx_1e9d2816__cfda_number RENAME TO idx_1e9d2816__cfda_number_old;
ALTER INDEX IF EXISTS idx_1e9d2816__cfda_title RENAME TO idx_1e9d2816__cfda_title_old;
ALTER INDEX IF EXISTS idx_1e9d2816__psc RENAME TO idx_1e9d2816__psc_old;
ALTER INDEX IF EXISTS idx_1e9d2816__naics RENAME TO idx_1e9d2816__naics_old;
ALTER INDEX IF EXISTS idx_1e9d2816__total_obl_bin RENAME TO idx_1e9d2816__total_obl_bin_old;
ALTER INDEX IF EXISTS idx_1e9d2816__type_of_contract RENAME TO idx_1e9d2816__type_of_contract_old;
ALTER INDEX IF EXISTS idx_1e9d2816__fy_set_aside RENAME TO idx_1e9d2816__fy_set_aside_old;
ALTER INDEX IF EXISTS idx_1e9d2816__extent_competed RENAME TO idx_1e9d2816__extent_competed_old;
ALTER INDEX IF EXISTS idx_1e9d2816__type_set_aside RENAME TO idx_1e9d2816__type_set_aside_old;
ALTER INDEX IF EXISTS idx_1e9d2816__business_categories RENAME TO idx_1e9d2816__business_categories_old;
ALTER INDEX IF EXISTS idx_1e9d2816__tuned_type_and_idv RENAME TO idx_1e9d2816__tuned_type_and_idv_old;

ALTER MATERIALIZED VIEW summary_transaction_month_view_temp RENAME TO summary_transaction_month_view;
ALTER INDEX idx_1e9d2816__date_temp RENAME TO idx_1e9d2816__date;
ALTER INDEX idx_1e9d2816__fy_temp RENAME TO idx_1e9d2816__fy;
ALTER INDEX idx_1e9d2816__fy_type_temp RENAME TO idx_1e9d2816__fy_type;
ALTER INDEX idx_1e9d2816__type_temp RENAME TO idx_1e9d2816__type;
ALTER INDEX idx_1e9d2816__pulled_from_temp RENAME TO idx_1e9d2816__pulled_from;
ALTER INDEX idx_1e9d2816__recipient_country_code_temp RENAME TO idx_1e9d2816__recipient_country_code;
ALTER INDEX idx_1e9d2816__recipient_state_code_temp RENAME TO idx_1e9d2816__recipient_state_code;
ALTER INDEX idx_1e9d2816__recipient_county_code_temp RENAME TO idx_1e9d2816__recipient_county_code;
ALTER INDEX idx_1e9d2816__recipient_zip_temp RENAME TO idx_1e9d2816__recipient_zip;
ALTER INDEX idx_1e9d2816__pop_country_code_temp RENAME TO idx_1e9d2816__pop_country_code;
ALTER INDEX idx_1e9d2816__pop_state_code_temp RENAME TO idx_1e9d2816__pop_state_code;
ALTER INDEX idx_1e9d2816__pop_county_code_temp RENAME TO idx_1e9d2816__pop_county_code;
ALTER INDEX idx_1e9d2816__pop_zip_temp RENAME TO idx_1e9d2816__pop_zip;
ALTER INDEX idx_1e9d2816__awarding_agency_id_temp RENAME TO idx_1e9d2816__awarding_agency_id;
ALTER INDEX idx_1e9d2816__funding_agency_id_temp RENAME TO idx_1e9d2816__funding_agency_id;
ALTER INDEX idx_1e9d2816__awarding_toptier_agency_name_temp RENAME TO idx_1e9d2816__awarding_toptier_agency_name;
ALTER INDEX idx_1e9d2816__awarding_subtier_agency_name_temp RENAME TO idx_1e9d2816__awarding_subtier_agency_name;
ALTER INDEX idx_1e9d2816__funding_toptier_agency_name_temp RENAME TO idx_1e9d2816__funding_toptier_agency_name;
ALTER INDEX idx_1e9d2816__funding_subtier_agency_name_temp RENAME TO idx_1e9d2816__funding_subtier_agency_name;
ALTER INDEX idx_1e9d2816__cfda_number_temp RENAME TO idx_1e9d2816__cfda_number;
ALTER INDEX idx_1e9d2816__cfda_title_temp RENAME TO idx_1e9d2816__cfda_title;
ALTER INDEX idx_1e9d2816__psc_temp RENAME TO idx_1e9d2816__psc;
ALTER INDEX idx_1e9d2816__naics_temp RENAME TO idx_1e9d2816__naics;
ALTER INDEX idx_1e9d2816__total_obl_bin_temp RENAME TO idx_1e9d2816__total_obl_bin;
ALTER INDEX idx_1e9d2816__type_of_contract_temp RENAME TO idx_1e9d2816__type_of_contract;
ALTER INDEX idx_1e9d2816__fy_set_aside_temp RENAME TO idx_1e9d2816__fy_set_aside;
ALTER INDEX idx_1e9d2816__extent_competed_temp RENAME TO idx_1e9d2816__extent_competed;
ALTER INDEX idx_1e9d2816__type_set_aside_temp RENAME TO idx_1e9d2816__type_set_aside;
ALTER INDEX idx_1e9d2816__business_categories_temp RENAME TO idx_1e9d2816__business_categories;
ALTER INDEX idx_1e9d2816__tuned_type_and_idv_temp RENAME TO idx_1e9d2816__tuned_type_and_idv;
