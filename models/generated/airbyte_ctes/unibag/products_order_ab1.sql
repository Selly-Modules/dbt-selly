{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('products') }}
select
    _airbyte_products_hashid,
    {{ json_extract_scalar(adapter.quote('order'), ['newest'], ['newest']) }} as newest,
    {{ json_extract_scalar(adapter.quote('order'), ['profit'], ['profit']) }} as profit,
    {{ json_extract_scalar(adapter.quote('order'), ['topSale'], ['topSale']) }} as topsale,
    {{ json_extract_scalar(adapter.quote('order'), ['scoreYesterday'], ['scoreYesterday']) }} as scoreyesterday,
    {{ json_extract_scalar(adapter.quote('order'), ['region_aibyte_transform'], ['region_aibyte_transform']) }} as region_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('products') }} as table_alias
-- order at products/order
where 1 = 1
and {{ adapter.quote('order') }} is not null

