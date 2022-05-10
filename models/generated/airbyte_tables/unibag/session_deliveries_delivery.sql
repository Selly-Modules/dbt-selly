{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('session_deliveries_delivery_ab3') }}
select
    _airbyte_session_deliveries_hashid,
    _id,
    fee,
    {{ adapter.quote('desc') }},
    note,
    title,
    feeship,
    currency,
    sourceid,
    couriername,
    servicecode,
    servicename,
    deliverycode,
    maxdeliverydays,
    mindeliverydays,
    realshippingfee,
    estimatetimedelivery,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_delivery_hashid
from {{ ref('session_deliveries_delivery_ab3') }}
-- delivery at session-deliveries/delivery from {{ ref('session_deliveries') }}
where 1 = 1

