{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('team_activities_options_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_team_activities_hashid',
        adapter.quote('name'),
        adapter.quote('role'),
    ]) }} as _airbyte_options_hashid,
    tmp.*
from {{ ref('team_activities_options_ab2') }} tmp
-- options at team-activities/options
where 1 = 1

