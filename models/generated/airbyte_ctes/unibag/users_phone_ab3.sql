{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_phone_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_users_hashid',
        adapter.quote('full'),
        adapter.quote('number'),
        boolean_to_string('verified'),
        'verifiedat',
        'countrycode',
    ]) }} as _airbyte_phone_hashid,
    tmp.*
from {{ ref('users_phone_ab2') }} tmp
-- phone at users/phone
where 1 = 1

