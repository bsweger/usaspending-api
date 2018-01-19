--------------------------------------------------------
-- Created using matview_sql_generator.py             --
--    The SQL definition is stored in a json file     --
--    Look in matview_generator for the code.         --
--                                                    --
--  DO NOT DIRECTLY EDIT THIS FILE!!!                 --
--------------------------------------------------------
DROP MATERIALIZED VIEW IF EXISTS api_transaction_view_temp;
DROP MATERIALIZED VIEW IF EXISTS api_transaction_view_old;

CREATE MATERIALIZED VIEW api_transaction_view_temp AS
SELECT
  UPPER(CONCAT(
    recipient_name,
    ' ', naics,
    ' ', naics_description,
    ' ', psc_description,
    ' ', award_description)) AS keyword_string,
  UPPER(CONCAT(piid, ' ', fain, ' ', uri)) AS award_id_string,
  transaction_uid,
  action_date::date,
  fiscal_year,
  type,
  action_type,
  award_id,
  category AS award_category,
  total_obligation,
  obligation_to_enum(total_obligation) AS total_obl_bin,
  fain,
  uri,
  piid,
  federal_action_obligation,
  description AS transaction_description,
  modification_number,

  pop_country_code,
  pop_country_name,
  pop_state_code,
  pop_county_code,
  pop_county_name,
  pop_zip5,
  pop_congressional_code,

  recipient_location_country_code,
  recipient_location_country_name,
  recipient_location_state_code,
  recipient_location_county_code,
  recipient_location_county_name,
  recipient_location_zip5,
  recipient_location_congressional_code,

  naics AS naics_code,
  naics_description,
  product_or_service_code,
  product_or_service_co_desc AS product_or_service_description,
  pulled_from,
  type_of_contract_pricing,
  type_set_aside,
  extent_competed,
  cfda_number,
  program_title AS cfda_title,
  popular_name AS cfda_popular_name,
  recipient_id,
  UPPER(recipient_name) AS recipient_name,
  recipient_unique_id,
  parent_recipient_unique_id,
  business_categories,

  AS awarding_agency_id,
  AS funding_agency_id,
  AA.toptier_name AS awarding_toptier_agency_name,
  FA.toptier_name AS funding_toptier_agency_name,
  AA.subtier_name AS awarding_subtier_agency_name,
  FA.subtier_name AS funding_subtier_agency_name,
  AA.toptier_abbr AS awarding_toptier_agency_abbreviation,
  FA.toptier_abbr AS funding_toptier_agency_abbreviation,
  AA.subtier_abbr AS awarding_subtier_agency_abbreviation,
  FA.subtier_abbr AS funding_subtier_agency_abbreviation
FROM
  transaction_matview
LEFT OUTER JOIN
  agency_lookup AS FA ON (agency_id = AL.agency_id)
LEFT OUTER JOIN
  agency_lookup AS AA ON (agency_id = AL.agency_id)

WHERE
  action_date >= '2007-10-01' AND
  federal_action_obligation IS NOT NULL
ORDER BY
  action_date DESC;

