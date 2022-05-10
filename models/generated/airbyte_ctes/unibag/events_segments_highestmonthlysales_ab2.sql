{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('events_segments_highestmonthlysales_ab1') }}
select
    _airbyte_segments_hashid,
    cast({{ adapter.quote('to') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('to') }},
    cast({{ adapter.quote('from') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('from') }},
    {{ cast_to_boolean('active') }} as active,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('events_segments_highestmonthlysales_ab1') }}
-- highestmonthlysales at events/segments/highestMonthlySales
where 1 = 1

