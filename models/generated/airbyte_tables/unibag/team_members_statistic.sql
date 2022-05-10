{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('team_members_statistic_ab3') }}
select
    _airbyte_team_members_hashid,
    sales,
    transactiontotal,
    transactionpending,
    transactionsuccess,
    transactionrejected,
    cashtransactiontotal,
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
    lastmonthsales_aibyte_transform,
    thismonthsales_aibyte_transform,
    cashtransactionpaymentprocessing,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_statistic_hashid
from {{ ref('team_members_statistic_ab3') }}
-- statistic at team-members/statistic from {{ ref('team_members') }}
where 1 = 1

