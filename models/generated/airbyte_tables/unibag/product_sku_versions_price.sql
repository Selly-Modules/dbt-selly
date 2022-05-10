{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('product_sku_versions_price_ab3') }}
select
    _airbyte_product_sku_versions_hashid,
    base,
    market,
    maximum,
    minimum,
    supplier,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_price_hashid
from {{ ref('product_sku_versions_price_ab3') }}
-- price at product-sku-versions/price from {{ ref('product_sku_versions') }}
where 1 = 1

