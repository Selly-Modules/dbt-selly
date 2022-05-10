{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('suppliers_location_ab1') }}
select
    _airbyte_suppliers_hashid,
    cast(ward as {{ dbt_utils.type_string() }}) as ward,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(district as {{ dbt_utils.type_string() }}) as district,
    cast({{ adapter.quote('location') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('location') }},
    cast(province as {{ dbt_utils.type_string() }}) as province,
    cast(fulladdress as {{ dbt_utils.type_string() }}) as fulladdress,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('suppliers_location_ab1') }}
-- location at suppliers/location
where 1 = 1

