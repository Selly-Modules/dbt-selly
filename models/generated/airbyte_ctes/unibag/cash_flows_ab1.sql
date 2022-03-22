{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_cash_flows') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['hash'], ['hash']) }} as hash,
    {{ json_extract_scalar('_airbyte_data', ['user'], ['user']) }} as {{ adapter.quote('user') }},
    {{ json_extract_scalar('_airbyte_data', ['value'], ['value']) }} as {{ adapter.quote('value') }},
    {{ json_extract_scalar('_airbyte_data', ['action'], ['action']) }} as {{ adapter.quote('action') }},
    {{ json_extract_scalar('_airbyte_data', ['options'], ['options']) }} as {{ adapter.quote('options') }},
    {{ json_extract_scalar('_airbyte_data', ['category'], ['category']) }} as category,
    {{ json_extract_scalar('_airbyte_data', ['targetId'], ['targetId']) }} as targetid,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['isAudited'], ['isAudited']) }} as isaudited,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_scalar('_airbyte_data', ['newBalance'], ['newBalance']) }} as newbalance,
    {{ json_extract_scalar('_airbyte_data', ['oldBalance'], ['oldBalance']) }} as oldbalance,
    {{ json_extract_scalar('_airbyte_data', ['targetType'], ['targetType']) }} as targettype,
    {{ json_extract_scalar('_airbyte_data', ['isProcessed'], ['isProcessed']) }} as isprocessed,
    {{ json_extract_scalar('_airbyte_data', ['processStatus'], ['processStatus']) }} as processstatus,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_cash_flows') }} as table_alias
-- cash_flows
where 1 = 1

