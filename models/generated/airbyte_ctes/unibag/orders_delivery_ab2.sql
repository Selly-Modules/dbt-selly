{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('orders_delivery_ab1') }}
select
    _airbyte_orders_hashid,
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(fee as {{ dbt_utils.type_float() }}) as fee,
    cast(code as {{ dbt_utils.type_string() }}) as code,
    cast(note as {{ dbt_utils.type_string() }}) as note,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(weight as {{ type_json() }}) as weight,
    cast(feeship as {{ type_json() }}) as feeship,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    {{ cast_to_boolean('freeship') }} as freeship,
    cast({{ adapter.quote('location') }} as {{ type_json() }}) as {{ adapter.quote('location') }},
    cast(sourceid as {{ dbt_utils.type_float() }}) as sourceid,
    cast(couriername as {{ dbt_utils.type_string() }}) as couriername,
    cast(servicecode as {{ dbt_utils.type_string() }}) as servicecode,
    cast(servicename as {{ dbt_utils.type_string() }}) as servicename,
    cast(customername as {{ dbt_utils.type_string() }}) as customername,
    cast(customerphone as {{ dbt_utils.type_string() }}) as customerphone,
    cast(discountvalue as {{ dbt_utils.type_float() }}) as discountvalue,
    cast(servicedelivery as {{ dbt_utils.type_string() }}) as servicedelivery,
    cast(estimatedeliveryat as {{ dbt_utils.type_string() }}) as estimatedeliveryat,
    cast(estimatetimedelivery as {{ dbt_utils.type_string() }}) as estimatetimedelivery,
    cast(maxdeliveryday_aibyte_transform as {{ dbt_utils.type_string() }}) as maxdeliveryday_aibyte_transform,
    cast(mindeliveryday_aibyte_transform as {{ dbt_utils.type_string() }}) as mindeliveryday_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('orders_delivery_ab1') }}
-- delivery at orders/delivery
where 1 = 1

