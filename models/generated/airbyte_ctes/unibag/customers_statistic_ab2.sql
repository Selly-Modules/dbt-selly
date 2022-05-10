{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('customers_statistic_ab1') }}
select
    _airbyte_customers_hashid,
    cast(expensetotal as {{ dbt_utils.type_float() }}) as expensetotal,
    cast(transactiontotal_aibyte_transform as {{ dbt_utils.type_string() }}) as transactiontotal_aibyte_transform,
    cast(transactionpending_aibyte_transform as {{ dbt_utils.type_string() }}) as transactionpending_aibyte_transform,
    cast(transactionsuccess_aibyte_transform as {{ dbt_utils.type_string() }}) as transactionsuccess_aibyte_transform,
    cast(transactionrejected_aibyte_transform as {{ dbt_utils.type_string() }}) as transactionrejected_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_statistic_ab1') }}
-- statistic at customers/statistic
where 1 = 1

