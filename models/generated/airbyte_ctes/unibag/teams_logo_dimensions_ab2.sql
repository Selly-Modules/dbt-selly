{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('teams_logo_dimensions_ab1') }}
select
    _airbyte_logo_hashid,
    cast(md as {{ type_json() }}) as md,
    cast(sm as {{ type_json() }}) as sm,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('teams_logo_dimensions_ab1') }}
-- dimensions at teams/logo/dimensions
where 1 = 1

