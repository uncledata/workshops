{{
  config(
    materialized = "local_insert_by_period",
    period = "month",
    timestamp_field = "created_at",
    start_date = "2018-01-01"
    )
}}

with events as (
  SELECT id, created_at, first_name, last_name
  FROM {{ source('ops_db', 'mock_users_data') }}

  WHERE __PERIOD_FILTER__ 
  )
  select id, created_at, first_name, last_name 
from events
