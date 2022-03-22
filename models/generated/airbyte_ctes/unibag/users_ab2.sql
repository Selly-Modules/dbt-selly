{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(code as {{ dbt_utils.type_string() }}) as code,
    cast(info as {{ dbt_utils.type_string() }}) as info,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(team as {{ dbt_utils.type_string() }}) as team,
    cast(zalo as {{ dbt_utils.type_string() }}) as zalo,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(avatar as {{ dbt_utils.type_string() }}) as avatar,
    {{ cast_to_boolean('banned') }} as banned,
    cast(segment as {{ dbt_utils.type_string() }}) as segment,
    cast(facebook as {{ dbt_utils.type_string() }}) as facebook,
    {{ cast_to_boolean('hasorder') }} as hasorder,
    cast(referral as {{ dbt_utils.type_string() }}) as referral,
    segments,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(statistic as {{ dbt_utils.type_string() }}) as statistic,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(membership as {{ dbt_utils.type_string() }}) as membership,
    cast(lastorderat as {{ dbt_utils.type_string() }}) as lastorderat,
    cast(firstorderat as {{ dbt_utils.type_string() }}) as firstorderat,
    cast(registerfrom as {{ dbt_utils.type_string() }}) as registerfrom,
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    cast(adjusttracker as {{ dbt_utils.type_string() }}) as adjusttracker,
    {{ cast_to_boolean('isupdatedinfo') }} as isupdatedinfo,
    cast(identification as {{ dbt_utils.type_string() }}) as identification,
    cast(lastactivatedat as {{ dbt_utils.type_string() }}) as lastactivatedat,
    cast(lastviewnotificationat as {{ dbt_utils.type_string() }}) as lastviewnotificationat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users_ab1') }}
-- users
where 1 = 1

