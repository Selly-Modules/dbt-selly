{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_courses_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        adapter.quote('user'),
        'course',
        'hoolaid',
        'createdat',
        'updatedat',
        'academyaccount',
    ]) }} as _airbyte_user_courses_hashid,
    tmp.*
from {{ ref('user_courses_ab2') }} tmp
-- user_courses
where 1 = 1

