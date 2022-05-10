{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('users') }}
select
    _airbyte_users_hashid,
    {{ json_extract_scalar('info', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('info', ['gender'], ['gender']) }} as gender,
    {{ json_extract_scalar('info', ['cityCode'], ['cityCode']) }} as citycode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users') }} as table_alias
-- info at users/info
where 1 = 1
and info is not null

