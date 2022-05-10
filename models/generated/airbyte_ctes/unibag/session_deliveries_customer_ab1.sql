{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('session_deliveries') }}
select
    _airbyte_session_deliveries_hashid,
    {{ json_extract_scalar('customer', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('customer', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('customer', ['phone'], ['phone']) }} as phone,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('session_deliveries') }} as table_alias
-- customer at session-deliveries/customer
where 1 = 1
and customer is not null

