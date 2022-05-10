{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('order_deliveries_customer_ab3') }}
select
    _airbyte_order_deliveries_hashid,
    _id,
    {{ adapter.quote('name') }},
    phone,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_customer_hashid
from {{ ref('order_deliveries_customer_ab3') }}
-- customer at order-deliveries/customer from {{ ref('order_deliveries') }}
where 1 = 1

