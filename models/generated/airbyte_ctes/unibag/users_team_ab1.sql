{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('users') }}
select
    _airbyte_users_hashid,
    {{ json_extract_scalar('team', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('team', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('team', ['role'], ['role']) }} as {{ adapter.quote('role') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users') }} as table_alias
-- team at users/team
where 1 = 1
and team is not null

