{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('suppliers_balance_ab3') }}
select
    _airbyte_suppliers_hashid,
    currentcash,
    orderpendingcash,
    totalpendingcash,
    withdrawrejectcash,
    orderreconciledcash,
    withdrawpendingcash,
    withdrawsuccesscash,
    changebalancerequestapproved,
    orderwaitingforreconcilecash,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_balance_hashid
from {{ ref('suppliers_balance_ab3') }}
-- balance at suppliers/balance from {{ ref('suppliers') }}
where 1 = 1

