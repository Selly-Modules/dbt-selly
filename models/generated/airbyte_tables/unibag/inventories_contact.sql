{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('inventories_contact_ab3') }}
select
    _airbyte_inventories_hashid,
    {{ adapter.quote('name') }},
    email,
    phone,
    address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_contact_hashid
from {{ ref('inventories_contact_ab3') }}
-- contact at inventories/contact from {{ ref('inventories') }}
where 1 = 1

