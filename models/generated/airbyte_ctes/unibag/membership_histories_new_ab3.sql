{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('membership_histories_new_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_membership_histories_hashid',
        adapter.quote('name'),
        adapter.quote('level'),
        object_to_string(adapter.quote('condition')),
        'statistic',
        adapter.quote('transaction'),
        'bonuspercent',
        'transactionminvalue',
    ]) }} as _airbyte_new_hashid,
    tmp.*
from {{ ref('membership_histories_new_ab2') }} tmp
-- new at membership-histories/new
where 1 = 1

