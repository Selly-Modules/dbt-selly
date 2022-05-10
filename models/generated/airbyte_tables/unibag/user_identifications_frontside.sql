{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_identifications_frontside_ab3') }}
select
    _airbyte_user_identifications_hashid,
    _id,
    {{ adapter.quote('name') }},
    dimensions,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_frontside_hashid
from {{ ref('user_identifications_frontside_ab3') }}
-- frontside at user-identifications/frontSide from {{ ref('user_identifications') }}
where 1 = 1

