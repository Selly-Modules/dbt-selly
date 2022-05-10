{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('session_deliveries_promotion_ab1') }}
select
    _airbyte_session_deliveries_hashid,
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    cast(discount as {{ dbt_utils.type_float() }}) as discount,
    {{ cast_to_boolean('isapplied') }} as isapplied,
    cast(minordervalue as {{ dbt_utils.type_float() }}) as minordervalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('session_deliveries_promotion_ab1') }}
-- promotion at session-deliveries/promotion
where 1 = 1

