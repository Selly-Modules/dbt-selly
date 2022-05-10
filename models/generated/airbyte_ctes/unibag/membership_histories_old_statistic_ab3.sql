{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('membership_histories_old_statistic_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_old_hashid',
        'sales',
        adapter.quote('transaction'),
    ]) }} as _airbyte_statistic_hashid,
    tmp.*
from {{ ref('membership_histories_old_statistic_ab2') }} tmp
-- statistic at membership-histories/old/statistic
where 1 = 1

