{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_identifications__ontside_dimensions_md_ab3') }}
select
    _airbyte_dimensions_hashid,
    url,
    width,
    height,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_md_hashid
from {{ ref('user_identifications__ontside_dimensions_md_ab3') }}
-- md at user-identifications/frontSide/dimensions/md from {{ ref('user_identifications_frontside_dimensions') }}
where 1 = 1

