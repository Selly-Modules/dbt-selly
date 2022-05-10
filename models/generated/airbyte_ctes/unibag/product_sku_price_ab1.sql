{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('product_sku') }}
select
    _airbyte_product_sku_hashid,
    {{ json_extract_scalar('price', ['base'], ['base']) }} as base,
    {{ json_extract_scalar('price', ['market'], ['market']) }} as market,
    {{ json_extract_scalar('price', ['profit'], ['profit']) }} as profit,
    {{ json_extract_scalar('price', ['maximum'], ['maximum']) }} as maximum,
    {{ json_extract_scalar('price', ['minimum'], ['minimum']) }} as minimum,
    {{ json_extract_scalar('price', ['supplier'], ['supplier']) }} as supplier,
    {{ json_extract_scalar('price', ['wholesaleBonus'], ['wholesaleBonus']) }} as wholesalebonus,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('product_sku') }} as table_alias
-- price at product-sku/price
where 1 = 1
and price is not null

