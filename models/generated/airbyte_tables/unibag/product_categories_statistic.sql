{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('product_categories_statistic_ab3') }}
select
    _airbyte_product_categories_hashid,
    salestotal,
    totalshare,
    salesweektotal,
    salesyeartotal,
    salesmonthtotal,
    salestwomonthtotal,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_statistic_hashid
from {{ ref('product_categories_statistic_ab3') }}
-- statistic at product-categories/statistic from {{ ref('product_categories') }}
where 1 = 1

