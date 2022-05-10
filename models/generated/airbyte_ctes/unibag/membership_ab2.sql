{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('membership_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(color as {{ dbt_utils.type_string() }}) as color,
    cast(guide as {{ dbt_utils.type_string() }}) as guide,
    cast({{ adapter.quote('level') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('level') }},
    cast(sales as {{ dbt_utils.type_float() }}) as sales,
    {{ cast_to_boolean('active') }} as active,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast({{ adapter.quote('transaction') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('transaction') }},
    cast(bonuspercent as {{ dbt_utils.type_float() }}) as bonuspercent,
    cast(transactionminvalue as {{ dbt_utils.type_float() }}) as transactionminvalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('membership_ab1') }}
-- membership
where 1 = 1

