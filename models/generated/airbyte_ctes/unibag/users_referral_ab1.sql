{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('users') }}
select
    _airbyte_users_hashid,
    {{ json_extract_scalar('referral', ['code'], ['code']) }} as code,
    {{ json_extract_scalar('referral', ['enabled'], ['enabled']) }} as enabled,
    {{ json_extract_scalar('referral', ['enabledAt'], ['enabledAt']) }} as enabledat,
    {{ json_extract_scalar('referral', ['shareContent'], ['shareContent']) }} as sharecontent,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users') }} as table_alias
-- referral at users/referral
where 1 = 1
and referral is not null

