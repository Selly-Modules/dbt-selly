{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('membership_histories_old') }}
select
    _airbyte_old_hashid,
    {{ json_extract_scalar(adapter.quote('condition'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar(adapter.quote('condition'), ['sales'], ['sales']) }} as sales,
    {{ json_extract_scalar(adapter.quote('condition'), ['transaction'], ['transaction']) }} as {{ adapter.quote('transaction') }},
    {{ json_extract_scalar(adapter.quote('condition'), ['bonusPercent'], ['bonusPercent']) }} as bonuspercent,
    {{ json_extract_scalar(adapter.quote('condition'), ['transactionMinValue'], ['transactionMinValue']) }} as transactionminvalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('membership_histories_old') }} as table_alias
-- condition at membership-histories/old/condition
where 1 = 1
and {{ adapter.quote('condition') }} is not null

