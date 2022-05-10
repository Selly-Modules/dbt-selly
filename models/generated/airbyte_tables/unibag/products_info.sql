{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('products_info_ab3') }}
select
    _airbyte_products_hashid,
    profit,
    category,
    supplier,
    inventory,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_info_hashid
from {{ ref('products_info_ab3') }}
-- info at products/info from {{ ref('products') }}
where 1 = 1

