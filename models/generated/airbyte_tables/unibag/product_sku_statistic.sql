{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('product_sku_statistic_ab3') }}
select
    _airbyte_product_sku_hashid,
    saletotal,
    salepending,
    salewaiting,
    salecashback,
    salecancelled,
    saledelivered,
    saledelivering,
    salepaymentprocessing,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_statistic_hashid
from {{ ref('product_sku_statistic_ab3') }}
-- statistic at product-sku/statistic from {{ ref('product_sku') }}
where 1 = 1

