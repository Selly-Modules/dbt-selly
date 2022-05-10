{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('products') }}
select
    _airbyte_products_hashid,
    {{ json_extract_scalar('statistic', ['view'], ['view']) }} as {{ adapter.quote('view') }},
    {{ json_extract_scalar('statistic', ['skuTotal'], ['skuTotal']) }} as skutotal,
    {{ json_extract_scalar('statistic', ['saleTotal'], ['saleTotal']) }} as saletotal,
    {{ json_extract_scalar('statistic', ['skuActive'], ['skuActive']) }} as skuactive,
    {{ json_extract_scalar('statistic', ['totalPost'], ['totalPost']) }} as totalpost,
    {{ json_extract_scalar('statistic', ['salesTotal'], ['salesTotal']) }} as salestotal,
    {{ json_extract_scalar('statistic', ['salePending'], ['salePending']) }} as salepending,
    {{ json_extract_scalar('statistic', ['saleWaiting'], ['saleWaiting']) }} as salewaiting,
    {{ json_extract_scalar('statistic', ['saleCashback'], ['saleCashback']) }} as salecashback,
    {{ json_extract_scalar('statistic', ['saleCancelled'], ['saleCancelled']) }} as salecancelled,
    {{ json_extract_scalar('statistic', ['saleDelivered'], ['saleDelivered']) }} as saledelivered,
    {{ json_extract_scalar('statistic', ['saleWeekTotal'], ['saleWeekTotal']) }} as saleweektotal,
    {{ json_extract_scalar('statistic', ['saleYearTotal'], ['saleYearTotal']) }} as saleyeartotal,
    {{ json_extract_scalar('statistic', ['saleDelivering'], ['saleDelivering']) }} as saledelivering,
    {{ json_extract_scalar('statistic', ['saleMonthTotal'], ['saleMonthTotal']) }} as salemonthtotal,
    {{ json_extract_scalar('statistic', ['salesWeekTotal'], ['salesWeekTotal']) }} as salesweektotal,
    {{ json_extract_scalar('statistic', ['salesYearTotal'], ['salesYearTotal']) }} as salesyeartotal,
    {{ json_extract_scalar('statistic', ['salesMonthTotal'], ['salesMonthTotal']) }} as salesmonthtotal,
    {{ json_extract_scalar('statistic', ['saleTwoMonthTotal'], ['saleTwoMonthTotal']) }} as saletwomonthtotal,
    {{ json_extract_scalar('statistic', ['salesTwoMonthTotal'], ['salesTwoMonthTotal']) }} as salestwomonthtotal,
    {{ json_extract_scalar('statistic', ['salePaymentProcessing'], ['salePaymentProcessing']) }} as salepaymentprocessing,
    {{ json_extract_scalar('statistic', ['totalInventory_aibyte_transform'], ['totalInventory_aibyte_transform']) }} as totalinventory_aibyte_transform,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('products') }} as table_alias
-- statistic at products/statistic
where 1 = 1
and statistic is not null

