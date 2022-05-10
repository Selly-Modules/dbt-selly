{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_zalo_ab1') }}
select
    _airbyte_users_hashid,
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(photo as {{ dbt_utils.type_string() }}) as photo,
    cast({{ adapter.quote('token') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('token') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users_zalo_ab1') }}
-- zalo at users/zalo
where 1 = 1

