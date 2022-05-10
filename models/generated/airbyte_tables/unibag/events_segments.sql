{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('events_segments_ab3') }}
select
    _airbyte_events_hashid,
    segments,
    usersegment,
    lastmonthsales,
    highestmonthlysales,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_segments_hashid
from {{ ref('events_segments_ab3') }}
-- segments at events/segments from {{ ref('events') }}
where 1 = 1

