{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('events') }}
select
    _airbyte_events_hashid,
    {{ json_extract_scalar(adapter.quote('options'), ['cash'], ['cash']) }} as cash,
    {{ json_extract_scalar(adapter.quote('options'), ['percent'], ['percent']) }} as {{ adapter.quote('percent') }},
    {{ json_extract_scalar(adapter.quote('options'), ['validInDays'], ['validInDays']) }} as validindays,
    {{ json_extract_scalar(adapter.quote('options'), ['minOrderValue'], ['minOrderValue']) }} as minordervalue,
    {{ json_extract_scalar(adapter.quote('options'), ['minOrderToClaim'], ['minOrderToClaim']) }} as minordertoclaim,
    {{ json_extract_scalar(adapter.quote('options'), ['userCreatedBeforeDate'], ['userCreatedBeforeDate']) }} as usercreatedbeforedate,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('events') }} as table_alias
-- options at events/options
where 1 = 1
and {{ adapter.quote('options') }} is not null

