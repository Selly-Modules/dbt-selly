{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('user_give_gift_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(gift as {{ dbt_utils.type_string() }}) as gift,
    cast({{ adapter.quote('user') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('user') }},
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(givegift as {{ dbt_utils.type_string() }}) as givegift,
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    {{ cast_to_boolean('iscompleted') }} as iscompleted,
    cast(notificationcontent as {{ dbt_utils.type_string() }}) as notificationcontent,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('user_give_gift_ab1') }}
-- user_give_gift
where 1 = 1

