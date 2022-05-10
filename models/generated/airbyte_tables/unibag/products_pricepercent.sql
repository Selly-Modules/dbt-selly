{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('products_pricepercent_ab3') }}
select
    _airbyte_products_hashid,
    base,
    selly,
    market,
    maximum,
    minimum,
    supplier,
    minimumpricedifferential,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_pricepercent_hashid
from {{ ref('products_pricepercent_ab3') }}
-- pricepercent at products/pricePercent from {{ ref('products') }}
where 1 = 1

