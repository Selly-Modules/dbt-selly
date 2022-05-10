{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('membership_histories_new_condition_ab1') }}
select
    _airbyte_new_hashid,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast(sales as {{ dbt_utils.type_float() }}) as sales,
    cast({{ adapter.quote('transaction') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('transaction') }},
    cast(bonuspercent as {{ dbt_utils.type_float() }}) as bonuspercent,
    cast(transactionminvalue as {{ dbt_utils.type_float() }}) as transactionminvalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('membership_histories_new_condition_ab1') }}
-- condition at membership-histories/new/condition
where 1 = 1

