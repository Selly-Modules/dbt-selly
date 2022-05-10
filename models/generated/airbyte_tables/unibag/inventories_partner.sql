{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('inventories_partner_ab3') }}
select
    _airbyte_inventories_hashid,
    code,
    identitycode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_partner_hashid
from {{ ref('inventories_partner_ab3') }}
-- partner at inventories/partner from {{ ref('inventories') }}
where 1 = 1

