{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_membership_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_users_hashid',
        'expireat',
        'nextlevel',
        'currentlevel',
        'currenttransactioncount',
        'currentsales_aibyte_transform',
    ]) }} as _airbyte_membership_hashid,
    tmp.*
from {{ ref('users_membership_ab2') }} tmp
-- membership at users/membership
where 1 = 1

