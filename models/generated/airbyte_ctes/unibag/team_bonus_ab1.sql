{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_team_bonus') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['team'], ['team']) }} as team,
    {{ json_extract_scalar('_airbyte_data', ['user'], ['user']) }} as {{ adapter.quote('user') }},
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['percent'], ['percent']) }} as {{ adapter.quote('percent') }},
    {{ json_extract_scalar('_airbyte_data', ['targetId'], ['targetId']) }} as targetid,
    {{ json_extract_scalar('_airbyte_data', ['teamName'], ['teamName']) }} as teamname,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['teamLevel'], ['teamLevel']) }} as teamlevel,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_scalar('_airbyte_data', ['commission'], ['commission']) }} as commission,
    {{ json_extract_scalar('_airbyte_data', ['teamMember'], ['teamMember']) }} as teammember,
    {{ json_extract_scalar('_airbyte_data', ['teamPromotion'], ['teamPromotion']) }} as teampromotion,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_team_bonus') }} as table_alias
-- team_bonus
where 1 = 1

