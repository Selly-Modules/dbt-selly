{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('promotions_conditionforuser_ab1') }}
select
    _airbyte_promotions_hashid,
    cast(gender as {{ dbt_utils.type_string() }}) as gender,
    cast(applyfor as {{ dbt_utils.type_string() }}) as applyfor,
    segments,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('promotions_conditionforuser_ab1') }}
-- conditionforuser at promotions/conditionForUser
where 1 = 1

