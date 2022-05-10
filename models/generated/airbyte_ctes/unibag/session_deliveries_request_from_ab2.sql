{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('session_deliveries_request_from_ab1') }}
select
    _airbyte_request_hashid,
    cast(userid as {{ dbt_utils.type_string() }}) as userid,
    cast(warehouseid as {{ dbt_utils.type_string() }}) as warehouseid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('session_deliveries_request_from_ab1') }}
-- from at session-deliveries/request/from
where 1 = 1

