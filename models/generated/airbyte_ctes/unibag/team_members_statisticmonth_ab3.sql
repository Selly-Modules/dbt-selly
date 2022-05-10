{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('team_members_statisticmonth_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_team_members_hashid',
        'sales',
        'thismonthsale',
        'transactiontotal',
        'transactionpending',
        'transactionsuccess',
        'transactionrejected',
        'cashtransactiontotal',
        'transactiondelivered',
        'transactiondelivering',
        'cashtransactionpending',
        'cashtransactionsuccess',
        'cashtransactionrejected',
        'cashtransactiondelivered',
        'cashtransactiondelivering',
        'transactionwaitingapprove',
        'transactionpaymentprocessing',
        'cashtransactionwaitingapprove',
        'cashtransactionpaymentprocessing',
    ]) }} as _airbyte_statisticmonth_hashid,
    tmp.*
from {{ ref('team_members_statisticmonth_ab2') }} tmp
-- statisticmonth at team-members/statisticMonth
where 1 = 1

