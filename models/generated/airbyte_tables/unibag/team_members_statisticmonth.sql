{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('team_members_statisticmonth_ab3') }}
select
    _airbyte_team_members_hashid,
    sales,
    thismonthsale,
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
    cashtransactionpaymentprocessing,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_statisticmonth_hashid
from {{ ref('team_members_statisticmonth_ab3') }}
-- statisticmonth at team-members/statisticMonth from {{ ref('team_members') }}
where 1 = 1

