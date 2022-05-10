{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('events_notice_ab3') }}
select
    _airbyte_events_hashid,
    {{ adapter.quote('label') }},
    {{ adapter.quote('value') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_notice_hashid
from {{ ref('events_notice_ab3') }}
-- notice at events/notice from {{ ref('events') }}
where 1 = 1

