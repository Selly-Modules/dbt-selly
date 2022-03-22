{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('team_activities_ab3') }}
select
    _id AS id,
    {{ adapter.quote('action') }},
    team AS team_id,
    targetid AS team_member_id,
    createdat::timestamp AS created_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_team_activities_hashid
from {{ ref('team_activities_ab3') }}
-- team_activities from {{ source('unibag', '_airbyte_raw_team_activities') }}
where 1 = 1

