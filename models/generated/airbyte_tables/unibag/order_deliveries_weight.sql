{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('order_deliveries_weight_ab3') }}
select
    _airbyte_order_deliveries_hashid,
    {{ adapter.quote('real') }},
    sent,
    converted,
    multiplier,
    convertedwithmultiplier,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_weight_hashid
from {{ ref('order_deliveries_weight_ab3') }}
-- weight at order-deliveries/weight from {{ ref('order_deliveries') }}
where 1 = 1

