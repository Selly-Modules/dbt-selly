{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_identifications_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'dob',
        adapter.quote('name'),
        'note',
        adapter.quote('type'),
        adapter.quote('user'),
        'gender',
        'nation',
        adapter.quote('number'),
        'status',
        'address',
        'dobdate',
        'backside',
        'birthday',
        'createdat',
        'frontside',
        'issuedate',
        'updatedat',
        'expirydate',
        'issueplace',
        'timeupdate',
        'detectinformation',
    ]) }} as _airbyte_user_identifications_hashid,
    tmp.*
from {{ ref('user_identifications_ab2') }} tmp
-- user_identifications
where 1 = 1

