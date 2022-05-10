{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('product_sku_versions_statistic_ab1') }}
select
    _airbyte_product_sku_versions_hashid,
    cast(saletotal as {{ dbt_utils.type_float() }}) as saletotal,
    cast(salepending as {{ dbt_utils.type_float() }}) as salepending,
    cast(salewaiting as {{ dbt_utils.type_float() }}) as salewaiting,
    cast(salecashback as {{ dbt_utils.type_float() }}) as salecashback,
    cast(salecancelled as {{ dbt_utils.type_float() }}) as salecancelled,
    cast(saledelivered as {{ dbt_utils.type_float() }}) as saledelivered,
    cast(saledelivering as {{ dbt_utils.type_float() }}) as saledelivering,
    cast(salepaymentprocessing as {{ dbt_utils.type_float() }}) as salepaymentprocessing,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('product_sku_versions_statistic_ab1') }}
-- statistic at product-sku-versions/statistic
where 1 = 1

