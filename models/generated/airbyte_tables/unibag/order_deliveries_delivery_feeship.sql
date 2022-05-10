{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('order_deliveries_delivery_feeship_ab3') }}
select
    _airbyte_delivery_hashid,
    cod,
    total,
    shipping,
    insurance,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_feeship_hashid
from {{ ref('order_deliveries_delivery_feeship_ab3') }}
-- feeship at order-deliveries/delivery/feeShip from {{ ref('order_deliveries_delivery') }}
where 1 = 1

