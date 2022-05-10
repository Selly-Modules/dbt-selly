{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('session_deliveries_promotion_ab3') }}
select
    _airbyte_session_deliveries_hashid,
    {{ adapter.quote('type') }},
    discount,
    isapplied,
    minordervalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_promotion_hashid
from {{ ref('session_deliveries_promotion_ab3') }}
-- promotion at session-deliveries/promotion from {{ ref('session_deliveries') }}
where 1 = 1

