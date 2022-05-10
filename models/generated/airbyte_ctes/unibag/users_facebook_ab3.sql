{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_facebook_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_users_hashid',
        adapter.quote('id'),
        adapter.quote('name'),
        'email',
        'photo',
        adapter.quote('token'),
        'gender',
    ]) }} as _airbyte_facebook_hashid,
    tmp.*
from {{ ref('users_facebook_ab2') }} tmp
-- facebook at users/facebook
where 1 = 1

