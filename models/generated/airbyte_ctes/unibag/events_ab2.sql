{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('events_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast({{ adapter.quote('desc') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('desc') }},
    cast(icon as {{ dbt_utils.type_string() }}) as icon,
    cast({{ adapter.quote('name') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('name') }},
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    cast(cover as {{ dbt_utils.type_string() }}) as cover,
    cast(endat as {{ dbt_utils.type_string() }}) as endat,
    {{ cast_to_boolean('active') }} as active,
    cast(notice as {{ dbt_utils.type_string() }}) as notice,
    cast(screen as {{ dbt_utils.type_string() }}) as screen,
    cast(article as {{ dbt_utils.type_string() }}) as article,
    cast({{ adapter.quote('options') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('options') }},
    cast(startat as {{ dbt_utils.type_string() }}) as startat,
    cast(segments as {{ dbt_utils.type_string() }}) as segments,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(grouptype as {{ dbt_utils.type_string() }}) as grouptype,
    suppliers,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    information,
    cast(displayendat as {{ dbt_utils.type_string() }}) as displayendat,
    {{ cast_to_boolean('isapplyforall') }} as isapplyforall,
    cast(displaystartat as {{ dbt_utils.type_string() }}) as displaystartat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('events_ab1') }}
-- events
where 1 = 1

