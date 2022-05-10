{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('order_items_sku_ab3') }}
select
    _airbyte_order_items_hashid,
    _id,
    sku,
    {{ adapter.quote('name') }},
    {{ adapter.quote('type') }},
    {{ adapter.quote('source') }},
    picture,
    {{ adapter.quote('version') }},
    properties,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sku_hashid
from {{ ref('order_items_sku_ab3') }}
-- sku at order-items/sku from {{ ref('order_items') }}
where 1 = 1

