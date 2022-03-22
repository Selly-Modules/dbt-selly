{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('team_bonus_ab3') }}
select
    _id,
    team AS team_id,
    {{ adapter.quote('user') }} AS seller_id,
    status,
    cast({{ adapter.quote('percent') }} AS numeric) AS percent,
    cast({{ adapter.quote('commission') }} AS numeric) AS commission,
    teammember AS team_member,
    teampromotion AS team_promotion,
    targetid AS target_id,
    teamname AS team_name,
    cast(teamlevel AS integer) AS team_level,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_team_bonus_hashid
from {{ ref('team_bonus_ab3') }}
-- team_bonus from {{ source('unibag', '_airbyte_raw_team_bonus') }}
where 1 = 1

