{{
    config(
        materialized='incremental'
    )
}}

select 	* from {{ source('ops_db', 'mock_users_data') }}
{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where created_at >= (select max(created_at) from {{ this }})

{% endif %}