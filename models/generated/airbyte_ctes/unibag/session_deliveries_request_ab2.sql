{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('session_deliveries_request_ab1') }}
select
    _airbyte_session_deliveries_hashid,
    cast({{ adapter.quote('to') }} as {{ type_json() }}) as {{ adapter.quote('to') }},
    cast({{ adapter.quote('from') }} as {{ type_json() }}) as {{ adapter.quote('from') }},
    items,
    cast(checksum as {{ dbt_utils.type_string() }}) as checksum,
    cast(codamount as {{ dbt_utils.type_float() }}) as codamount,
    cast(ordercode as {{ dbt_utils.type_string() }}) as ordercode,
    cast(restockat as {{ dbt_utils.type_string() }}) as restockat,
    {{ cast_to_boolean('ispreorder') }} as ispreorder,
    cast(totalamount as {{ dbt_utils.type_float() }}) as totalamount,
    cast(paymentmethod as {{ dbt_utils.type_string() }}) as paymentmethod,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('session_deliveries_request_ab1') }}
-- request at session-deliveries/request
where 1 = 1

