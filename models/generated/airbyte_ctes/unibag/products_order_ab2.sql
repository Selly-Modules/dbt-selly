{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('products_order_ab1') }}
select
    _airbyte_products_hashid,
    cast(newest as {{ dbt_utils.type_float() }}) as newest,
    cast(profit as {{ dbt_utils.type_float() }}) as profit,
    cast(topsale as {{ dbt_utils.type_float() }}) as topsale,
    cast(scoreyesterday as {{ dbt_utils.type_float() }}) as scoreyesterday,
    cast(region_aibyte_transform as {{ dbt_utils.type_string() }}) as region_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('products_order_ab1') }}
-- order at products/order
where 1 = 1

