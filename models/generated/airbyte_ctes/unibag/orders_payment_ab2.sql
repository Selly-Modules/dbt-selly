{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_payment_ab1') }}
select
    _airbyte_orders_hashid,
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast({{ adapter.quote('method') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('method') }},
    cast(status as {{ dbt_utils.type_string() }}) as status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_payment_ab1') }}
-- payment at orders/payment
where 1 = 1

