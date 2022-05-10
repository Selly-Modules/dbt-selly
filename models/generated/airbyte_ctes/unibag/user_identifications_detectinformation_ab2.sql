{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_identifications_detectinformation_ab1') }}
select
    _airbyte_user_identifications_hashid,
    cast({{ adapter.quote('id') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('id') }},
    cast(dob as {{ dbt_utils.type_string() }}) as dob,
    cast(doe as {{ dbt_utils.type_string() }}) as doe,
    cast(sex as {{ dbt_utils.type_string() }}) as sex,
    cast(home as {{ dbt_utils.type_string() }}) as home,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    cast(idprob as {{ dbt_utils.type_string() }}) as idprob,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(dobprob as {{ dbt_utils.type_string() }}) as dobprob,
    cast(doeprob as {{ dbt_utils.type_string() }}) as doeprob,
    cast(sexprob as {{ dbt_utils.type_string() }}) as sexprob,
    cast(typenew as {{ dbt_utils.type_string() }}) as typenew,
    cast(homeprob as {{ dbt_utils.type_string() }}) as homeprob,
    cast(nameprob as {{ dbt_utils.type_string() }}) as nameprob,
    cast(addressprob as {{ dbt_utils.type_string() }}) as addressprob,
    cast(nationality as {{ dbt_utils.type_string() }}) as nationality,
    cast(overallscore as {{ dbt_utils.type_string() }}) as overallscore,
    cast(addressentities as {{ type_json() }}) as addressentities,
    cast(nationalityprob as {{ dbt_utils.type_string() }}) as nationalityprob,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_identifications_detectinformation_ab1') }}
-- detectinformation at user-identifications/detectInformation
where 1 = 1

