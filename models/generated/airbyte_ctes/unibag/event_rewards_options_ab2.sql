{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('event_rewards_options_ab1') }}
select
    _airbyte_event_rewards_hashid,
    cast({{ adapter.quote('order') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('order') }},
    cast(invitee as {{ dbt_utils.type_string() }}) as invitee,
    cast({{ adapter.quote('percent') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('percent') }},
    cast(referral as {{ dbt_utils.type_string() }}) as referral,
    cast(minordervalue as {{ dbt_utils.type_float() }}) as minordervalue,
    cast(minordertoclaim as {{ dbt_utils.type_float() }}) as minordertoclaim,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('event_rewards_options_ab1') }}
-- options at event-rewards/options
where 1 = 1

