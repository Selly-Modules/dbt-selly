{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('events') }}
select
    _airbyte_events_hashid,
    {{ json_extract_array('segments', ['segments'], ['segments']) }} as segments,
    {{ json_extract_scalar('segments', ['userSegment'], ['userSegment']) }} as usersegment,
    {{ json_extract('table_alias', 'segments', ['lastMonthSales'], ['lastMonthSales']) }} as lastmonthsales,
    {{ json_extract('table_alias', 'segments', ['highestMonthlySales'], ['highestMonthlySales']) }} as highestmonthlysales,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('events') }} as table_alias
-- segments at events/segments
where 1 = 1
and segments is not null

