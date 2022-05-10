{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('suppliers_statistic_ab1') }}
select
    _airbyte_suppliers_hashid,
    cast(salestotal as {{ dbt_utils.type_float() }}) as salestotal,
    cast(salespending as {{ dbt_utils.type_float() }}) as salespending,
    cast(salessuccess as {{ dbt_utils.type_float() }}) as salessuccess,
    cast(totalproduct as {{ dbt_utils.type_float() }}) as totalproduct,
    cast(salescancelled as {{ dbt_utils.type_float() }}) as salescancelled,
    cast(salesweektotal as {{ dbt_utils.type_float() }}) as salesweektotal,
    cast(salesyeartotal as {{ dbt_utils.type_float() }}) as salesyeartotal,
    cast(totalinventory as {{ dbt_utils.type_float() }}) as totalinventory,
    cast(salesmonthtotal as {{ dbt_utils.type_float() }}) as salesmonthtotal,
    cast(totalquantitysale as {{ dbt_utils.type_float() }}) as totalquantitysale,
    cast(salestwomonthtotal as {{ dbt_utils.type_float() }}) as salestwomonthtotal,
    cast(totalhasorderseller as {{ dbt_utils.type_float() }}) as totalhasorderseller,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('suppliers_statistic_ab1') }}
-- statistic at suppliers/statistic
where 1 = 1

