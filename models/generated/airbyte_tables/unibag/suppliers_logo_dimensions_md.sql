{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('suppliers_logo_dimensions_md_ab3') }}
select
    _airbyte_dimensions_hashid,
    url,
    width,
    height,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_md_hashid
from {{ ref('suppliers_logo_dimensions_md_ab3') }}
-- md at suppliers/logo/dimensions/md from {{ ref('suppliers_logo_dimensions') }}
where 1 = 1

