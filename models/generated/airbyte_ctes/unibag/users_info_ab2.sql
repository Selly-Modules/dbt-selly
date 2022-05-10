{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_info_ab1') }}
select
    _airbyte_users_hashid,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(gender as {{ dbt_utils.type_string() }}) as gender,
    cast(citycode as {{ dbt_utils.type_float() }}) as citycode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users_info_ab1') }}
-- info at users/info
where 1 = 1

