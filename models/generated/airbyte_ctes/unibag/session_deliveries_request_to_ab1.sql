{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('session_deliveries_request') }}
select
    _airbyte_request_hashid,
    {{ json_extract_scalar(adapter.quote('to'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar(adapter.quote('to'), ['phone'], ['phone']) }} as phone,
    {{ json_extract('table_alias', adapter.quote('to'), ['location'], ['location']) }} as {{ adapter.quote('location') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('session_deliveries_request') }} as table_alias
-- to at session-deliveries/request/to
where 1 = 1
and {{ adapter.quote('to') }} is not null

