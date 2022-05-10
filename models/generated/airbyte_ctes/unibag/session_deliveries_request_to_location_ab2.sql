{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('session_deliveries_request_to_location_ab1') }}
select
    _airbyte_to_hashid,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(wardcode as {{ dbt_utils.type_float() }}) as wardcode,
    cast(districtcode as {{ dbt_utils.type_float() }}) as districtcode,
    cast(provincecode as {{ dbt_utils.type_float() }}) as provincecode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('session_deliveries_request_to_location_ab1') }}
-- location at session-deliveries/request/to/location
where 1 = 1

