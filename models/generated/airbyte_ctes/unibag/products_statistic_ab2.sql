{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('products_statistic_ab1') }}
select
    _airbyte_products_hashid,
    cast({{ adapter.quote('view') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('view') }},
    cast(skutotal as {{ dbt_utils.type_float() }}) as skutotal,
    cast(saletotal as {{ dbt_utils.type_float() }}) as saletotal,
    cast(skuactive as {{ dbt_utils.type_float() }}) as skuactive,
    cast(totalpost as {{ dbt_utils.type_float() }}) as totalpost,
    cast(salestotal as {{ dbt_utils.type_float() }}) as salestotal,
    cast(salepending as {{ dbt_utils.type_float() }}) as salepending,
    cast(salewaiting as {{ dbt_utils.type_float() }}) as salewaiting,
    cast(salecashback as {{ dbt_utils.type_float() }}) as salecashback,
    cast(salecancelled as {{ dbt_utils.type_float() }}) as salecancelled,
    cast(saledelivered as {{ dbt_utils.type_float() }}) as saledelivered,
    cast(saleweektotal as {{ dbt_utils.type_float() }}) as saleweektotal,
    cast(saleyeartotal as {{ dbt_utils.type_float() }}) as saleyeartotal,
    cast(saledelivering as {{ dbt_utils.type_float() }}) as saledelivering,
    cast(salemonthtotal as {{ dbt_utils.type_float() }}) as salemonthtotal,
    cast(salesweektotal as {{ dbt_utils.type_float() }}) as salesweektotal,
    cast(salesyeartotal as {{ dbt_utils.type_float() }}) as salesyeartotal,
    cast(salesmonthtotal as {{ dbt_utils.type_float() }}) as salesmonthtotal,
    cast(saletwomonthtotal as {{ dbt_utils.type_float() }}) as saletwomonthtotal,
    cast(salestwomonthtotal as {{ dbt_utils.type_float() }}) as salestwomonthtotal,
    cast(salepaymentprocessing as {{ dbt_utils.type_float() }}) as salepaymentprocessing,
    cast(totalinventory_aibyte_transform as {{ dbt_utils.type_string() }}) as totalinventory_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('products_statistic_ab1') }}
-- statistic at products/statistic
where 1 = 1

