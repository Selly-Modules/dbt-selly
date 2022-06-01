{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('team_histories_ab3') }}
select
    _id,
    team AS team_id,
    leader AS leader_id,
    status,
    {{ adapter.quote('date') }}::timestamp,
    {{ adapter.quote('level') }}::jsonb,
    statistic::jsonb,
    createdat::timestamp AS created_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_team_histories_hashid
from {{ ref('team_histories_ab3') }}
-- team_histories from {{ source('unibag', '_airbyte_raw_team_histories') }}
where 1 = 1

