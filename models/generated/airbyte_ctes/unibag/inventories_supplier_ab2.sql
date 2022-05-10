{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('inventories_supplier_ab1') }}
select
    _airbyte_inventories_hashid,
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('inventories_supplier_ab1') }}
-- supplier at inventories/supplier
where 1 = 1

