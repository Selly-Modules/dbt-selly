{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('team_activities_options_ab3') }}
select
    _airbyte_team_activities_hashid,
    {{ adapter.quote('name') }},
    {{ adapter.quote('role') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_options_hashid
from {{ ref('team_activities_options_ab3') }}
-- options at team-activities/options from {{ ref('team_activities') }}
where 1 = 1

