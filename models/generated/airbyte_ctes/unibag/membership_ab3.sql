{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('membership_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        adapter.quote('name'),
        'color',
        'guide',
        adapter.quote('level'),
        'sales',
        boolean_to_string('active'),
        'createdat',
        'updatedat',
        adapter.quote('transaction'),
        'bonuspercent',
        'transactionminvalue',
    ]) }} as _airbyte_membership_hashid,
    tmp.*
from {{ ref('membership_ab2') }} tmp
-- membership
where 1 = 1

