{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('order_deliveries_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(code as {{ dbt_utils.type_string() }}) as code,
    cast({{ adapter.quote('order') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('order') }},
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(weight as {{ type_json() }}) as weight,
    cast(service as {{ dbt_utils.type_string() }}) as service,
    cast(customer as {{ type_json() }}) as customer,
    cast(delivery as {{ type_json() }}) as delivery,
    cast({{ adapter.quote('location') }} as {{ type_json() }}) as {{ adapter.quote('location') }},
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(promotion as {{ type_json() }}) as promotion,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(trackingcode as {{ dbt_utils.type_string() }}) as trackingcode,
    cast(trackingtime as {{ type_json() }}) as trackingtime,
    {{ cast_to_boolean('isadminchange') }} as isadminchange,
    cast(trackingordercode as {{ dbt_utils.type_string() }}) as trackingordercode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('order_deliveries_ab1') }}
-- order_deliveries
where 1 = 1

