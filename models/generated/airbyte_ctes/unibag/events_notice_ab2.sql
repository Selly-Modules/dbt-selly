{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('events_notice_ab1') }}
select
    _airbyte_events_hashid,
    cast({{ adapter.quote('label') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('label') }},
    cast({{ adapter.quote('value') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('value') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('events_notice_ab1') }}
-- notice at events/notice
where 1 = 1

