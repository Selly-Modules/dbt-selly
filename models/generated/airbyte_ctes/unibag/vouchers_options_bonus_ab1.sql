{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('vouchers_options') }}
select
    _airbyte_options_hashid,
    {{ json_extract_scalar('bonus', ['type'], ['type']) }} as {{ adapter.quote('type') }},
    {{ json_extract_scalar('bonus', ['value'], ['value']) }} as {{ adapter.quote('value') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('vouchers_options') }} as table_alias
-- bonus at vouchers/options/bonus
where 1 = 1
and bonus is not null

