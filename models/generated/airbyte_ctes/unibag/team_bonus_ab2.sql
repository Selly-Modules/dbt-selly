{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('team_bonus_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(team as {{ dbt_utils.type_string() }}) as team,
    cast({{ adapter.quote('user') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('user') }},
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast({{ adapter.quote('percent') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('percent') }},
    cast(targetid as {{ dbt_utils.type_string() }}) as targetid,
    cast(teamname as {{ dbt_utils.type_string() }}) as teamname,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(teamlevel as {{ dbt_utils.type_float() }}) as teamlevel,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(commission as {{ dbt_utils.type_float() }}) as commission,
    cast(teammember as {{ dbt_utils.type_string() }}) as teammember,
    cast(teampromotion as {{ dbt_utils.type_string() }}) as teampromotion,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('team_bonus_ab1') }}
-- team_bonus
where 1 = 1

