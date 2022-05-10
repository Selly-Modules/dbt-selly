{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('customers') }}
select
    _airbyte_customers_hashid,
    {{ json_extract_scalar('statistic', ['expenseTotal'], ['expenseTotal']) }} as expensetotal,
    {{ json_extract_scalar('statistic', ['transactionTotal_aibyte_transform'], ['transactionTotal_aibyte_transform']) }} as transactiontotal_aibyte_transform,
    {{ json_extract_scalar('statistic', ['transactionPending_aibyte_transform'], ['transactionPending_aibyte_transform']) }} as transactionpending_aibyte_transform,
    {{ json_extract_scalar('statistic', ['transactionSuccess_aibyte_transform'], ['transactionSuccess_aibyte_transform']) }} as transactionsuccess_aibyte_transform,
    {{ json_extract_scalar('statistic', ['transactionRejected_aibyte_transform'], ['transactionRejected_aibyte_transform']) }} as transactionrejected_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers') }} as table_alias
-- statistic at customers/statistic
where 1 = 1
and statistic is not null

