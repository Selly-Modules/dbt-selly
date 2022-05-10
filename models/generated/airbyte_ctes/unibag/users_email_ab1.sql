{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('users') }}
select
    _airbyte_users_hashid,
    {{ json_extract_scalar('email', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('email', ['verified'], ['verified']) }} as verified,
    {{ json_extract_scalar('email', ['verifiedAt'], ['verifiedAt']) }} as verifiedat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users') }} as table_alias
-- email at users/email
where 1 = 1
and email is not null

