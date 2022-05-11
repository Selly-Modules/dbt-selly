{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('team_activities_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'team',
        adapter.quote('action'),
        adapter.quote('options'),
        'targetid',
        'createdat',
        'createdby',
    ]) }} as _airbyte_team_activities_hashid,
    tmp.*
from {{ ref('team_activities_ab2') }} tmp
-- team_activities
where 1 = 1

