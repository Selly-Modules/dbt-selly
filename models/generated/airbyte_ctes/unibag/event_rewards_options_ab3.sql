{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('event_rewards_options_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_event_rewards_hashid',
        adapter.quote('order'),
        'invitee',
        adapter.quote('percent'),
        'referral',
        'minordervalue',
        'minordertoclaim',
    ]) }} as _airbyte_options_hashid,
    tmp.*
from {{ ref('event_rewards_options_ab2') }} tmp
-- options at event-rewards/options
where 1 = 1

