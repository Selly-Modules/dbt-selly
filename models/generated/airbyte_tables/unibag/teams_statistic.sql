{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('teams_statistic_ab3') }}
select
    _airbyte_teams_hashid,
    sales,
    membertotal,
    lastmonthsales,
    thismonthsales,
    transactiontotal,
    transactionpending,
    transactionsuccess,
    transactionrejected,
    cashtransactiontotal,
    membertotalremaining,
    transactiondelivered,
    transactiondelivering,
    cashtransactionpending,
    cashtransactionsuccess,
    cashtransactionrejected,
    cashtransactiondelivered,
    cashtransactiondelivering,
    transactionwaitingapprove,
    transactionpaymentprocessing,
    cashtransactionwaitingapprove,
    thismonthsale_aibyte_transform,
    vipmembertotal_aibyte_transform,
    cashtransactionpaymentprocessing,
    memberrequesttotalpending_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_statistic_hashid
from {{ ref('teams_statistic_ab3') }}
-- statistic at teams/statistic from {{ ref('teams') }}
where 1 = 1

