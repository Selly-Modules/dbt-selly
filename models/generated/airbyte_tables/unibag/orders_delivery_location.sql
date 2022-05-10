{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_delivery_location_ab3') }}
select
    _airbyte_delivery_hashid,
    _id,
    ward,
    address,
    district,
    province,
    fulladdress,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_location_hashid
from {{ ref('orders_delivery_location_ab3') }}
-- location at orders/delivery/location from {{ ref('orders_delivery') }}
where 1 = 1

