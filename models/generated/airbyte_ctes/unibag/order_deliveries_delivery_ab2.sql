{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('order_deliveries_delivery_ab1') }}
select
    _airbyte_order_deliveries_hashid,
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(fee as {{ dbt_utils.type_float() }}) as fee,
    cast({{ adapter.quote('desc') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('desc') }},
    cast(note as {{ dbt_utils.type_string() }}) as note,
    cast(feeship as {{ type_json() }}) as feeship,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(couriername as {{ dbt_utils.type_string() }}) as couriername,
    cast(servicecode as {{ dbt_utils.type_string() }}) as servicecode,
    cast(servicename as {{ dbt_utils.type_string() }}) as servicename,
    cast(deliverycode as {{ dbt_utils.type_string() }}) as deliverycode,
    cast(maxdeliverydays as {{ dbt_utils.type_float() }}) as maxdeliverydays,
    cast(mindeliverydays as {{ dbt_utils.type_float() }}) as mindeliverydays,
    cast(estimatetimedelivery as {{ dbt_utils.type_string() }}) as estimatetimedelivery,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('order_deliveries_delivery_ab1') }}
-- delivery at order-deliveries/delivery
where 1 = 1

