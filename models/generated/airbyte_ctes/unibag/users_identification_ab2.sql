{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_identification_ab1') }}
select
    _airbyte_users_hashid,
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    cast(note as {{ dbt_utils.type_string() }}) as note,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(timeupdate as {{ dbt_utils.type_float() }}) as timeupdate,
    cast(completedat as {{ dbt_utils.type_string() }}) as completedat,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users_identification_ab1') }}
-- identification at users/identification
where 1 = 1

