{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_team_members') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['role'], ['role']) }} as {{ adapter.quote('role') }},
    {{ json_extract_scalar('_airbyte_data', ['team'], ['team']) }} as team,
    {{ json_extract_scalar('_airbyte_data', ['user'], ['user']) }} as {{ adapter.quote('user') }},
    {{ json_extract_scalar('_airbyte_data', ['isLeft'], ['isLeft']) }} as isleft,
    {{ json_extract_scalar('_airbyte_data', ['leftAt'], ['leftAt']) }} as leftat,
    {{ json_extract_scalar('_airbyte_data', ['joinedAt'], ['joinedAt']) }} as joinedat,
    {{ json_extract_scalar('_airbyte_data', ['roleCode'], ['roleCode']) }} as rolecode,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['statistic'], ['statistic']) }} as statistic,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_scalar('_airbyte_data', ['isRemovedBy'], ['isRemovedBy']) }} as isremovedby,
    {{ json_extract_scalar('_airbyte_data', ['firstOrderAt'], ['firstOrderAt']) }} as firstorderat,
    {{ json_extract_scalar('_airbyte_data', ['searchString'], ['searchString']) }} as searchstring,
    {{ json_extract_scalar('_airbyte_data', ['isMemberHomegrown'], ['isMemberHomegrown']) }} as ismemberhomegrown,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_team_members') }} as table_alias
-- team_members
where 1 = 1

