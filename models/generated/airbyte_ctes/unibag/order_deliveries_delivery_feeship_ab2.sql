{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('order_deliveries_delivery_feeship_ab1') }}
select
    _airbyte_delivery_hashid,
    cast(cod as {{ dbt_utils.type_float() }}) as cod,
    cast(total as {{ dbt_utils.type_float() }}) as total,
    cast(shipping as {{ dbt_utils.type_float() }}) as shipping,
    cast(insurance as {{ dbt_utils.type_float() }}) as insurance,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('order_deliveries_delivery_feeship_ab1') }}
-- feeship at order-deliveries/delivery/feeShip
where 1 = 1

