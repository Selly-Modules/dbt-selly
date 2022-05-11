{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('teams_information_ab1') }}
select
    _airbyte_teams_hashid,
    cast(communicationchannel as {{ dbt_utils.type_string() }}) as communicationchannel,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('teams_information_ab1') }}
-- information at teams/information
where 1 = 1
