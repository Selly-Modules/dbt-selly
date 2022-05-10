{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('products_reviewstatistic_ab3') }}
select
    _airbyte_products_hashid,
    total,
    totalreview,
    totalscore1,
    totalscore2,
    totalscore3,
    totalscore4,
    totalscore5,
    scoreaverage,
    totalhasmedia,
    totalhascontent,
    scoreaverageweektotal,
    scoreaverageyeartotal,
    scoreaveragemonthtotal,
    scoreaveragetwomonthtotal,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_reviewstatistic_hashid
from {{ ref('products_reviewstatistic_ab3') }}
-- reviewstatistic at products/reviewStatistic from {{ ref('products') }}
where 1 = 1

