{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('products_info_inventory_ab1') }}
select
    _airbyte_info_hashid,
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('id') }},
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast({{ adapter.quote('location') }} as {{ type_json() }}) as {{ adapter.quote('location') }},
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('products_info_inventory_ab1') }}
-- inventory at products/info/inventory
where 1 = 1

