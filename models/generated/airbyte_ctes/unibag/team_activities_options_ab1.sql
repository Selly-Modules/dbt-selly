{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('team_activities') }}
select
    _airbyte_team_activities_hashid,
    {{ json_extract_scalar(adapter.quote('options'), ['name'], ['name']) }} as {{ adapter.quote('name') }},
    {{ json_extract_scalar(adapter.quote('options'), ['role'], ['role']) }} as {{ adapter.quote('role') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('team_activities') }} as table_alias
-- options at team-activities/options
where 1 = 1
and {{ adapter.quote('options') }} is not null

