{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('promotions_suppliercommission_ab3') }}
select
    _airbyte_promotions_hashid,
    {{ adapter.quote('type') }},
    {{ adapter.quote('value') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_suppliercommission_hashid
from {{ ref('promotions_suppliercommission_ab3') }}
-- suppliercommission at promotions/supplierCommission from {{ ref('promotions') }}
where 1 = 1

