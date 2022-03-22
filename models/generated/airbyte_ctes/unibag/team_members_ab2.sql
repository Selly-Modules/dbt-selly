{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('team_members_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast({{ adapter.quote('role') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('role') }},
    cast(team as {{ dbt_utils.type_string() }}) as team,
    cast({{ adapter.quote('user') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('user') }},
    {{ cast_to_boolean('isleft') }} as isleft,
    cast(leftat as {{ dbt_utils.type_string() }}) as leftat,
    cast(joinedat as {{ dbt_utils.type_string() }}) as joinedat,
    cast(rolecode as {{ dbt_utils.type_float() }}) as rolecode,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(statistic as {{ dbt_utils.type_string() }}) as statistic,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(isremovedby as {{ dbt_utils.type_string() }}) as isremovedby,
    cast(firstorderat as {{ dbt_utils.type_string() }}) as firstorderat,
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    {{ cast_to_boolean('ismemberhomegrown') }} as ismemberhomegrown,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('team_members_ab1') }}
-- team_members
where 1 = 1

