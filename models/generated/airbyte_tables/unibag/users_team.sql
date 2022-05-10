{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('users_team_ab3') }}
select
    _airbyte_users_hashid,
    _id,
    {{ adapter.quote('name') }},
    {{ adapter.quote('role') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_team_hashid
from {{ ref('users_team_ab3') }}
-- team at users/team from {{ ref('users') }}
where 1 = 1

