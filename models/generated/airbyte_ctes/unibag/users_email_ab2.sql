{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_email_ab1') }}
select
    _airbyte_users_hashid,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    {{ cast_to_boolean('verified') }} as verified,
    cast(verifiedat as {{ dbt_utils.type_string() }}) as verifiedat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users_email_ab1') }}
-- email at users/email
where 1 = 1

