{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('team_histories_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast({{ adapter.quote('date') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('date') }},
    cast(team as {{ dbt_utils.type_string() }}) as team,
    cast({{ adapter.quote('level') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('level') }},
    cast(leader as {{ dbt_utils.type_string() }}) as leader,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(statistic as {{ dbt_utils.type_string() }}) as statistic,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('team_histories_ab1') }}
-- team_histories
where 1 = 1

