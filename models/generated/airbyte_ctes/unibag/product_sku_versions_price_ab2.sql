{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('product_sku_versions_price_ab1') }}
select
    _airbyte_product_sku_versions_hashid,
    cast(base as {{ dbt_utils.type_float() }}) as base,
    cast(market as {{ dbt_utils.type_float() }}) as market,
    cast(maximum as {{ dbt_utils.type_float() }}) as maximum,
    cast(minimum as {{ dbt_utils.type_float() }}) as minimum,
    cast(supplier as {{ dbt_utils.type_float() }}) as supplier,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('product_sku_versions_price_ab1') }}
-- price at product-sku-versions/price
where 1 = 1

