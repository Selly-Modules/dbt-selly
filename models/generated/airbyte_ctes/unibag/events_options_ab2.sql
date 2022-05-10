{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('events_options_ab1') }}
select
    _airbyte_events_hashid,
    cast(cash as {{ dbt_utils.type_float() }}) as cash,
    cast({{ adapter.quote('percent') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('percent') }},
    cast(validindays as {{ dbt_utils.type_float() }}) as validindays,
    cast(minordervalue as {{ dbt_utils.type_float() }}) as minordervalue,
    cast(minordertoclaim as {{ dbt_utils.type_float() }}) as minordertoclaim,
    cast(usercreatedbeforedate as {{ dbt_utils.type_string() }}) as usercreatedbeforedate,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('events_options_ab1') }}
-- options at events/options
where 1 = 1

