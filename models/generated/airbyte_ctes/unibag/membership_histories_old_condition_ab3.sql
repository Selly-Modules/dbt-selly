{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('membership_histories_old_condition_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_old_hashid',
        adapter.quote('name'),
        'sales',
        adapter.quote('transaction'),
        'bonuspercent',
        'transactionminvalue',
    ]) }} as _airbyte_condition_hashid,
    tmp.*
from {{ ref('membership_histories_old_condition_ab2') }} tmp
-- condition at membership-histories/old/condition
where 1 = 1

