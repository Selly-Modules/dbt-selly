{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('membership_histories_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        adapter.quote('new'),
        adapter.quote('old'),
        adapter.quote('type'),
        adapter.quote('user'),
        'createdat',
    ]) }} as _airbyte_membership_histories_hashid,
    tmp.*
from {{ ref('membership_histories_ab2') }} tmp
-- membership_histories
where 1 = 1