CREATE UNIQUE INDEX idx_fca27c70__transaction_uid_temp ON api_transaction_view_temp USING BTREE(transaction_uid ASC NULLS LAST) WITH (fillfactor = 100);
CREATE INDEX idx_fca27c70__action_date_temp ON api_transaction_view_temp USING BTREE(action_date DESC NULLS LAST) WITH (fillfactor = 100);
CREATE INDEX idx_fca27c70__fiscal_year_temp ON api_transaction_view_temp USING BTREE(fiscal_year DESC NULLS LAST) WITH (fillfactor = 100);
CREATE INDEX idx_fca27c70__type_temp ON api_transaction_view_temp USING BTREE(type) WITH (fillfactor = 100) WHERE type IS NOT NULL;
CREATE INDEX idx_fca27c70__ordered_type_temp ON api_transaction_view_temp USING BTREE(type DESC NULLS LAST) WITH (fillfactor = 100);
CREATE INDEX idx_fca27c70__action_type_temp ON api_transaction_view_temp USING BTREE(action_type) WITH (fillfactor = 100);
CREATE INDEX idx_fca27c70__award_id_temp ON api_transaction_view_temp USING BTREE(award_id) WITH (fillfactor = 100);
CREATE INDEX idx_fca27c70__award_category_temp ON api_transaction_view_temp USING BTREE(award_category) WITH (fillfactor = 100) WHERE award_category IS NOT NULL;
CREATE INDEX idx_fca27c70__total_obligation_temp ON api_transaction_view_temp USING BTREE(total_obligation) WITH (fillfactor = 100) WHERE total_obligation IS NOT NULL;
CREATE INDEX idx_fca27c70__ordered_total_obligation_temp ON api_transaction_view_temp USING BTREE(total_obligation DESC NULLS LAST) WITH (fillfactor = 100);
CREATE INDEX idx_fca27c70__total_obl_bin_temp ON api_transaction_view_temp USING BTREE(total_obl_bin) WITH (fillfactor = 100);
CREATE INDEX idx_fca27c70__pop_country_code_temp ON api_transaction_view_temp USING BTREE(pop_country_code) WITH (fillfactor = 100) WHERE pop_country_code IS NOT NULL;
CREATE INDEX idx_fca27c70__pop_state_code_temp ON api_transaction_view_temp USING BTREE(pop_state_code) WITH (fillfactor = 100) WHERE pop_state_code IS NOT NULL;
CREATE INDEX idx_fca27c70__pop_county_code_temp ON api_transaction_view_temp USING BTREE(pop_county_code) WITH (fillfactor = 100) WHERE pop_county_code IS NOT NULL;
CREATE INDEX idx_fca27c70__pop_zip5_temp ON api_transaction_view_temp USING BTREE(pop_zip5) WITH (fillfactor = 100) WHERE pop_zip5 IS NOT NULL;
CREATE INDEX idx_fca27c70__pop_congressional_code_temp ON api_transaction_view_temp USING BTREE(pop_congressional_code) WITH (fillfactor = 100) WHERE pop_congressional_code IS NOT NULL;
CREATE INDEX idx_fca27c70__gin_recipient_name_temp ON api_transaction_view_temp USING GIN(recipient_name gin_trgm_ops);
CREATE INDEX idx_fca27c70__gin_recipient_unique_id_temp ON api_transaction_view_temp USING GIN(recipient_unique_id gin_trgm_ops);
CREATE INDEX idx_fca27c70__gin_parent_recipient_unique_id_temp ON api_transaction_view_temp USING GIN(parent_recipient_unique_id gin_trgm_ops);
CREATE INDEX idx_fca27c70__recipient_id_temp ON api_transaction_view_temp USING BTREE(recipient_id) WITH (fillfactor = 100) WHERE recipient_id IS NOT NULL;
CREATE INDEX idx_fca27c70__recipient_name_temp ON api_transaction_view_temp USING BTREE(recipient_name) WITH (fillfactor = 100) WHERE recipient_name IS NOT NULL;
CREATE INDEX idx_fca27c70__recipient_unique_id_temp ON api_transaction_view_temp USING BTREE(recipient_unique_id) WITH (fillfactor = 100) WHERE recipient_unique_id IS NOT NULL;
CREATE INDEX idx_fca27c70__parent_recipient_unique_id_temp ON api_transaction_view_temp USING BTREE(parent_recipient_unique_id) WITH (fillfactor = 100) WHERE parent_recipient_unique_id IS NOT NULL;
CREATE INDEX idx_fca27c70__awarding_agency_id_temp ON api_transaction_view_temp USING BTREE(awarding_agency_id ASC NULLS LAST) WITH (fillfactor = 100) WHERE awarding_agency_id IS NOT NULL;
CREATE INDEX idx_fca27c70__funding_agency_id_temp ON api_transaction_view_temp USING BTREE(funding_agency_id ASC NULLS LAST) WITH (fillfactor = 100) WHERE funding_agency_id IS NOT NULL;
CREATE INDEX idx_fca27c70__awarding_toptier_agency_name_temp ON api_transaction_view_temp USING BTREE(awarding_toptier_agency_name) WITH (fillfactor = 100) WHERE awarding_toptier_agency_name IS NOT NULL;
CREATE INDEX idx_fca27c70__awarding_subtier_agency_name_temp ON api_transaction_view_temp USING BTREE(awarding_subtier_agency_name) WITH (fillfactor = 100) WHERE awarding_subtier_agency_name IS NOT NULL;
CREATE INDEX idx_fca27c70__funding_toptier_agency_name_temp ON api_transaction_view_temp USING BTREE(funding_toptier_agency_name) WITH (fillfactor = 100) WHERE funding_toptier_agency_name IS NOT NULL;
CREATE INDEX idx_fca27c70__funding_subtier_agency_name_temp ON api_transaction_view_temp USING BTREE(funding_subtier_agency_name) WITH (fillfactor = 100) WHERE funding_subtier_agency_name IS NOT NULL;
CREATE INDEX idx_fca27c70__recipient_location_country_code_temp ON api_transaction_view_temp USING BTREE(recipient_location_country_code) WITH (fillfactor = 100) WHERE recipient_location_country_code IS NOT NULL;
CREATE INDEX idx_fca27c70__recipient_location_state_code_temp ON api_transaction_view_temp USING BTREE(recipient_location_state_code) WITH (fillfactor = 100) WHERE recipient_location_state_code IS NOT NULL;
CREATE INDEX idx_fca27c70__recipient_location_county_code_temp ON api_transaction_view_temp USING BTREE(recipient_location_county_code) WITH (fillfactor = 100) WHERE recipient_location_county_code IS NOT NULL;
CREATE INDEX idx_fca27c70__recipient_location_zip5_temp ON api_transaction_view_temp USING BTREE(recipient_location_zip5) WITH (fillfactor = 100) WHERE recipient_location_zip5 IS NOT NULL;
CREATE INDEX idx_fca27c70__recipient_location_congressional_code_temp ON api_transaction_view_temp USING BTREE(recipient_location_congressional_code) WITH (fillfactor = 100) WHERE recipient_location_congressional_code IS NOT NULL;
CREATE INDEX idx_fca27c70__cfda_multi_temp ON api_transaction_view_temp USING BTREE(cfda_number, cfda_title) WITH (fillfactor = 100) WHERE cfda_number IS NOT NULL;
CREATE INDEX idx_fca27c70__pulled_from_temp ON api_transaction_view_temp USING BTREE(pulled_from) WITH (fillfactor = 100) WHERE pulled_from IS NOT NULL;
CREATE INDEX idx_fca27c70__type_of_contract_pricing_temp ON api_transaction_view_temp USING BTREE(type_of_contract_pricing) WITH (fillfactor = 100) WHERE type_of_contract_pricing IS NOT NULL;
CREATE INDEX idx_fca27c70__extent_competed_temp ON api_transaction_view_temp USING BTREE(extent_competed) WITH (fillfactor = 100) WHERE extent_competed IS NOT NULL;
CREATE INDEX idx_fca27c70__type_set_aside_temp ON api_transaction_view_temp USING BTREE(type_set_aside) WITH (fillfactor = 100) WHERE type_set_aside IS NOT NULL;
CREATE INDEX idx_fca27c70__product_or_service_code_temp ON api_transaction_view_temp USING BTREE(product_or_service_code) WITH (fillfactor = 100) WHERE product_or_service_code IS NOT NULL;
CREATE INDEX idx_fca27c70__gin_naics_code_temp ON api_transaction_view_temp USING GIN(naics_code gin_trgm_ops);
CREATE INDEX idx_fca27c70__naics_code_temp ON api_transaction_view_temp USING BTREE(naics_code) WITH (fillfactor = 100) WHERE naics_code IS NOT NULL;
CREATE INDEX idx_fca27c70__business_categories_temp ON api_transaction_view_temp USING GIN(business_categories);
CREATE INDEX idx_fca27c70__keyword_string_temp ON api_transaction_view_temp USING GIN(keyword_string gin_trgm_ops);
CREATE INDEX idx_fca27c70__award_id_string_temp ON api_transaction_view_temp USING GIN(award_id_string gin_trgm_ops);
CREATE INDEX idx_fca27c70__tuned_type_and_idv_temp ON api_transaction_view_temp USING BTREE(type, pulled_from) WITH (fillfactor = 100) WHERE type IS NULL AND pulled_from IS NOT NULL;

