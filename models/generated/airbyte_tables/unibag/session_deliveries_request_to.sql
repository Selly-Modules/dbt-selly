{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('session_deliveries_request_to_ab3') }}
select
    _airbyte_request_hashid,
    {{ adapter.quote('name') }},
    phone,
    {{ adapter.quote('location') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_to_hashid
from {{ ref('session_deliveries_request_to_ab3') }}
-- to at session-deliveries/request/to from {{ ref('session_deliveries_request') }}
where 1 = 1

