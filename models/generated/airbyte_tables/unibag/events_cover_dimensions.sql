{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('events_cover_dimensions_ab3') }}
select
    _airbyte_cover_hashid,
    md,
    sm,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_dimensions_hashid
from {{ ref('events_cover_dimensions_ab3') }}
-- dimensions at events/cover/dimensions from {{ ref('events_cover') }}
where 1 = 1