ANALYZE VERBOSE api_transaction_view_temp;

ALTER MATERIALIZED VIEW IF EXISTS api_transaction_view RENAME TO api_transaction_view_old;
ALTER INDEX IF EXISTS idx_fca27c70__transaction_uid RENAME TO idx_fca27c70__transaction_uid_old;
ALTER INDEX IF EXISTS idx_fca27c70__action_date RENAME TO idx_fca27c70__action_date_old;
ALTER INDEX IF EXISTS idx_fca27c70__fiscal_year RENAME TO idx_fca27c70__fiscal_year_old;
ALTER INDEX IF EXISTS idx_fca27c70__type RENAME TO idx_fca27c70__type_old;
ALTER INDEX IF EXISTS idx_fca27c70__ordered_type RENAME TO idx_fca27c70__ordered_type_old;
ALTER INDEX IF EXISTS idx_fca27c70__action_type RENAME TO idx_fca27c70__action_type_old;
ALTER INDEX IF EXISTS idx_fca27c70__award_id RENAME TO idx_fca27c70__award_id_old;
ALTER INDEX IF EXISTS idx_fca27c70__award_category RENAME TO idx_fca27c70__award_category_old;
ALTER INDEX IF EXISTS idx_fca27c70__total_obligation RENAME TO idx_fca27c70__total_obligation_old;
ALTER INDEX IF EXISTS idx_fca27c70__ordered_total_obligation RENAME TO idx_fca27c70__ordered_total_obligation_old;
ALTER INDEX IF EXISTS idx_fca27c70__total_obl_bin RENAME TO idx_fca27c70__total_obl_bin_old;
ALTER INDEX IF EXISTS idx_fca27c70__pop_country_code RENAME TO idx_fca27c70__pop_country_code_old;
ALTER INDEX IF EXISTS idx_fca27c70__pop_state_code RENAME TO idx_fca27c70__pop_state_code_old;
ALTER INDEX IF EXISTS idx_fca27c70__pop_county_code RENAME TO idx_fca27c70__pop_county_code_old;
ALTER INDEX IF EXISTS idx_fca27c70__pop_zip5 RENAME TO idx_fca27c70__pop_zip5_old;
ALTER INDEX IF EXISTS idx_fca27c70__pop_congressional_code RENAME TO idx_fca27c70__pop_congressional_code_old;
ALTER INDEX IF EXISTS idx_fca27c70__gin_recipient_name RENAME TO idx_fca27c70__gin_recipient_name_old;
ALTER INDEX IF EXISTS idx_fca27c70__gin_recipient_unique_id RENAME TO idx_fca27c70__gin_recipient_unique_id_old;
ALTER INDEX IF EXISTS idx_fca27c70__gin_parent_recipient_unique_id RENAME TO idx_fca27c70__gin_parent_recipient_unique_id_old;
ALTER INDEX IF EXISTS idx_fca27c70__recipient_id RENAME TO idx_fca27c70__recipient_id_old;
ALTER INDEX IF EXISTS idx_fca27c70__recipient_name RENAME TO idx_fca27c70__recipient_name_old;
ALTER INDEX IF EXISTS idx_fca27c70__recipient_unique_id RENAME TO idx_fca27c70__recipient_unique_id_old;
ALTER INDEX IF EXISTS idx_fca27c70__parent_recipient_unique_id RENAME TO idx_fca27c70__parent_recipient_unique_id_old;
ALTER INDEX IF EXISTS idx_fca27c70__awarding_agency_id RENAME TO idx_fca27c70__awarding_agency_id_old;
ALTER INDEX IF EXISTS idx_fca27c70__funding_agency_id RENAME TO idx_fca27c70__funding_agency_id_old;
ALTER INDEX IF EXISTS idx_fca27c70__awarding_toptier_agency_name RENAME TO idx_fca27c70__awarding_toptier_agency_name_old;
ALTER INDEX IF EXISTS idx_fca27c70__awarding_subtier_agency_name RENAME TO idx_fca27c70__awarding_subtier_agency_name_old;
ALTER INDEX IF EXISTS idx_fca27c70__funding_toptier_agency_name RENAME TO idx_fca27c70__funding_toptier_agency_name_old;
ALTER INDEX IF EXISTS idx_fca27c70__funding_subtier_agency_name RENAME TO idx_fca27c70__funding_subtier_agency_name_old;
ALTER INDEX IF EXISTS idx_fca27c70__recipient_location_country_code RENAME TO idx_fca27c70__recipient_location_country_code_old;
ALTER INDEX IF EXISTS idx_fca27c70__recipient_location_state_code RENAME TO idx_fca27c70__recipient_location_state_code_old;
ALTER INDEX IF EXISTS idx_fca27c70__recipient_location_county_code RENAME TO idx_fca27c70__recipient_location_county_code_old;
ALTER INDEX IF EXISTS idx_fca27c70__recipient_location_zip5 RENAME TO idx_fca27c70__recipient_location_zip5_old;
ALTER INDEX IF EXISTS idx_fca27c70__recipient_location_congressional_code RENAME TO idx_fca27c70__recipient_location_congressional_code_old;
ALTER INDEX IF EXISTS idx_fca27c70__cfda_multi RENAME TO idx_fca27c70__cfda_multi_old;
ALTER INDEX IF EXISTS idx_fca27c70__pulled_from RENAME TO idx_fca27c70__pulled_from_old;
ALTER INDEX IF EXISTS idx_fca27c70__type_of_contract_pricing RENAME TO idx_fca27c70__type_of_contract_pricing_old;
ALTER INDEX IF EXISTS idx_fca27c70__extent_competed RENAME TO idx_fca27c70__extent_competed_old;
ALTER INDEX IF EXISTS idx_fca27c70__type_set_aside RENAME TO idx_fca27c70__type_set_aside_old;
ALTER INDEX IF EXISTS idx_fca27c70__product_or_service_code RENAME TO idx_fca27c70__product_or_service_code_old;
ALTER INDEX IF EXISTS idx_fca27c70__gin_naics_code RENAME TO idx_fca27c70__gin_naics_code_old;
ALTER INDEX IF EXISTS idx_fca27c70__naics_code RENAME TO idx_fca27c70__naics_code_old;
ALTER INDEX IF EXISTS idx_fca27c70__business_categories RENAME TO idx_fca27c70__business_categories_old;
ALTER INDEX IF EXISTS idx_fca27c70__keyword_string RENAME TO idx_fca27c70__keyword_string_old;
ALTER INDEX IF EXISTS idx_fca27c70__award_id_string RENAME TO idx_fca27c70__award_id_string_old;
ALTER INDEX IF EXISTS idx_fca27c70__tuned_type_and_idv RENAME TO idx_fca27c70__tuned_type_and_idv_old;

