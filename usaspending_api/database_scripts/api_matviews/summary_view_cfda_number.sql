--------------------------------------------------------
-- Created using matview_sql_generator.py             --
--    The SQL definition is stored in a json file     --
--    Look in matview_generator for the code.         --
--                                                    --
--  DO NOT DIRECTLY EDIT THIS FILE!!!                 --
--------------------------------------------------------
DROP MATERIALIZED VIEW IF EXISTS summary_view_cfda_number_temp;
DROP MATERIALIZED VIEW IF EXISTS summary_view_cfda_number_old;

CREATE MATERIALIZED VIEW summary_view_cfda_number_temp AS
SELECT
  "transaction_normalized"."action_date",
  "transaction_normalized"."fiscal_year",
  "transaction_normalized"."type",
  "transaction_fpds"."pulled_from",
  "transaction_fabs"."cfda_number",
  "transaction_fabs"."cfda_title",
  SUM("transaction_normalized"."federal_action_obligation") AS "federal_action_obligation",
  COUNT(*) counts
FROM
  "transaction_normalized"
LEFT OUTER JOIN
  "transaction_fabs" ON ("transaction_normalized"."id" = "transaction_fabs"."transaction_id")
LEFT OUTER JOIN
  "transaction_fpds" ON ("transaction_normalized"."id" = "transaction_fpds"."transaction_id")
WHERE
  "transaction_normalized"."action_date" >= '2007-10-01'
GROUP BY
  "transaction_normalized"."action_date",
  "transaction_normalized"."fiscal_year",
  "transaction_normalized"."type",
  "transaction_fpds"."pulled_from",
  "transaction_fabs"."cfda_number",
  "transaction_fabs"."cfda_title";

CREATE INDEX idx_8bf732c2__action_date_temp ON summary_view_cfda_number_temp USING BTREE("action_date" DESC NULLS LAST) WITH (fillfactor = 100);
CREATE INDEX idx_8bf732c2__type_temp ON summary_view_cfda_number_temp USING BTREE("action_date" DESC NULLS LAST, "type") WITH (fillfactor = 100);
CREATE INDEX idx_8bf732c2__tuned_type_and_idv_temp ON summary_view_cfda_number_temp USING BTREE("type", "pulled_from") WITH (fillfactor = 100) WHERE "type" IS NULL AND "pulled_from" IS NOT NULL;

ANALYZE VERBOSE summary_view_cfda_number_temp;

ALTER MATERIALIZED VIEW IF EXISTS summary_view_cfda_number RENAME TO summary_view_cfda_number_old;
ALTER INDEX IF EXISTS idx_8bf732c2__action_date RENAME TO idx_8bf732c2__action_date_old;
ALTER INDEX IF EXISTS idx_8bf732c2__type RENAME TO idx_8bf732c2__type_old;
ALTER INDEX IF EXISTS idx_8bf732c2__tuned_type_and_idv RENAME TO idx_8bf732c2__tuned_type_and_idv_old;

ALTER MATERIALIZED VIEW summary_view_cfda_number_temp RENAME TO summary_view_cfda_number;
ALTER INDEX idx_8bf732c2__action_date_temp RENAME TO idx_8bf732c2__action_date;
ALTER INDEX idx_8bf732c2__type_temp RENAME TO idx_8bf732c2__type;
ALTER INDEX idx_8bf732c2__tuned_type_and_idv_temp RENAME TO idx_8bf732c2__tuned_type_and_idv;

GRANT SELECT ON summary_view_cfda_number TO readonly;
