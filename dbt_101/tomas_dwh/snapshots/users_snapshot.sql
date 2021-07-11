{% snapshot users_snapshot %}

{{
    config(
      unique_key='id',
      target_schema = 'dbt_dev',

      strategy='timestamp',
      updated_at='updated_at',
    )
}}

select * from {{ source('ops_db', 'mock_users_data') }}

{% endsnapshot %}