{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('teams') }}
select
    _airbyte_teams_hashid,
    {{ json_extract_scalar(adapter.quote('level'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar(adapter.quote('level'), ['color'], ['color']) }} as color,
    {{ json_extract_scalar(adapter.quote('level'), ['level'], ['level']) }} as {{ adapter.quote('level') }},
    {{ json_extract_scalar(adapter.quote('level'), ['expiredAt'], ['expiredAt']) }} as expiredat,
    {{ json_extract_scalar(adapter.quote('level'), ['nextLevel'], ['nextLevel']) }} as nextlevel,
    {{ json_extract_scalar(adapter.quote('level'), ['bonusPercent'], ['bonusPercent']) }} as bonuspercent,
    {{ json_extract_scalar(adapter.quote('level'), ['maximumVipMember'], ['maximumVipMember']) }} as maximumvipmember,
    {{ json_extract_scalar(adapter.quote('level'), ['levelAtStartOfMonth'], ['levelAtStartOfMonth']) }} as levelatstartofmonth,
    {{ json_extract_scalar(adapter.quote('level'), ['maximumNumberMember'], ['maximumNumberMember']) }} as maximumnumbermember,
    {{ json_extract_scalar(adapter.quote('level'), ['maximumNumberViceLeader'], ['maximumNumberViceLeader']) }} as maximumnumberviceleader,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('teams') }} as table_alias
-- level at teams/level
where 1 = 1
and {{ adapter.quote('level') }} is not null

