{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('user_identifications') }}
select
    _airbyte_user_identifications_hashid,
    {{ json_extract_scalar('frontside', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('frontside', ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract('table_alias', 'frontside', ['dimensions'], ['dimensions']) }} as dimensions,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_identifications') }} as table_alias
-- frontside at user-identifications/frontSide
where 1 = 1
and frontside is not null

