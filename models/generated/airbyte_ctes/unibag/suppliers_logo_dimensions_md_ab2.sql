{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('suppliers_logo_dimensions_md_ab1') }}
select
    _airbyte_dimensions_hashid,
    cast(url as {{ dbt_utils.type_string() }}) as url,
    cast(width as {{ dbt_utils.type_float() }}) as width,
    cast(height as {{ dbt_utils.type_float() }}) as height,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('suppliers_logo_dimensions_md_ab1') }}
-- md at suppliers/logo/dimensions/md
where 1 = 1

