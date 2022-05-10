{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('session_deliveries_request_from_ab3') }}
select
    _airbyte_request_hashid,
    userid,
    warehouseid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_from_hashid
from {{ ref('session_deliveries_request_from_ab3') }}
-- from at session-deliveries/request/from from {{ ref('session_deliveries_request') }}
where 1 = 1

