{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('customers_statistic_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_customers_hashid',
        'expensetotal',
        'transactiontotal_aibyte_transform',
        'transactionpending_aibyte_transform',
        'transactionsuccess_aibyte_transform',
        'transactionrejected_aibyte_transform',
    ]) }} as _airbyte_statistic_hashid,
    tmp.*
from {{ ref('customers_statistic_ab2') }} tmp
-- statistic at customers/statistic
where 1 = 1

