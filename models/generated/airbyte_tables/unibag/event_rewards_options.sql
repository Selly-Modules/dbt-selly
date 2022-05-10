{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('event_rewards_options_ab3') }}
select
    _airbyte_event_rewards_hashid,
    {{ adapter.quote('order') }},
    invitee,
    {{ adapter.quote('percent') }},
    referral,
    minordervalue,
    minordertoclaim,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_options_hashid
from {{ ref('event_rewards_options_ab3') }}
-- options at event-rewards/options from {{ ref('event_rewards') }}
where 1 = 1

