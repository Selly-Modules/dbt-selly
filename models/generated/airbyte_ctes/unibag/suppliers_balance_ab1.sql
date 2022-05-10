{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('suppliers') }}
select
    _airbyte_suppliers_hashid,
    {{ json_extract_scalar('balance', ['currentCash'], ['currentCash']) }} as currentcash,
    {{ json_extract_scalar('balance', ['orderPendingCash'], ['orderPendingCash']) }} as orderpendingcash,
    {{ json_extract_scalar('balance', ['totalPendingCash'], ['totalPendingCash']) }} as totalpendingcash,
    {{ json_extract_scalar('balance', ['withdrawRejectCash'], ['withdrawRejectCash']) }} as withdrawrejectcash,
    {{ json_extract_scalar('balance', ['orderReconciledCash'], ['orderReconciledCash']) }} as orderreconciledcash,
    {{ json_extract_scalar('balance', ['withdrawPendingCash'], ['withdrawPendingCash']) }} as withdrawpendingcash,
    {{ json_extract_scalar('balance', ['withdrawSuccessCash'], ['withdrawSuccessCash']) }} as withdrawsuccesscash,
    {{ json_extract_scalar('balance', ['changeBalanceRequestApproved'], ['changeBalanceRequestApproved']) }} as changebalancerequestapproved,
    {{ json_extract_scalar('balance', ['orderWaitingForReconcileCash'], ['orderWaitingForReconcileCash']) }} as orderwaitingforreconcilecash,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('suppliers') }} as table_alias
-- balance at suppliers/balance
where 1 = 1
and balance is not null

