{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('products_score_ab1') }}
select
    _airbyte_products_hashid,
    cast({{ adapter.quote('view') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('view') }},
    cast({{ adapter.quote('order') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('order') }},
    cast(profit as {{ dbt_utils.type_float() }}) as profit,
    cast({{ adapter.quote('current') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('current') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('products_score_ab1') }}
-- score at products/score
where 1 = 1

