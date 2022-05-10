{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('promotion_orders_supplier_ab3') }}
select
    _airbyte_promotion_orders_hashid,
    _id,
    {{ adapter.quote('name') }},
    searchstring,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_supplier_hashid
from {{ ref('promotion_orders_supplier_ab3') }}
-- supplier at promotion-orders/supplier from {{ ref('promotion_orders') }}
where 1 = 1

