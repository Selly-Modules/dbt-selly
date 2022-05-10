{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('teams_statistic_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_teams_hashid',
        'sales',
        'membertotal',
        'lastmonthsales',
        'thismonthsales',
        'transactiontotal',
        'transactionpending',
        'transactionsuccess',
        'transactionrejected',
        'cashtransactiontotal',
        'membertotalremaining',
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
        'thismonthsale_aibyte_transform',
        'vipmembertotal_aibyte_transform',
        'cashtransactionpaymentprocessing',
        'memberrequesttotalpending_aibyte_transform',
    ]) }} as _airbyte_statistic_hashid,
    tmp.*
from {{ ref('teams_statistic_ab2') }} tmp
-- statistic at teams/statistic
where 1 = 1

