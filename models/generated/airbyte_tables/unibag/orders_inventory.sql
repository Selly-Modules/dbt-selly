{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_inventory_ab3') }}
select
    _airbyte_orders_hashid,
    {{ adapter.quote('id') }},
    _id,
    {{ adapter.quote('name') }},
    canissueinvoice,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_inventory_hashid
from {{ ref('orders_inventory_ab3') }}
-- inventory at orders/inventory from {{ ref('orders') }}
where 1 = 1

