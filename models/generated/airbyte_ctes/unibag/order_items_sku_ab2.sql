{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('order_items_sku_ab1') }}
select
    _airbyte_order_items_hashid,
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(sku as {{ dbt_utils.type_string() }}) as sku,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    cast({{ adapter.quote('source') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('source') }},
    cast(picture as {{ dbt_utils.type_string() }}) as picture,
    cast({{ adapter.quote('version') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('version') }},
    properties,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('order_items_sku_ab1') }}
-- sku at order-items/sku
where 1 = 1

