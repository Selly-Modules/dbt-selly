{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('products_sharestatistic_ab3') }}
select
    _airbyte_products_hashid,
    totalshare,
    totalsharefromsocialpost,
    totalsharefromproductdetail,
    totaluniquesharefromsocialpost,
    totaluniquesharefromproductdetail,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sharestatistic_hashid
from {{ ref('products_sharestatistic_ab3') }}
-- sharestatistic at products/shareStatistic from {{ ref('products') }}
where 1 = 1

