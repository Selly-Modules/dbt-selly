{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('vouchers_options_bonus_ab1') }}
select
    _airbyte_options_hashid,
    cast({{ adapter.quote('type') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('type') }},
    cast({{ adapter.quote('value') }} as {{ dbt_utils.type_float() }}) as {{ adapter.quote('value') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('vouchers_options_bonus_ab1') }}
-- bonus at vouchers/options/bonus
where 1 = 1

