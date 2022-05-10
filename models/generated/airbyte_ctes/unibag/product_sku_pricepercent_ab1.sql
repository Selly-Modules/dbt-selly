{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('product_sku') }}
select
    _airbyte_product_sku_hashid,
    {{ json_extract_scalar('pricepercent', ['supplier'], ['supplier']) }} as supplier,
    {{ json_extract_scalar('pricepercent', ['minimumPriceDifferential'], ['minimumPriceDifferential']) }} as minimumpricedifferential,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('product_sku') }} as table_alias
-- pricepercent at product-sku/pricePercent
where 1 = 1
and pricepercent is not null

