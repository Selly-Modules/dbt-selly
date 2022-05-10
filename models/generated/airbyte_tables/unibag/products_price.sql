{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('products_price_ab3') }}
select
    _airbyte_products_hashid,
    base,
    market,
    profit,
    maximum,
    minimum,
    supplier,
    wholesalebonus,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_price_hashid
from {{ ref('products_price_ab3') }}
-- price at products/price from {{ ref('products') }}
where 1 = 1

