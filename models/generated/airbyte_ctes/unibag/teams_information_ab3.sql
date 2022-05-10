{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('teams_information_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_teams_hashid',
        'communicationchannel',
    ]) }} as _airbyte_information_hashid,
    tmp.*
from {{ ref('teams_information_ab2') }} tmp
-- information at teams/information
where 1 = 1

