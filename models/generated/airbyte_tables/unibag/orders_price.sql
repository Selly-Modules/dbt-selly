{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_price_ab3') }}
select
    _airbyte_orders_hashid,
    sell,
    total,
    market,
    weight,
    maximum,
    minimum,
    profituni,
    promotion,
    supplierprice,
    wholesalebonus,
    membershippercent,
    membershipcommission,
    base_aibyte_transform,
    profit_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_price_hashid
from {{ ref('orders_price_ab3') }}
-- price at orders/price from {{ ref('orders') }}
where 1 = 1

