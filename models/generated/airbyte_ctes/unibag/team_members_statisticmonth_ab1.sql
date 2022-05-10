{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('team_members') }}
select
    _airbyte_team_members_hashid,
    {{ json_extract_scalar('statisticmonth', ['sales'], ['sales']) }} as sales,
    {{ json_extract_scalar('statisticmonth', ['thisMonthSale'], ['thisMonthSale']) }} as thismonthsale,
    {{ json_extract_scalar('statisticmonth', ['transactionTotal'], ['transactionTotal']) }} as transactiontotal,
    {{ json_extract_scalar('statisticmonth', ['transactionPending'], ['transactionPending']) }} as transactionpending,
    {{ json_extract_scalar('statisticmonth', ['transactionSuccess'], ['transactionSuccess']) }} as transactionsuccess,
    {{ json_extract_scalar('statisticmonth', ['transactionRejected'], ['transactionRejected']) }} as transactionrejected,
    {{ json_extract_scalar('statisticmonth', ['cashTransactionTotal'], ['cashTransactionTotal']) }} as cashtransactiontotal,
    {{ json_extract_scalar('statisticmonth', ['transactionDelivered'], ['transactionDelivered']) }} as transactiondelivered,
    {{ json_extract_scalar('statisticmonth', ['transactionDelivering'], ['transactionDelivering']) }} as transactiondelivering,
    {{ json_extract_scalar('statisticmonth', ['cashTransactionPending'], ['cashTransactionPending']) }} as cashtransactionpending,
    {{ json_extract_scalar('statisticmonth', ['cashTransactionSuccess'], ['cashTransactionSuccess']) }} as cashtransactionsuccess,
    {{ json_extract_scalar('statisticmonth', ['cashTransactionRejected'], ['cashTransactionRejected']) }} as cashtransactionrejected,
    {{ json_extract_scalar('statisticmonth', ['cashTransactionDelivered'], ['cashTransactionDelivered']) }} as cashtransactiondelivered,
    {{ json_extract_scalar('statisticmonth', ['cashTransactionDelivering'], ['cashTransactionDelivering']) }} as cashtransactiondelivering,
    {{ json_extract_scalar('statisticmonth', ['transactionWaitingApprove'], ['transactionWaitingApprove']) }} as transactionwaitingapprove,
    {{ json_extract_scalar('statisticmonth', ['transactionPaymentProcessing'], ['transactionPaymentProcessing']) }} as transactionpaymentprocessing,
    {{ json_extract_scalar('statisticmonth', ['cashTransactionWaitingApprove'], ['cashTransactionWaitingApprove']) }} as cashtransactionwaitingapprove,
    {{ json_extract_scalar('statisticmonth', ['cashTransactionPaymentProcessing'], ['cashTransactionPaymentProcessing']) }} as cashtransactionpaymentprocessing,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('team_members') }} as table_alias
-- statisticmonth at team-members/statisticMonth
where 1 = 1
and statisticmonth is not null

