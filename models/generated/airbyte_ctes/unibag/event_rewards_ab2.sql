{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('event_rewards_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(cash as {{ dbt_utils.type_float() }}) as cash,
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    cast({{ adapter.quote('user') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('user') }},
    cast({{ adapter.quote('event') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('event') }},
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast({{ adapter.quote('options') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('options') }},
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('event_rewards_ab1') }}
-- event_rewards
where 1 = 1

