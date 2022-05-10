{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('promotions_applyfor_ab3') }}
select
    _airbyte_promotions_hashid,
    list,
    {{ adapter.quote('type') }},
    provinces,
    isapplyallorder,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_applyfor_hashid
from {{ ref('promotions_applyfor_ab3') }}
-- applyfor at promotions/applyFor from {{ ref('promotions') }}
where 1 = 1

