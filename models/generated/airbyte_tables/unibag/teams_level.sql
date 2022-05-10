{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('teams_level_ab3') }}
select
    _airbyte_teams_hashid,
    {{ adapter.quote('name') }},
    color,
    {{ adapter.quote('level') }},
    expiredat,
    nextlevel,
    bonuspercent,
    maximumvipmember,
    levelatstartofmonth,
    maximumnumbermember,
    maximumnumberviceleader,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_level_hashid
from {{ ref('teams_level_ab3') }}
-- level at teams/level from {{ ref('teams') }}
where 1 = 1

