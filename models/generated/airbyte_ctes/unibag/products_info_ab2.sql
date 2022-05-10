{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('products_info_ab1') }}
select
    _airbyte_products_hashid,
    cast(profit as {{ dbt_utils.type_float() }}) as profit,
    cast(category as {{ type_json() }}) as category,
    cast(supplier as {{ type_json() }}) as supplier,
    cast(inventory as {{ type_json() }}) as inventory,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('products_info_ab1') }}
-- info at products/info
where 1 = 1

