{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_facebook_ab1') }}
select
    _airbyte_users_hashid,
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(photo as {{ dbt_utils.type_string() }}) as photo,
    cast({{ adapter.quote('token') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('token') }},
    cast(gender as {{ dbt_utils.type_string() }}) as gender,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users_facebook_ab1') }}
-- facebook at users/facebook
where 1 = 1

