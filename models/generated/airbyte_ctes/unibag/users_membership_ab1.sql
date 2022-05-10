{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('users') }}
select
    _airbyte_users_hashid,
    {{ json_extract_scalar('membership', ['expireAt'], ['expireAt']) }} as expireat,
    {{ json_extract_scalar('membership', ['nextLevel'], ['nextLevel']) }} as nextlevel,
    {{ json_extract_scalar('membership', ['currentLevel'], ['currentLevel']) }} as currentlevel,
    {{ json_extract_scalar('membership', ['currentTransactionCount'], ['currentTransactionCount']) }} as currenttransactioncount,
    {{ json_extract_scalar('membership', ['currentSales_aibyte_transform'], ['currentSales_aibyte_transform']) }} as currentsales_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users') }} as table_alias
-- membership at users/membership
where 1 = 1
and membership is not null

