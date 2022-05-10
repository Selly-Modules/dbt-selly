{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('teams') }}
select
    _airbyte_teams_hashid,
    {{ json_extract_scalar('statistic', ['sales'], ['sales']) }} as sales,
    {{ json_extract_scalar('statistic', ['memberTotal'], ['memberTotal']) }} as membertotal,
    {{ json_extract_scalar('statistic', ['lastMonthSales'], ['lastMonthSales']) }} as lastmonthsales,
    {{ json_extract_scalar('statistic', ['thisMonthSales'], ['thisMonthSales']) }} as thismonthsales,
    {{ json_extract_scalar('statistic', ['transactionTotal'], ['transactionTotal']) }} as transactiontotal,
    {{ json_extract_scalar('statistic', ['transactionPending'], ['transactionPending']) }} as transactionpending,
    {{ json_extract_scalar('statistic', ['transactionSuccess'], ['transactionSuccess']) }} as transactionsuccess,
    {{ json_extract_scalar('statistic', ['transactionRejected'], ['transactionRejected']) }} as transactionrejected,
    {{ json_extract_scalar('statistic', ['cashTransactionTotal'], ['cashTransactionTotal']) }} as cashtransactiontotal,
    {{ json_extract_scalar('statistic', ['memberTotalRemaining'], ['memberTotalRemaining']) }} as membertotalremaining,
    {{ json_extract_scalar('statistic', ['transactionDelivered'], ['transactionDelivered']) }} as transactiondelivered,
    {{ json_extract_scalar('statistic', ['transactionDelivering'], ['transactionDelivering']) }} as transactiondelivering,
    {{ json_extract_scalar('statistic', ['cashTransactionPending'], ['cashTransactionPending']) }} as cashtransactionpending,
    {{ json_extract_scalar('statistic', ['cashTransactionSuccess'], ['cashTransactionSuccess']) }} as cashtransactionsuccess,
    {{ json_extract_scalar('statistic', ['cashTransactionRejected'], ['cashTransactionRejected']) }} as cashtransactionrejected,
    {{ json_extract_scalar('statistic', ['cashTransactionDelivered'], ['cashTransactionDelivered']) }} as cashtransactiondelivered,
    {{ json_extract_scalar('statistic', ['cashTransactionDelivering'], ['cashTransactionDelivering']) }} as cashtransactiondelivering,
    {{ json_extract_scalar('statistic', ['transactionWaitingApprove'], ['transactionWaitingApprove']) }} as transactionwaitingapprove,
    {{ json_extract_scalar('statistic', ['transactionPaymentProcessing'], ['transactionPaymentProcessing']) }} as transactionpaymentprocessing,
    {{ json_extract_scalar('statistic', ['cashTransactionWaitingApprove'], ['cashTransactionWaitingApprove']) }} as cashtransactionwaitingapprove,
    {{ json_extract_scalar('statistic', ['thisMonthSale_aibyte_transform'], ['thisMonthSale_aibyte_transform']) }} as thismonthsale_aibyte_transform,
    {{ json_extract_scalar('statistic', ['vipMemberTotal_aibyte_transform'], ['vipMemberTotal_aibyte_transform']) }} as vipmembertotal_aibyte_transform,
    {{ json_extract_scalar('statistic', ['cashTransactionPaymentProcessing'], ['cashTransactionPaymentProcessing']) }} as cashtransactionpaymentprocessing,
    {{ json_extract_scalar('statistic', ['memberRequestTotalPending_aibyte_transform'], ['memberRequestTotalPending_aibyte_transform']) }} as memberrequesttotalpending_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('teams') }} as table_alias
-- statistic at teams/statistic
where 1 = 1
and statistic is not null

