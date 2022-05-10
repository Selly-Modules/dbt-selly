{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_delivery_ab3') }}
select
    _airbyte_orders_hashid,
    _id,
    fee,
    code,
    note,
    title,
    status,
    weight,
    feeship,
    currency,
    freeship,
    {{ adapter.quote('location') }},
    sourceid,
    couriername,
    servicecode,
    servicename,
    customername,
    customerphone,
    discountvalue,
    servicedelivery,
    estimatedeliveryat,
    estimatetimedelivery,
    maxdeliveryday_aibyte_transform,
    mindeliveryday_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_delivery_hashid
from {{ ref('orders_delivery_ab3') }}
-- delivery at orders/delivery from {{ ref('orders') }}
where 1 = 1

