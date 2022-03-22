{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('teams_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'code',
        adapter.quote('desc'),
        'logo',
        adapter.quote('name'),
        adapter.quote('level'),
        boolean_to_string('active'),
        boolean_to_string('isfull'),
        'citycode',
        'adminuser',
        'createdat',
        'statistic',
        'updatedat',
        'invitelink',
        'information',
        'searchstring',
        'inactivereason',
        'changingnamecount',
    ]) }} as _airbyte_teams_hashid,
    tmp.*
from {{ ref('teams_ab2') }} tmp
-- teams
where 1 = 1

