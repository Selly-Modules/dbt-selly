{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_referral_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_users_hashid',
        'code',
        boolean_to_string('enabled'),
        'enabledat',
        'sharecontent',
    ]) }} as _airbyte_referral_hashid,
    tmp.*
from {{ ref('users_referral_ab2') }} tmp
-- referral at users/referral
where 1 = 1

