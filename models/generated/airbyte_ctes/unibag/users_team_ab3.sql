{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('users_team_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_users_hashid',
        '_id',
        adapter.quote('name'),
        adapter.quote('role'),
    ]) }} as _airbyte_team_hashid,
    tmp.*
from {{ ref('users_team_ab2') }} tmp
-- team at users/team
where 1 = 1

