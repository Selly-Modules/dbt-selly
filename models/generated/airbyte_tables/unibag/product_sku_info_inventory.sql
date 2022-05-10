{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('product_sku_info_inventory_ab3') }}
select
    _airbyte_info_hashid,
    {{ adapter.quote('id') }},
    _id,
    {{ adapter.quote('name') }},
    {{ adapter.quote('location') }},
    searchstring,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_inventory_hashid
from {{ ref('product_sku_info_inventory_ab3') }}
-- inventory at product-sku/info/inventory from {{ ref('product_sku_info') }}
where 1 = 1

