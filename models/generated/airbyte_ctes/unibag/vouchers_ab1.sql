{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_vouchers') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['code'], ['code']) }} as code,
    {{ json_extract_scalar('_airbyte_data', ['desc'], ['desc']) }} as {{ adapter.quote('desc') }},
    {{ json_extract('table_alias', '_airbyte_data', ['logo'], ['logo']) }} as logo,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as {{ adapter.quote('type') }},
    {{ json_extract_scalar('_airbyte_data', ['endAt'], ['endAt']) }} as endat,
    {{ json_extract_scalar('_airbyte_data', ['title'], ['title']) }} as title,
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_array('_airbyte_data', ['covers'], ['covers']) }} as covers,
    {{ json_extract('table_alias', '_airbyte_data', ['options'], ['options']) }} as {{ adapter.quote('options') }},
    {{ json_extract_scalar('_airbyte_data', ['startAt'], ['startAt']) }} as startat,
    {{ json_extract('table_alias', '_airbyte_data', ['applyFor'], ['applyFor']) }} as applyfor,
    {{ json_extract_scalar('_airbyte_data', ['articleID'], ['articleID']) }} as articleid,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_scalar('_airbyte_data', ['searchString'], ['searchString']) }} as searchstring,
    {{ json_extract_scalar('_airbyte_data', ['isApplyForOrderWholesale'], ['isApplyForOrderWholesale']) }} as isapplyfororderwholesale,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_vouchers') }} as table_alias
-- vouchers
where 1 = 1

