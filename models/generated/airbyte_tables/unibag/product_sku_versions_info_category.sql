{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('product_sku_versions_info_category_ab3') }}
select
    _airbyte_info_hashid,
    {{ adapter.quote('id') }},
    {{ adapter.quote('name') }},
    searchstring,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_category_hashid
from {{ ref('product_sku_versions_info_category_ab3') }}
-- category at product-sku-versions/info/category from {{ ref('product_sku_versions_info') }}
where 1 = 1

