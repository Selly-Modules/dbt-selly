{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('unibag', '_airbyte_raw_user_identifications') }}
select
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['dob'], ['dob']) }} as dob,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar('_airbyte_data', ['note'], ['note']) }} as note,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as {{ adapter.quote('type') }},
    {{ json_extract_scalar('_airbyte_data', ['user'], ['user']) }} as {{ adapter.quote('user') }},
    {{ json_extract_scalar('_airbyte_data', ['gender'], ['gender']) }} as gender,
    {{ json_extract_scalar('_airbyte_data', ['nation'], ['nation']) }} as nation,
    {{ json_extract_scalar('_airbyte_data', ['number'], ['number']) }} as {{ adapter.quote('number') }},
    {{ json_extract_scalar('_airbyte_data', ['status'], ['status']) }} as status,
    {{ json_extract_scalar('_airbyte_data', ['address'], ['address']) }} as address,
    {{ json_extract_scalar('_airbyte_data', ['dobDate'], ['dobDate']) }} as dobdate,
    {{ json_extract_scalar('_airbyte_data', ['backSide'], ['backSide']) }} as backside,
    {{ json_extract_scalar('_airbyte_data', ['birthday'], ['birthday']) }} as birthday,
    {{ json_extract_scalar('_airbyte_data', ['createdAt'], ['createdAt']) }} as createdat,
    {{ json_extract_scalar('_airbyte_data', ['frontSide'], ['frontSide']) }} as frontside,
    {{ json_extract_scalar('_airbyte_data', ['issueDate'], ['issueDate']) }} as issuedate,
    {{ json_extract_scalar('_airbyte_data', ['updatedAt'], ['updatedAt']) }} as updatedat,
    {{ json_extract_scalar('_airbyte_data', ['expiryDate'], ['expiryDate']) }} as expirydate,
    {{ json_extract_scalar('_airbyte_data', ['issuePlace'], ['issuePlace']) }} as issueplace,
    {{ json_extract_scalar('_airbyte_data', ['timeUpdate'], ['timeUpdate']) }} as timeupdate,
    {{ json_extract_scalar('_airbyte_data', ['detectInformation'], ['detectInformation']) }} as detectinformation,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('unibag', '_airbyte_raw_user_identifications') }} as table_alias
-- user_identifications
where 1 = 1

