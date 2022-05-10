{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_info_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_users_hashid',
        'email',
        'gender',
        'citycode',
    ]) }} as _airbyte_info_hashid,
    tmp.*
from {{ ref('users_info_ab2') }} tmp
-- info at users/info
where 1 = 1

