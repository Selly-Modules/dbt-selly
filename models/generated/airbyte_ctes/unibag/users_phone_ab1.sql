{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('users') }}
select
    _airbyte_users_hashid,
    {{ json_extract_scalar('phone', ['full'], ['full']) }} as {{ adapter.quote('full') }},
    {{ json_extract_scalar('phone', ['number'], ['number']) }} as {{ adapter.quote('number') }},
    {{ json_extract_scalar('phone', ['verified'], ['verified']) }} as verified,
    {{ json_extract_scalar('phone', ['verifiedAt'], ['verifiedAt']) }} as verifiedat,
    {{ json_extract_scalar('phone', ['countryCode'], ['countryCode']) }} as countrycode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users') }} as table_alias
-- phone at users/phone
where 1 = 1
and phone is not null

