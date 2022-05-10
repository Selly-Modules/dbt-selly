{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('session_deliveries_location_ab1') }}
select
    _airbyte_session_deliveries_hashid,
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(ward as {{ dbt_utils.type_float() }}) as ward,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(district as {{ dbt_utils.type_float() }}) as district,
    cast(province as {{ dbt_utils.type_float() }}) as province,
    cast(fulladdress as {{ dbt_utils.type_string() }}) as fulladdress,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('session_deliveries_location_ab1') }}
-- location at session-deliveries/location
where 1 = 1

