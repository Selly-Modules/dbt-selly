{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('suppliers_logo_ab3') }}
select
    _airbyte_suppliers_hashid,
    _id,
    {{ adapter.quote('name') }},
    dimensions,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_logo_hashid
from {{ ref('suppliers_logo_ab3') }}
-- logo at suppliers/logo from {{ ref('suppliers') }}
where 1 = 1

