{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('product_categories_icon_ab3') }}
select
    _airbyte_product_categories_hashid,
    _id,
    {{ adapter.quote('name') }},
    dimensions,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_icon_hashid
from {{ ref('product_categories_icon_ab3') }}
-- icon at product-categories/icon from {{ ref('product_categories') }}
where 1 = 1

