{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_product_sku_versions') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['sku'], ['sku']) }} as sku,
    {{ json_extract_scalar('_airbyte_data', ['info'], ['info']) }} as info,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('_airbyte_data', ['price'], ['price']) }} as price,
    {{ json_extract_scalar('_airbyte_data', ['source'], ['source']) }} as {{ adapter.quote('source') }},
    {{ json_extract_scalar('_airbyte_data', ['codeSku'], ['codeSku']) }} as codesku,
    {{ json_extract_scalar('_airbyte_data', ['picture'], ['picture']) }} as picture,
    {{ json_extract_scalar('_airbyte_data', ['product'], ['product']) }} as product,
    {{ json_extract_scalar('_airbyte_data', ['statistic'], ['statistic']) }} as statistic,
    {{ json_extract_scalar('_airbyte_data', ['version'], ['version']) }} as {{ adapter.quote('version') }},
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_array('_airbyte_data', ['properties'], ['properties']) }} as properties,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_product_sku_versions') }} as table_alias
-- product_sku_versions
where 1 = 1

