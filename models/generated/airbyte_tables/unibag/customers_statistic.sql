{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('customers_statistic_ab3') }}
select
    _airbyte_customers_hashid,
    expensetotal,
    transactiontotal_aibyte_transform,
    transactionpending_aibyte_transform,
    transactionsuccess_aibyte_transform,
    transactionrejected_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_statistic_hashid
from {{ ref('customers_statistic_ab3') }}
-- statistic at customers/statistic from {{ ref('customers') }}
where 1 = 1

