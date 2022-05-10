{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('order_histories_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast({{ adapter.quote('order') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('order') }},
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast({{ adapter.quote('timeStamp') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('timeStamp') }},
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('order_histories_ab1') }}
-- order_histories
where 1 = 1

