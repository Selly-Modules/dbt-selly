{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('users') }}
select
    _airbyte_users_hashid,
    {{ json_extract_scalar('identification', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('identification', ['note'], ['note']) }} as note,
    {{ json_extract_scalar('identification', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('identification', ['timeUpdate'], ['timeUpdate']) }} as timeupdate,
    {{ json_extract_scalar('identification', ['completedAt'], ['completedAt']) }} as completedat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users') }} as table_alias
-- identification at users/identification
where 1 = 1
and identification is not null