ALTER MATERIALIZED VIEW api_transaction_view_temp RENAME TO api_transaction_view;
ALTER INDEX idx_fca27c70__transaction_uid_temp RENAME TO idx_fca27c70__transaction_uid;
ALTER INDEX idx_fca27c70__action_date_temp RENAME TO idx_fca27c70__action_date;
ALTER INDEX idx_fca27c70__fiscal_year_temp RENAME TO idx_fca27c70__fiscal_year;
ALTER INDEX idx_fca27c70__type_temp RENAME TO idx_fca27c70__type;
ALTER INDEX idx_fca27c70__ordered_type_temp RENAME TO idx_fca27c70__ordered_type;
ALTER INDEX idx_fca27c70__action_type_temp RENAME TO idx_fca27c70__action_type;
ALTER INDEX idx_fca27c70__award_id_temp RENAME TO idx_fca27c70__award_id;
ALTER INDEX idx_fca27c70__award_category_temp RENAME TO idx_fca27c70__award_category;
ALTER INDEX idx_fca27c70__total_obligation_temp RENAME TO idx_fca27c70__total_obligation;
ALTER INDEX idx_fca27c70__ordered_total_obligation_temp RENAME TO idx_fca27c70__ordered_total_obligation;
ALTER INDEX idx_fca27c70__total_obl_bin_temp RENAME TO idx_fca27c70__total_obl_bin;
ALTER INDEX idx_fca27c70__pop_country_code_temp RENAME TO idx_fca27c70__pop_country_code;
ALTER INDEX idx_fca27c70__pop_state_code_temp RENAME TO idx_fca27c70__pop_state_code;
ALTER INDEX idx_fca27c70__pop_county_code_temp RENAME TO idx_fca27c70__pop_county_code;
ALTER INDEX idx_fca27c70__pop_zip5_temp RENAME TO idx_fca27c70__pop_zip5;
ALTER INDEX idx_fca27c70__pop_congressional_code_temp RENAME TO idx_fca27c70__pop_congressional_code;
ALTER INDEX idx_fca27c70__gin_recipient_name_temp RENAME TO idx_fca27c70__gin_recipient_name;
ALTER INDEX idx_fca27c70__gin_recipient_unique_id_temp RENAME TO idx_fca27c70__gin_recipient_unique_id;
ALTER INDEX idx_fca27c70__gin_parent_recipient_unique_id_temp RENAME TO idx_fca27c70__gin_parent_recipient_unique_id;
ALTER INDEX idx_fca27c70__recipient_id_temp RENAME TO idx_fca27c70__recipient_id;
ALTER INDEX idx_fca27c70__recipient_name_temp RENAME TO idx_fca27c70__recipient_name;
ALTER INDEX idx_fca27c70__recipient_unique_id_temp RENAME TO idx_fca27c70__recipient_unique_id;
ALTER INDEX idx_fca27c70__parent_recipient_unique_id_temp RENAME TO idx_fca27c70__parent_recipient_unique_id;
ALTER INDEX idx_fca27c70__awarding_agency_id_temp RENAME TO idx_fca27c70__awarding_agency_id;
ALTER INDEX idx_fca27c70__funding_agency_id_temp RENAME TO idx_fca27c70__funding_agency_id;
ALTER INDEX idx_fca27c70__awarding_toptier_agency_name_temp RENAME TO idx_fca27c70__awarding_toptier_agency_name;
ALTER INDEX idx_fca27c70__awarding_subtier_agency_name_temp RENAME TO idx_fca27c70__awarding_subtier_agency_name;
ALTER INDEX idx_fca27c70__funding_toptier_agency_name_temp RENAME TO idx_fca27c70__funding_toptier_agency_name;
ALTER INDEX idx_fca27c70__funding_subtier_agency_name_temp RENAME TO idx_fca27c70__funding_subtier_agency_name;
ALTER INDEX idx_fca27c70__recipient_location_country_code_temp RENAME TO idx_fca27c70__recipient_location_country_code;
ALTER INDEX idx_fca27c70__recipient_location_state_code_temp RENAME TO idx_fca27c70__recipient_location_state_code;
ALTER INDEX idx_fca27c70__recipient_location_county_code_temp RENAME TO idx_fca27c70__recipient_location_county_code;
ALTER INDEX idx_fca27c70__recipient_location_zip5_temp RENAME TO idx_fca27c70__recipient_location_zip5;
ALTER INDEX idx_fca27c70__recipient_location_congressional_code_temp RENAME TO idx_fca27c70__recipient_location_congressional_code;
ALTER INDEX idx_fca27c70__cfda_multi_temp RENAME TO idx_fca27c70__cfda_multi;
ALTER INDEX idx_fca27c70__pulled_from_temp RENAME TO idx_fca27c70__pulled_from;
ALTER INDEX idx_fca27c70__type_of_contract_pricing_temp RENAME TO idx_fca27c70__type_of_contract_pricing;
ALTER INDEX idx_fca27c70__extent_competed_temp RENAME TO idx_fca27c70__extent_competed;
ALTER INDEX idx_fca27c70__type_set_aside_temp RENAME TO idx_fca27c70__type_set_aside;
ALTER INDEX idx_fca27c70__product_or_service_code_temp RENAME TO idx_fca27c70__product_or_service_code;
ALTER INDEX idx_fca27c70__gin_naics_code_temp RENAME TO idx_fca27c70__gin_naics_code;
ALTER INDEX idx_fca27c70__naics_code_temp RENAME TO idx_fca27c70__naics_code;
ALTER INDEX idx_fca27c70__business_categories_temp RENAME TO idx_fca27c70__business_categories;
ALTER INDEX idx_fca27c70__keyword_string_temp RENAME TO idx_fca27c70__keyword_string;
ALTER INDEX idx_fca27c70__award_id_string_temp RENAME TO idx_fca27c70__award_id_string;
ALTER INDEX idx_fca27c70__tuned_type_and_idv_temp RENAME TO idx_fca27c70__tuned_type_and_idv;

GRANT SELECT ON api_transaction_view TO readonly;
