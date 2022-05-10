{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('product_sku_info_inventory') }}
select
    _airbyte_inventory_hashid,
    {{ json_extract_scalar(adapter.quote('location'), ['ward'], ['ward']) }} as ward,
    {{ json_extract_scalar(adapter.quote('location'), ['address'], ['address']) }} as address,
    {{ json_extract_scalar(adapter.quote('location'), ['district'], ['district']) }} as district,
    {{ json_extract('table_alias', adapter.quote('location'), ['location'], ['location']) }} as {{ adapter.quote('location') }},
    {{ json_extract_scalar(adapter.quote('location'), ['province'], ['province']) }} as province,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('product_sku_info_inventory') }} as table_alias
-- location at product-sku/info/inventory/location
where 1 = 1
and {{ adapter.quote('location') }} is not null

