{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('session_deliveries_request_ab3') }}
select
    _airbyte_session_deliveries_hashid,
    {{ adapter.quote('to') }},
    {{ adapter.quote('from') }},
    items,
    checksum,
    codamount,
    ordercode,
    restockat,
    ispreorder,
    totalamount,
    paymentmethod,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_request_hashid
from {{ ref('session_deliveries_request_ab3') }}
-- request at session-deliveries/request from {{ ref('session_deliveries') }}
where 1 = 1

