{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('suppliers_balance_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_suppliers_hashid',
        'currentcash',
        'orderpendingcash',
        'totalpendingcash',
        'withdrawrejectcash',
        'orderreconciledcash',
        'withdrawpendingcash',
        'withdrawsuccesscash',
        'changebalancerequestapproved',
        'orderwaitingforreconcilecash',
    ]) }} as _airbyte_balance_hashid,
    tmp.*
from {{ ref('suppliers_balance_ab2') }} tmp
-- balance at suppliers/balance
where 1 = 1

