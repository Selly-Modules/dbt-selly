{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('teams_ab3') }}
select
    _id AS id,
    {{ adapter.quote('name') }},
    active,
    adminuser AS admin_id,
    citycode AS province_code,
    cast({{ adapter.quote('level') }}::json->>'level' AS numeric) AS current_level_value,
    {{ adapter.quote('level') }}::json->>'name' AS current_level_name,
    cast(level::json->>'expiredAt' AS timestamp) AS current_level_expired_at,
    cast({{ adapter.quote('level') }}::json->>'bonusPercent' AS numeric) AS bonus_percent,
    cast({{ adapter.quote('level') }}::json->>'maximumNumberMember' AS numeric) AS stats_max_member,
    cast({{ adapter.quote('statistic') }}::json->>'memberTotal' AS numeric) AS stats_current_member,
    createdat::timestamp AS created_at,
    updatedat::timestamp AS updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_teams_hashid
from {{ ref('teams_ab3') }}
-- teams from {{ source('unibag', '_airbyte_raw_teams') }}
where 1 = 1

