{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('product_categories_statistic_ab1') }}
select
    _airbyte_product_categories_hashid,
    cast(salestotal as {{ dbt_utils.type_float() }}) as salestotal,
    cast(totalshare as {{ dbt_utils.type_float() }}) as totalshare,
    cast(salesweektotal as {{ dbt_utils.type_float() }}) as salesweektotal,
    cast(salesyeartotal as {{ dbt_utils.type_float() }}) as salesyeartotal,
    cast(salesmonthtotal as {{ dbt_utils.type_float() }}) as salesmonthtotal,
    cast(salestwomonthtotal as {{ dbt_utils.type_float() }}) as salestwomonthtotal,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('product_categories_statistic_ab1') }}
-- statistic at product-categories/statistic
where 1 = 1

