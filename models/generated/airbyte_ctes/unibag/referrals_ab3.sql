{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('referrals_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        adapter.quote('user'),
        'invitee',
        'createdat',
        boolean_to_string('fromsystem'),
    ]) }} as _airbyte_referrals_hashid,
    tmp.*
from {{ ref('referrals_ab2') }} tmp
-- referrals
where 1 = 1

