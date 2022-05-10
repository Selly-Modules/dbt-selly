{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_identification_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_users_hashid',
        '_id',
        'note',
        'status',
        'timeupdate',
        'completedat',
    ]) }} as _airbyte_identification_hashid,
    tmp.*
from {{ ref('users_identification_ab2') }} tmp
-- identification at users/identification
where 1 = 1

