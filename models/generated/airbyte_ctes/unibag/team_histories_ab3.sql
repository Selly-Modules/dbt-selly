{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('team_histories_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        adapter.quote('date'),
        'team',
        adapter.quote('level'),
        'leader',
        'status',
        'createdat',
        'statistic',
    ]) }} as _airbyte_team_histories_hashid,
    tmp.*
from {{ ref('team_histories_ab2') }} tmp
-- team_histories
where 1 = 1

