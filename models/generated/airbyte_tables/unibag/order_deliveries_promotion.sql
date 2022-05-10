{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('order_deliveries_promotion_ab3') }}
select
    _airbyte_order_deliveries_hashid,
    {{ adapter.quote('type') }},
    discount,
    isapplied,
    minordervalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_promotion_hashid
from {{ ref('order_deliveries_promotion_ab3') }}
-- promotion at order-deliveries/promotion from {{ ref('order_deliveries') }}
where 1 = 1

