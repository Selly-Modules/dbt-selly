{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('promotion_orders_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast({{ adapter.quote('user') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('user') }},
    cast({{ adapter.quote('order') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('order') }},
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(supplier as {{ dbt_utils.type_string() }}) as supplier,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(promotion as {{ dbt_utils.type_string() }}) as promotion,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(cashbackat as {{ dbt_utils.type_string() }}) as cashbackat,
    cast(commission as {{ dbt_utils.type_float() }}) as commission,
    {{ cast_to_boolean('isrejected') }} as isrejected,
    cast(quantitypromotion as {{ dbt_utils.type_float() }}) as quantitypromotion,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('promotion_orders_ab1') }}
-- promotion_orders
where 1 = 1

