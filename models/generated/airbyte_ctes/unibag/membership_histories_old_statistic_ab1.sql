{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('membership_histories_old') }}
select
    _airbyte_old_hashid,
    {{ json_extract_scalar('statistic', ['sales'], ['sales']) }} as sales,
    {{ json_extract_scalar('statistic', ['transaction'], ['transaction']) }} as {{ adapter.quote('transaction') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('membership_histories_old') }} as table_alias
-- statistic at membership-histories/old/statistic
where 1 = 1
and statistic is not null

