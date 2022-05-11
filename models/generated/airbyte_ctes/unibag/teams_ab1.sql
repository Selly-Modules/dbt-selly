{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_teams') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['code'], ['code']) }} as code,
    {{ json_extract_scalar('_airbyte_data', ['desc'], ['desc']) }} as {{ adapter.quote('desc') }},
    {{ json_extract_scalar('_airbyte_data', ['logo'], ['logo']) }} as logo,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('_airbyte_data', ['level'], ['level']) }} as {{ adapter.quote('level') }},
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['isFull'], ['isFull']) }} as isfull,
    {{ json_extract_scalar('_airbyte_data', ['cityCode'], ['cityCode']) }} as citycode,
    {{ json_extract_scalar('_airbyte_data', ['adminUser'], ['adminUser']) }} as adminuser,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['statistic'], ['statistic']) }} as statistic,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_scalar('_airbyte_data', ['inviteLink'], ['inviteLink']) }} as invitelink,
    {{ json_extract_scalar('_airbyte_data', ['information'], ['information']) }} as information,
    {{ json_extract_scalar('_airbyte_data', ['searchString'], ['searchString']) }} as searchstring,
    {{ json_extract_scalar('_airbyte_data', ['inactiveReason'], ['inactiveReason']) }} as inactivereason,
    {{ json_extract_scalar('_airbyte_data', ['changingNameCount'], ['changingNameCount']) }} as changingnamecount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_teams') }} as table_alias
-- teams
where 1 = 1

