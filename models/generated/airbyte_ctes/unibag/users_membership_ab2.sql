{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_membership_ab1') }}
select
    _airbyte_users_hashid,
    cast(expireat as {{ dbt_utils.type_string() }}) as expireat,
    cast(nextlevel as {{ dbt_utils.type_float() }}) as nextlevel,
    cast(currentlevel as {{ dbt_utils.type_float() }}) as currentlevel,
    cast(currenttransactioncount as {{ dbt_utils.type_float() }}) as currenttransactioncount,
    cast(currentsales_aibyte_transform as {{ dbt_utils.type_string() }}) as currentsales_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users_membership_ab1') }}
-- membership at users/membership
where 1 = 1

