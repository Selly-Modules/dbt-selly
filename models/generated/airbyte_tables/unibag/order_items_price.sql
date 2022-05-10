{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('order_items_price_ab3') }}
select
    _airbyte_order_items_hashid,
    base,
    sell,
    market,
    profit,
    volume,
    weight,
    maximum,
    minimum,
    profituni,
    supplierprice,
    membershippercent,
    membershipcommission,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_price_hashid
from {{ ref('order_items_price_ab3') }}
-- price at order-items/price from {{ ref('order_items') }}
where 1 = 1

