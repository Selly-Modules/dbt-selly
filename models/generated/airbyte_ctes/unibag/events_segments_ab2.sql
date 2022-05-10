{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('events_segments_ab1') }}
select
    _airbyte_events_hashid,
    segments,
    cast(usersegment as {{ dbt_utils.type_string() }}) as usersegment,
    cast(lastmonthsales as {{ type_json() }}) as lastmonthsales,
    cast(highestmonthlysales as {{ type_json() }}) as highestmonthlysales,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('events_segments_ab1') }}
-- segments at events/segments
where 1 = 1

