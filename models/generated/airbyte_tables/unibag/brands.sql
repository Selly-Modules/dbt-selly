{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('brands_ab3') }}
select
    _id,
    {{ adapter.quote('name') }},
    active,
    {{ adapter.quote('country') }}::json->>'name' AS country_name,
    {{ adapter.quote('country') }}::json->>'code' AS country_code,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    COALESCE(cast(totalproduct AS integer), 0) AS total_product,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_brands_hashid
from {{ ref('brands_ab3') }}
-- brands from {{ source('unibag', '_airbyte_raw_brands') }}
where 1 = 1

