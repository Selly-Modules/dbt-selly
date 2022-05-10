{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'code',
        object_to_string('info'),
        adapter.quote('name'),
        object_to_string('team'),
        object_to_string('zalo'),
        object_to_string('email'),
        object_to_string('phone'),
        object_to_string('avatar'),
        boolean_to_string('banned'),
        'segment',
        object_to_string('facebook'),
        boolean_to_string('hasorder'),
        object_to_string('referral'),
        array_to_string('segments'),
        'createdat',
        object_to_string('statistic'),
        'updatedat',
        object_to_string('membership'),
        'registerfrom',
        'searchstring',
        boolean_to_string('isupdatedinfo'),
        object_to_string('identification'),
        'lastactivatedat',
        'lastviewnotificationat',
    ]) }} as _airbyte_users_hashid,
    tmp.*
from {{ ref('users_ab2') }} tmp
-- users
where 1 = 1

