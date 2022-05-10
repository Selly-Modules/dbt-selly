{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('vouchers_applyfor_ab1') }}
select
    _airbyte_vouchers_hashid,
    list,
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    cast(provinces as {{ dbt_utils.type_string() }}) as provinces,
    {{ cast_to_boolean('isapplyallorder') }} as isapplyallorder,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('vouchers_applyfor_ab1') }}
-- applyfor at vouchers/applyFor
where 1 = 1

