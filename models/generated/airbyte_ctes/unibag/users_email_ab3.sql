{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_email_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_users_hashid',
        'email',
        boolean_to_string('verified'),
        'verifiedat',
    ]) }} as _airbyte_email_hashid,
    tmp.*
from {{ ref('users_email_ab2') }} tmp
-- email at users/email
where 1 = 1

