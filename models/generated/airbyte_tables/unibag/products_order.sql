{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('products_order_ab3') }}
select
    _airbyte_products_hashid,
    newest,
    profit,
    topsale,
    scoreyesterday,
    region_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_order_hashid
from {{ ref('products_order_ab3') }}
-- order at products/order from {{ ref('products') }}
where 1 = 1

