# usaspending-sql
SQL Scripts used to run modifications to the USASpending Database (data_store_api)

## api_matviews
A collection of SQL files to create the materialized views for the API

## broker_matviews
Materialized views which are created using the broker DB as a remote DB to source the data

## matview_generator
A Python script is here which takes the JSON files (also located here) to create the "api matviews" SQL

## matview_ops
A number of scripts which are intended for facilitating the data pipeline from broker DB to api matviews

