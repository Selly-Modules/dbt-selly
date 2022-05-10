{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('users') }}
select
    _airbyte_users_hashid,
    {{ json_extract_scalar('avatar', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('avatar', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract('table_alias', 'avatar', ['dimensions'], ['dimensions']) }} as dimensions,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users') }} as table_alias
-- avatar at users/avatar
where 1 = 1
and avatar is not null

