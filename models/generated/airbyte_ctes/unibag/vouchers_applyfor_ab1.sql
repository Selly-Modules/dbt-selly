{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('vouchers') }}
select
    _airbyte_vouchers_hashid,
    {{ json_extract_array('applyfor', ['list'], ['list']) }} as list,
    {{ json_extract_scalar('applyfor', ['type'], ['type']) }} as {{ adapter.quote('type') }},
    {{ json_extract_scalar('applyfor', ['provinces'], ['provinces']) }} as provinces,
    {{ json_extract_scalar('applyfor', ['isApplyAllOrder'], ['isApplyAllOrder']) }} as isapplyallorder,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('vouchers') }} as table_alias
-- applyfor at vouchers/applyFor
where 1 = 1
and applyfor is not null

