{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('teams_statistic_ab1') }}
select
    _airbyte_teams_hashid,
    cast(sales as {{ dbt_utils.type_float() }}) as sales,
    cast(membertotal as {{ dbt_utils.type_float() }}) as membertotal,
    cast(lastmonthsales as {{ dbt_utils.type_float() }}) as lastmonthsales,
    cast(thismonthsales as {{ dbt_utils.type_float() }}) as thismonthsales,
    cast(transactiontotal as {{ dbt_utils.type_float() }}) as transactiontotal,
    cast(transactionpending as {{ dbt_utils.type_float() }}) as transactionpending,
    cast(transactionsuccess as {{ dbt_utils.type_float() }}) as transactionsuccess,
    cast(transactionrejected as {{ dbt_utils.type_float() }}) as transactionrejected,
    cast(cashtransactiontotal as {{ dbt_utils.type_float() }}) as cashtransactiontotal,
    cast(membertotalremaining as {{ dbt_utils.type_float() }}) as membertotalremaining,
    cast(transactiondelivered as {{ dbt_utils.type_float() }}) as transactiondelivered,
    cast(transactiondelivering as {{ dbt_utils.type_float() }}) as transactiondelivering,
    cast(cashtransactionpending as {{ dbt_utils.type_float() }}) as cashtransactionpending,
    cast(cashtransactionsuccess as {{ dbt_utils.type_float() }}) as cashtransactionsuccess,
    cast(cashtransactionrejected as {{ dbt_utils.type_float() }}) as cashtransactionrejected,
    cast(cashtransactiondelivered as {{ dbt_utils.type_float() }}) as cashtransactiondelivered,
    cast(cashtransactiondelivering as {{ dbt_utils.type_float() }}) as cashtransactiondelivering,
    cast(transactionwaitingapprove as {{ dbt_utils.type_float() }}) as transactionwaitingapprove,
    cast(transactionpaymentprocessing as {{ dbt_utils.type_float() }}) as transactionpaymentprocessing,
    cast(cashtransactionwaitingapprove as {{ dbt_utils.type_float() }}) as cashtransactionwaitingapprove,
    cast(thismonthsale_aibyte_transform as {{ dbt_utils.type_string() }}) as thismonthsale_aibyte_transform,
    cast(vipmembertotal_aibyte_transform as {{ dbt_utils.type_string() }}) as vipmembertotal_aibyte_transform,
    cast(cashtransactionpaymentprocessing as {{ dbt_utils.type_float() }}) as cashtransactionpaymentprocessing,
    cast(memberrequesttotalpending_aibyte_transform as {{ dbt_utils.type_string() }}) as memberrequesttotalpending_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('teams_statistic_ab1') }}
-- statistic at teams/statistic
where 1 = 1

