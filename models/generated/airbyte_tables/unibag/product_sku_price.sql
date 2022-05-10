{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('product_sku_price_ab3') }}
select
    _airbyte_product_sku_hashid,
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
from {{ ref('product_sku_price_ab3') }}
-- price at product-sku/price from {{ ref('product_sku') }}
where 1 = 1

