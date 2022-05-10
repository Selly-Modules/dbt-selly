{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('products_score_ab3') }}
select
    _airbyte_products_hashid,
    {{ adapter.quote('view') }},
    {{ adapter.quote('order') }},
    profit,
    {{ adapter.quote('current') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_score_hashid
from {{ ref('products_score_ab3') }}
-- score at products/score from {{ ref('products') }}
where 1 = 1

