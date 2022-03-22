{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('team_activities_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(team as {{ dbt_utils.type_string() }}) as team,
    cast({{ adapter.quote('action') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('action') }},
    cast({{ adapter.quote('options') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('options') }},
    cast(targetid as {{ dbt_utils.type_string() }}) as targetid,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(createdby as {{ dbt_utils.type_string() }}) as createdby,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('team_activities_ab1') }}
-- team_activities
where 1 = 1

