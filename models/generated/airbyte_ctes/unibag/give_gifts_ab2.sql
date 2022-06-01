{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('give_gifts_ab1') }}
select
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(title as {{ dbt_utils.type_string() }}) as title,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast({{ adapter.quote('content') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('content') }},
    cast(createdat as {{ dbt_utils.type_string() }}) as createdat,
    cast(createdby as {{ dbt_utils.type_string() }}) as createdby,
    cast(updatedat as {{ dbt_utils.type_string() }}) as updatedat,
    cast(searchstring as {{ dbt_utils.type_string() }}) as searchstring,
    cast(lastchangeusersat as {{ dbt_utils.type_string() }}) as lastchangeusersat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('give_gifts_ab1') }}
-- give_gifts
where 1 = 1

