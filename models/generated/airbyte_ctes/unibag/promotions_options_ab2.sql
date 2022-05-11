{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('promotions_options_ab1') }}
select
    _airbyte_promotions_hashid,
    cast(bonus as {{ type_json() }}) as bonus,
    milestones,
    suppliermilestones,
    cast(transactionminvalue as {{ dbt_utils.type_float() }}) as transactionminvalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('promotions_options_ab1') }}
-- options at promotions/options
where 1 = 1
