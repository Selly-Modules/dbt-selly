{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('teams_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(code as {{ dbt_utils.type_string() }}) as code,
    cast({{ adapter.quote('desc') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('desc') }},
    cast(logo as {{ dbt_utils.type_string() }}) as logo,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast({{ adapter.quote('level') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('level') }},
    {{ cast_to_boolean('active') }} as active,
    {{ cast_to_boolean('isfull') }} as isfull,
    cast(citycode as {{ dbt_utils.type_float() }}) as citycode,
    cast(adminuser as {{ dbt_utils.type_string() }}) as adminuser,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(statistic as {{ dbt_utils.type_string() }}) as statistic,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(invitelink as {{ dbt_utils.type_string() }}) as invitelink,
    cast(information as {{ dbt_utils.type_string() }}) as information,
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    cast(inactivereason as {{ dbt_utils.type_string() }}) as inactivereason,
    cast(changingnamecount as {{ dbt_utils.type_float() }}) as changingnamecount,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('teams_ab1') }}
-- teams
where 1 = 1

