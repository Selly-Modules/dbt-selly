{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'hash'}],
    unique_key = '_airbyte_ab_id',
    schema = "unibag",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('suppliers_ab3') }}
select
    _id AS id,
    {{ adapter.quote('name') }},
    identifycode AS identify_code,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_suppliers_hashid
from {{ ref('suppliers_ab3') }}
-- suppliers from {{ source('unibag', '_airbyte_raw_suppliers') }}
where 1 = 1

