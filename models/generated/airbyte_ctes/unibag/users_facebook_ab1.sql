{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('users') }}
select
    _airbyte_users_hashid,
    {{ json_extract_scalar('facebook', ['id'], ['id']) }} as {{ adapter.quote('id') }},
    {{ json_extract_scalar('facebook', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('facebook', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('facebook', ['photo'], ['photo']) }} as photo,
    {{ json_extract_scalar('facebook', ['token'], ['token']) }} as {{ adapter.quote('token') }},
    {{ json_extract_scalar('facebook', ['gender'], ['gender']) }} as gender,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users') }} as table_alias
-- facebook at users/facebook
where 1 = 1
and facebook is not null

