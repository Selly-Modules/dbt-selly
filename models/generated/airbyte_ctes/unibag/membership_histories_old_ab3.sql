{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('membership_histories_old_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_membership_histories_hashid',
        adapter.quote('name'),
        adapter.quote('level'),
        object_to_string(adapter.quote('condition')),
        object_to_string('statistic'),
        adapter.quote('transaction'),
        'bonuspercent',
        'transactionminvalue',
    ]) }} as _airbyte_old_hashid,
    tmp.*
from {{ ref('membership_histories_old_ab2') }} tmp
-- old at membership-histories/old
where 1 = 1

