{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('session_deliveries_request_to_ab1') }}
select
    _airbyte_request_hashid,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast({{ adapter.quote('location') }} as {{ type_json() }}) as {{ adapter.quote('location') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('session_deliveries_request_to_ab1') }}
-- to at session-deliveries/request/to
where 1 = 1

