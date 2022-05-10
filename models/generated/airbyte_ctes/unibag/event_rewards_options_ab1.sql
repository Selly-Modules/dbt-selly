{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('event_rewards') }}
select
    _airbyte_event_rewards_hashid,
    {{ json_extract_scalar(adapter.quote('options'), ['order'], ['order']) }} as {{ adapter.quote('order') }},
    {{ json_extract_scalar(adapter.quote('options'), ['invitee'], ['invitee']) }} as invitee,
    {{ json_extract_scalar(adapter.quote('options'), ['percent'], ['percent']) }} as {{ adapter.quote('percent') }},
    {{ json_extract_scalar(adapter.quote('options'), ['referral'], ['referral']) }} as referral,
    {{ json_extract_scalar(adapter.quote('options'), ['minOrderValue'], ['minOrderValue']) }} as minordervalue,
    {{ json_extract_scalar(adapter.quote('options'), ['minOrderToClaim'], ['minOrderToClaim']) }} as minordertoclaim,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('event_rewards') }} as table_alias
-- options at event-rewards/options
where 1 = 1
and {{ adapter.quote('options') }} is not null

