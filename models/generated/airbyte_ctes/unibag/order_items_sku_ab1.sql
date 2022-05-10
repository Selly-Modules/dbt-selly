{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('order_items') }}
select
    _airbyte_order_items_hashid,
    {{ json_extract_scalar('sku', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('sku', ['sku'], ['sku']) }} as sku,
    {{ json_extract_scalar('sku', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('sku', ['type'], ['type']) }} as {{ adapter.quote('type') }},
    {{ json_extract_scalar('sku', ['source'], ['source']) }} as {{ adapter.quote('source') }},
    {{ json_extract_scalar('sku', ['picture'], ['picture']) }} as picture,
    {{ json_extract_scalar('sku', ['version'], ['version']) }} as {{ adapter.quote('version') }},
    {{ json_extract_array('sku', ['properties'], ['properties']) }} as properties,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('order_items') }} as table_alias
-- sku at order-items/sku
where 1 = 1
and sku is not null

