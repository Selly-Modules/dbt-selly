{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_referral_ab1') }}
select
    _airbyte_users_hashid,
    cast(code as {{ dbt_utils.type_string() }}) as code,
    {{ cast_to_boolean('enabled') }} as enabled,
    cast(enabledat as {{ dbt_utils.type_string() }}) as enabledat,
    cast(sharecontent as {{ dbt_utils.type_string() }}) as sharecontent,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users_referral_ab1') }}
-- referral at users/referral
where 1 = 1

