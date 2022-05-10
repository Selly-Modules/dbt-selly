{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('team_members_statistic_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_team_members_hashid',
        'sales',
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
        'thismonthsale_aibyte_transform',
        'lastmonthsales_aibyte_transform',
        'thismonthsales_aibyte_transform',
        'cashtransactionpaymentprocessing',
    ]) }} as _airbyte_statistic_hashid,
    tmp.*
from {{ ref('team_members_statistic_ab2') }} tmp
-- statistic at team-members/statistic
where 1 = 1

