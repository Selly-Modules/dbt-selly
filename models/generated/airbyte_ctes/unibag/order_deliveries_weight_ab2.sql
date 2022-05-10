{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('order_deliveries_weight_ab1') }}
select
    _airbyte_order_deliveries_hashid,
    cast({{ adapter.quote('real') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('real') }},
    cast(sent as {{ dbt_utils.type_float() }}) as sent,
    cast(converted as {{ dbt_utils.type_float() }}) as converted,
    cast(multiplier as {{ dbt_utils.type_float() }}) as multiplier,
    cast(convertedwithmultiplier as {{ dbt_utils.type_float() }}) as convertedwithmultiplier,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('order_deliveries_weight_ab1') }}
-- weight at order-deliveries/weight
where 1 = 1

