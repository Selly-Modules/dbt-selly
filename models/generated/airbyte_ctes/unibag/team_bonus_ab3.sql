{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('team_bonus_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'team',
        adapter.quote('user'),
        'status',
        adapter.quote('percent'),
        'targetid',
        'teamname',
        'createdat',
        'teamlevel',
        'updatedat',
        'commission',
        'teammember',
        'teampromotion',
    ]) }} as _airbyte_team_bonus_hashid,
    tmp.*
from {{ ref('team_bonus_ab2') }} tmp
-- team_bonus
where 1 = 1

