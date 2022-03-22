{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_identifications_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(dob as {{ dbt_utils.type_string() }}) as dob,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(note as {{ dbt_utils.type_string() }}) as note,
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    cast({{ adapter.quote('user') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('user') }},
    cast(gender as {{ dbt_utils.type_string() }}) as gender,
    cast(nation as {{ dbt_utils.type_string() }}) as nation,
    cast({{ adapter.quote('number') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('number') }},
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(dobdate as {{ dbt_utils.type_string() }}) as dobdate,
    cast(backside as {{ dbt_utils.type_string() }}) as backside,
    cast(birthday as {{ dbt_utils.type_string() }}) as birthday,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(frontside as {{ dbt_utils.type_string() }}) as frontside,
    cast(issuedate as {{ dbt_utils.type_string() }}) as issuedate,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(expirydate as {{ dbt_utils.type_string() }}) as expirydate,
    cast(issueplace as {{ dbt_utils.type_string() }}) as issueplace,
    cast(timeupdate as {{ dbt_utils.type_float() }}) as timeupdate,
    cast(detectinformation as {{ dbt_utils.type_string() }}) as detectinformation,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_identifications_ab1') }}
-- user_identifications
where 1 = 1

