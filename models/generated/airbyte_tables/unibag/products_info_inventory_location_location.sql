{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('products_info_inventory_location_location_ab3') }}
select
    _airbyte_location_hashid,
    {{ adapter.quote('type') }},
    coordinates,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_location_5_hashid
from {{ ref('products_info_inventory_location_location_ab3') }}
-- location at products/info/inventory/location/location from {{ ref('products_info_inventory_location') }}
where 1 = 1

