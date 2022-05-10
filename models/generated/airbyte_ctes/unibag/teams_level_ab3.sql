{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('teams_level_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_teams_hashid',
        adapter.quote('name'),
        'color',
        adapter.quote('level'),
        'expiredat',
        'nextlevel',
        'bonuspercent',
        'maximumvipmember',
        'levelatstartofmonth',
        'maximumnumbermember',
        'maximumnumberviceleader',
    ]) }} as _airbyte_level_hashid,
    tmp.*
from {{ ref('teams_level_ab2') }} tmp
-- level at teams/level
where 1 = 1

