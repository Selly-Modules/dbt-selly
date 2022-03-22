{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('team_members_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        adapter.quote('role'),
        'team',
        adapter.quote('user'),
        boolean_to_string('isleft'),
        'leftat',
        'joinedat',
        'rolecode',
        'createdat',
        'statistic',
        'updatedat',
        'isremovedby',
        'firstorderat',
        'searchstring',
        boolean_to_string('ismemberhomegrown'),
    ]) }} as _airbyte_team_members_hashid,
    tmp.*
from {{ ref('team_members_ab2') }} tmp
-- team_members
where 1 = 1

