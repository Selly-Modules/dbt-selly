{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('products_info_inventory_location') }}
select
    _airbyte_location_hashid,
    {{ json_extract_scalar(adapter.quote('location'), ['type'], ['type']) }} as {{ adapter.quote('type') }},
    {{ json_extract_array(adapter.quote('location'), ['coordinates'], ['coordinates']) }} as coordinates,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('products_info_inventory_location') }} as table_alias
-- location at products/info/inventory/location/location
where 1 = 1
and {{ adapter.quote('location') }} is not null

