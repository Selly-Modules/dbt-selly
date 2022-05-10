{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('membership_histories') }}
select
    _airbyte_membership_histories_hashid,
    {{ json_extract_scalar(adapter.quote('new'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar(adapter.quote('new'), ['level'], ['level']) }} as {{ adapter.quote('level') }},
    {{ json_extract('table_alias', adapter.quote('new'), ['condition'], ['condition']) }} as {{ adapter.quote('condition') }},
    {{ json_extract_scalar(adapter.quote('new'), ['statistic'], ['statistic']) }} as statistic,
    {{ json_extract_scalar(adapter.quote('new'), ['transaction'], ['transaction']) }} as {{ adapter.quote('transaction') }},
    {{ json_extract_scalar(adapter.quote('new'), ['bonusPercent'], ['bonusPercent']) }} as bonuspercent,
    {{ json_extract_scalar(adapter.quote('new'), ['transactionMinValue'], ['transactionMinValue']) }} as transactionminvalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('membership_histories') }} as table_alias
-- new at membership-histories/new
where 1 = 1
and {{ adapter.quote('new') }} is not null

