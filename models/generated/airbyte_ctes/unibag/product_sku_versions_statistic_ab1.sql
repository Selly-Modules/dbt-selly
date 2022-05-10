{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('product_sku_versions') }}
select
    _airbyte_product_sku_versions_hashid,
    {{ json_extract_scalar('statistic', ['saleTotal'], ['saleTotal']) }} as saletotal,
    {{ json_extract_scalar('statistic', ['salePending'], ['salePending']) }} as salepending,
    {{ json_extract_scalar('statistic', ['saleWaiting'], ['saleWaiting']) }} as salewaiting,
    {{ json_extract_scalar('statistic', ['saleCashback'], ['saleCashback']) }} as salecashback,
    {{ json_extract_scalar('statistic', ['saleCancelled'], ['saleCancelled']) }} as salecancelled,
    {{ json_extract_scalar('statistic', ['saleDelivered'], ['saleDelivered']) }} as saledelivered,
    {{ json_extract_scalar('statistic', ['saleDelivering'], ['saleDelivering']) }} as saledelivering,
    {{ json_extract_scalar('statistic', ['salePaymentProcessing'], ['salePaymentProcessing']) }} as salepaymentprocessing,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('product_sku_versions') }} as table_alias
-- statistic at product-sku-versions/statistic
where 1 = 1
and statistic is not null

