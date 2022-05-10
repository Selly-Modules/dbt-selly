{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('suppliers_location_ab3') }}
select
    _airbyte_suppliers_hashid,
    ward,
    address,
    district,
    {{ adapter.quote('location') }},
    province,
    fulladdress,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_location_hashid
from {{ ref('suppliers_location_ab3') }}
-- location at suppliers/location from {{ ref('suppliers') }}
where 1 = 1

