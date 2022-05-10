{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('teams_logo_dimensions_ab3') }}
select
    _airbyte_logo_hashid,
    md,
    sm,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_dimensions_hashid
from {{ ref('teams_logo_dimensions_ab3') }}
-- dimensions at teams/logo/dimensions from {{ ref('teams_logo') }}
where 1 = 1

