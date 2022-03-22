{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('inventories_ab3') }}
select
    _id AS id,
    {{ adapter.quote('name') }},
    code,
    active,
    {{ adapter.quote('location') }}::json->>'address' AS location_address,
    {{ adapter.quote('location') }}::json->>'province' AS location_province,
    {{ adapter.quote('location') }}::json->>'district' AS location_district,
    {{ adapter.quote('location') }}::json->>'ward' AS location_ward,
    {{ adapter.quote('supplier') }}::json->>'_id' AS supplier_id,
    {{ adapter.quote('supplier') }}::json->>'name' AS supplier_name,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_inventories_hashid
from {{ ref('inventories_ab3') }}
-- inventories from {{ source('unibag', '_airbyte_raw_inventories') }}
where 1 = 1

