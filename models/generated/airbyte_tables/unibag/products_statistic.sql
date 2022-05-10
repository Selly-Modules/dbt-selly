{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('products_statistic_ab3') }}
select
    _airbyte_products_hashid,
    {{ adapter.quote('view') }},
    skutotal,
    saletotal,
    skuactive,
    totalpost,
    salestotal,
    salepending,
    salewaiting,
    salecashback,
    salecancelled,
    saledelivered,
    saleweektotal,
    saleyeartotal,
    saledelivering,
    salemonthtotal,
    salesweektotal,
    salesyeartotal,
    salesmonthtotal,
    saletwomonthtotal,
    salestwomonthtotal,
    salepaymentprocessing,
    totalinventory_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_statistic_hashid
from {{ ref('products_statistic_ab3') }}
-- statistic at products/statistic from {{ ref('products') }}
where 1 = 1

