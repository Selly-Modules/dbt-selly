{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_inventory_ab1') }}
select
    _airbyte_orders_hashid,
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('id') }},
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    {{ cast_to_boolean('canissueinvoice') }} as canissueinvoice,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_inventory_ab1') }}
-- inventory at orders/inventory
where 1 = 1

