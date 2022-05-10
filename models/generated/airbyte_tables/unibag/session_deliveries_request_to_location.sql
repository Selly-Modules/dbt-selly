{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('session_deliveries_request_to_location_ab3') }}
select
    _airbyte_to_hashid,
    address,
    wardcode,
    districtcode,
    provincecode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_location_hashid
from {{ ref('session_deliveries_request_to_location_ab3') }}
-- location at session-deliveries/request/to/location from {{ ref('session_deliveries_request_to') }}
where 1 = 1

