{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_payment_ab3') }}
select
    _airbyte_orders_hashid,
    _id,
    {{ adapter.quote('method') }},
    status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_payment_hashid
from {{ ref('orders_payment_ab3') }}
-- payment at orders/payment from {{ ref('orders') }}
where 1 = 1

