{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('user_identifications_detectinformation') }}
select
    _airbyte_detectinformation_hashid,
    {{ json_extract_scalar('addressentities', ['ward'], ['ward']) }} as ward,
    {{ json_extract_scalar('addressentities', ['street'], ['street']) }} as street,
    {{ json_extract_scalar('addressentities', ['district'], ['district']) }} as district,
    {{ json_extract_scalar('addressentities', ['province'], ['province']) }} as province,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_identifications_detectinformation') }} as table_alias
-- addressentities at user-identifications/detectInformation/addressEntities
where 1 = 1
and addressentities is not null

