{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('events_options_ab3') }}
select
    _airbyte_events_hashid,
    cash,
    {{ adapter.quote('percent') }},
    validindays,
    minordervalue,
    minordertoclaim,
    usercreatedbeforedate,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_options_hashid
from {{ ref('events_options_ab3') }}
-- options at events/options from {{ ref('events') }}
where 1 = 1

