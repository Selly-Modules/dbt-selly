{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('products_ab3') }}
select
    _id AS id,
    {{ adapter.quote('name') }},
    active,
    string_to_array(REPLACE(REPLACE(REPLACE(categories::text, '[', ''), ']', ''), '"', ''), ',') AS categories,
    string_to_array(REPLACE(REPLACE(REPLACE(subcategories::text, '[', ''), ']', ''), '"', ''), ',') AS sub_categories,
    cast({{ adapter.quote('price') }}::json->>'base' AS numeric) AS price_base,
    cast({{ adapter.quote('price') }}::json->>'market' AS numeric) AS price_market,
    cast({{ adapter.quote('price') }}::json->>'minimum' AS numeric) AS price_min,
    cast({{ adapter.quote('price') }}::json->>'maximum' AS numeric) AS price_max,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_products_hashid
from {{ ref('products_ab3') }}
-- products from {{ source('unibag', '_airbyte_raw_products') }}
where 1 = 1

