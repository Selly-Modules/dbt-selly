{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_events') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['desc'], ['desc']) }} as {{ adapter.quote('desc') }},
    {{ json_extract_scalar('_airbyte_data', ['icon'], ['icon']) }} as icon,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as {{ adapter.quote('type') }},
    {{ json_extract_scalar('_airbyte_data', ['cover'], ['cover']) }} as cover,
    {{ json_extract_scalar('_airbyte_data', ['endAt'], ['endAt']) }} as endat,
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['notice'], ['notice']) }} as notice,
    {{ json_extract_scalar('_airbyte_data', ['screen'], ['screen']) }} as screen,
    {{ json_extract_scalar('_airbyte_data', ['article'], ['article']) }} as article,
    {{ json_extract_scalar('_airbyte_data', ['options'], ['options']) }} as {{ adapter.quote('options') }},
    {{ json_extract_scalar('_airbyte_data', ['startAt'], ['startAt']) }} as startat,
    {{ json_extract_scalar('_airbyte_data', ['segments'], ['segments']) }} as segments,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['groupType'], ['groupType']) }} as grouptype,
    {{ json_extract_array('_airbyte_data', ['suppliers'], ['suppliers']) }} as suppliers,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_array('_airbyte_data', ['information'], ['information']) }} as information,
    {{ json_extract_scalar('_airbyte_data', ['displayEndAt'], ['displayEndAt']) }} as displayendat,
    {{ json_extract_scalar('_airbyte_data', ['isApplyForAll'], ['isApplyForAll']) }} as isapplyforall,
    {{ json_extract_scalar('_airbyte_data', ['displayStartAt'], ['displayStartAt']) }} as displaystartat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_events') }} as table_alias
-- events
where 1 = 1

