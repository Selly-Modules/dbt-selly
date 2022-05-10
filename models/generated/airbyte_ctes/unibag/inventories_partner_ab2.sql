{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('inventories_partner_ab1') }}
select
    _airbyte_inventories_hashid,
    cast(code as {{ dbt_utils.type_string() }}) as code,
    cast(identitycode as {{ dbt_utils.type_string() }}) as identitycode,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('inventories_partner_ab1') }}
-- partner at inventories/partner
where 1 = 1

