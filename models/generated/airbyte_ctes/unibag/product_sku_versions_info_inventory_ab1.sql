{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('product_sku_versions_info') }}
select
    _airbyte_info_hashid,
    {{ json_extract_scalar('inventory', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('inventory', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('inventory', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('inventory', ['searchString'], ['searchString']) }} as searchstring,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('product_sku_versions_info') }} as table_alias
-- inventory at product-sku-versions/info/inventory
where 1 = 1
and inventory is not null

