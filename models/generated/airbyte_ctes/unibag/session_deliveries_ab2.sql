{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('session_deliveries_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(cart as {{ dbt_utils.type_string() }}) as cart,
    cast(note as {{ dbt_utils.type_string() }}) as note,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(request as {{ type_json() }}) as request,
    cast(service as {{ dbt_utils.type_string() }}) as service,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(customer as {{ type_json() }}) as customer,
    cast(delivery as {{ type_json() }}) as delivery,
    cast({{ adapter.quote('location') }} as {{ type_json() }}) as {{ adapter.quote('location') }},
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(promotion as {{ type_json() }}) as promotion,
    cast(sessionorder as {{ dbt_utils.type_string() }}) as sessionorder,
    cast(paymentmethod as {{ dbt_utils.type_string() }}) as paymentmethod,
    cast(estimatetimedelivery as {{ dbt_utils.type_string() }}) as estimatetimedelivery,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('session_deliveries_ab1') }}
-- session_deliveries
where 1 = 1

