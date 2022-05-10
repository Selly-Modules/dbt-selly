{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('product_sku_pricepercent_ab1') }}
select
    _airbyte_product_sku_hashid,
    cast(supplier as {{ dbt_utils.type_float() }}) as supplier,
    cast(minimumpricedifferential as {{ dbt_utils.type_float() }}) as minimumpricedifferential,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('product_sku_pricepercent_ab1') }}
-- pricepercent at product-sku/pricePercent
where 1 = 1

