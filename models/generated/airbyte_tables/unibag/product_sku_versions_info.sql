{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('product_sku_versions_info_ab3') }}
select
    _airbyte_product_sku_versions_hashid,
    weight,
    category,
    supplier,
    dimension,
    inventory,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_info_hashid
from {{ ref('product_sku_versions_info_ab3') }}
-- info at product-sku-versions/info from {{ ref('product_sku_versions') }}
where 1 = 1

