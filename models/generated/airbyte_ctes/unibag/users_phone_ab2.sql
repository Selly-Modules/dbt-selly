{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_phone_ab1') }}
select
    _airbyte_users_hashid,
    cast({{ adapter.quote('full') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('full') }},
    cast({{ adapter.quote('number') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('number') }},
    {{ cast_to_boolean('verified') }} as verified,
    cast(verifiedat as {{ dbt_utils.type_string() }}) as verifiedat,
    cast(countrycode as {{ dbt_utils.type_string() }}) as countrycode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users_phone_ab1') }}
-- phone at users/phone
where 1 = 1

