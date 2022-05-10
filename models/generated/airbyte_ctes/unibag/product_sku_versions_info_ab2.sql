{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('product_sku_versions_info_ab1') }}
select
    _airbyte_product_sku_versions_hashid,
    cast(weight as {{ dbt_utils.type_float() }}) as weight,
    cast(category as {{ type_json() }}) as category,
    cast(supplier as {{ type_json() }}) as supplier,
    cast(dimension as {{ dbt_utils.type_string() }}) as dimension,
    cast(inventory as {{ type_json() }}) as inventory,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('product_sku_versions_info_ab1') }}
-- info at product-sku-versions/info
where 1 = 1

