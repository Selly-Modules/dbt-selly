{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('events_segments_lastmonthsales_ab3') }}
select
    _airbyte_segments_hashid,
    {{ adapter.quote('to') }},
    {{ adapter.quote('from') }},
    active,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_lastmonthsales_hashid
from {{ ref('events_segments_lastmonthsales_ab3') }}
-- lastmonthsales at events/segments/lastMonthSales from {{ ref('events_segments') }}
where 1 = 1

