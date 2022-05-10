{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('order_deliveries_delivery_ab3') }}
select
    _airbyte_order_deliveries_hashid,
    _id,
    fee,
    {{ adapter.quote('desc') }},
    note,
    feeship,
    currency,
    couriername,
    servicecode,
    servicename,
    deliverycode,
    maxdeliverydays,
    mindeliverydays,
    estimatetimedelivery,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_delivery_hashid
from {{ ref('order_deliveries_delivery_ab3') }}
-- delivery at order-deliveries/delivery from {{ ref('order_deliveries') }}
where 1 = 1

