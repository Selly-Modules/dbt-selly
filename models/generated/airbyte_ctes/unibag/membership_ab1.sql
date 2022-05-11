{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_membership') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('_airbyte_data', ['color'], ['color']) }} as color,
    {{ json_extract_scalar('_airbyte_data', ['guide'], ['guide']) }} as guide,
    {{ json_extract_scalar('_airbyte_data', ['level'], ['level']) }} as {{ adapter.quote('level') }},
    {{ json_extract_scalar('_airbyte_data', ['sales'], ['sales']) }} as sales,
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_scalar('_airbyte_data', ['updatedat'], ['updatedat']) }} as updatedat_1,
    {{ json_extract_scalar('_airbyte_data', ['transaction'], ['transaction']) }} as {{ adapter.quote('transaction') }},
    {{ json_extract_scalar('_airbyte_data', ['bonusPercent'], ['bonusPercent']) }} as bonuspercent,
    {{ json_extract_scalar('_airbyte_data', ['bonuspercent'], ['bonuspercent']) }} as bonuspercent_1,
    {{ json_extract_scalar('_airbyte_data', ['transactionMinValue'], ['transactionMinValue']) }} as transactionminvalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_membership') }} as table_alias
-- membership
where 1 = 1

