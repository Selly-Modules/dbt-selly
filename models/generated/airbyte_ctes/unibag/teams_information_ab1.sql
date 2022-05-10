{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('teams') }}
select
    _airbyte_teams_hashid,
    {{ json_extract_scalar('information', ['communicationChannel'], ['communicationChannel']) }} as communicationchannel,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('teams') }} as table_alias
-- information at teams/information
where 1 = 1
and information is not null

