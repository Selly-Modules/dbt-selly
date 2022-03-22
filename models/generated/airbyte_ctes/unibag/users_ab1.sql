{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_users') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['code'], ['code']) }} as code,
    {{ json_extract_scalar('_airbyte_data', ['info'], ['info']) }} as info,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('_airbyte_data', ['team'], ['team']) }} as team,
    {{ json_extract_scalar('_airbyte_data', ['zalo'], ['zalo']) }} as zalo,
    {{ json_extract_scalar('_airbyte_data', ['email'], ['email']) }} as email,
    {{ json_extract_scalar('_airbyte_data', ['phone'], ['phone']) }} as phone,
    {{ json_extract_scalar('_airbyte_data', ['avatar'], ['avatar']) }} as avatar,
    {{ json_extract_scalar('_airbyte_data', ['banned'], ['banned']) }} as banned,
    {{ json_extract_scalar('_airbyte_data', ['segment'], ['segment']) }} as segment,
    {{ json_extract_scalar('_airbyte_data', ['facebook'], ['facebook']) }} as facebook,
    {{ json_extract_scalar('_airbyte_data', ['hasOrder'], ['hasOrder']) }} as hasorder,
    {{ json_extract_scalar('_airbyte_data', ['referral'], ['referral']) }} as referral,
    {{ json_extract_array('_airbyte_data', ['segments'], ['segments']) }} as segments,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['statistic'], ['statistic']) }} as statistic,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_scalar('_airbyte_data', ['membership'], ['membership']) }} as membership,
    {{ json_extract_scalar('_airbyte_data', ['lastOrderAt'], ['lastOrderAt']) }} as lastorderat,
    {{ json_extract_scalar('_airbyte_data', ['firstOrderAt'], ['firstOrderAt']) }} as firstorderat,
    {{ json_extract_scalar('_airbyte_data', ['registerFrom'], ['registerFrom']) }} as registerfrom,
    {{ json_extract_scalar('_airbyte_data', ['searchString'], ['searchString']) }} as searchstring,
    {{ json_extract_scalar('_airbyte_data', ['adjustTracker'], ['adjustTracker']) }} as adjusttracker,
    {{ json_extract_scalar('_airbyte_data', ['isUpdatedInfo'], ['isUpdatedInfo']) }} as isupdatedinfo,
    {{ json_extract_scalar('_airbyte_data', ['identification'], ['identification']) }} as identification,
    {{ json_extract_scalar('_airbyte_data', ['lastActivatedAt'], ['lastActivatedAt']) }} as lastactivatedat,
    {{ json_extract_scalar('_airbyte_data', ['lastViewNotificationAt'], ['lastViewNotificationAt']) }} as lastviewnotificationat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_users') }} as table_alias
-- users
where 1 = 1

