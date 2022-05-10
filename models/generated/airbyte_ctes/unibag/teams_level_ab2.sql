{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('teams_level_ab1') }}
select
    _airbyte_teams_hashid,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(color as {{ dbt_utils.type_string() }}) as color,
    cast({{ adapter.quote('level') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('level') }},
    cast(expiredat as {{ dbt_utils.type_string() }}) as expiredat,
    cast(nextlevel as {{ dbt_utils.type_float() }}) as nextlevel,
    cast(bonuspercent as {{ dbt_utils.type_float() }}) as bonuspercent,
    cast(maximumvipmember as {{ dbt_utils.type_float() }}) as maximumvipmember,
    cast(levelatstartofmonth as {{ dbt_utils.type_float() }}) as levelatstartofmonth,
    cast(maximumnumbermember as {{ dbt_utils.type_float() }}) as maximumnumbermember,
    cast(maximumnumberviceleader as {{ dbt_utils.type_float() }}) as maximumnumberviceleader,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('teams_level_ab1') }}
-- level at teams/level
where 1 = 1

