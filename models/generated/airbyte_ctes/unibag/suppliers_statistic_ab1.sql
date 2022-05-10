{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('suppliers') }}
select
    _airbyte_suppliers_hashid,
    {{ json_extract_scalar('statistic', ['salesTotal'], ['salesTotal']) }} as salestotal,
    {{ json_extract_scalar('statistic', ['salesPending'], ['salesPending']) }} as salespending,
    {{ json_extract_scalar('statistic', ['salesSuccess'], ['salesSuccess']) }} as salessuccess,
    {{ json_extract_scalar('statistic', ['totalProduct'], ['totalProduct']) }} as totalproduct,
    {{ json_extract_scalar('statistic', ['salesCancelled'], ['salesCancelled']) }} as salescancelled,
    {{ json_extract_scalar('statistic', ['salesWeekTotal'], ['salesWeekTotal']) }} as salesweektotal,
    {{ json_extract_scalar('statistic', ['salesYearTotal'], ['salesYearTotal']) }} as salesyeartotal,
    {{ json_extract_scalar('statistic', ['totalInventory'], ['totalInventory']) }} as totalinventory,
    {{ json_extract_scalar('statistic', ['salesMonthTotal'], ['salesMonthTotal']) }} as salesmonthtotal,
    {{ json_extract_scalar('statistic', ['totalQuantitySale'], ['totalQuantitySale']) }} as totalquantitysale,
    {{ json_extract_scalar('statistic', ['salesTwoMonthTotal'], ['salesTwoMonthTotal']) }} as salestwomonthtotal,
    {{ json_extract_scalar('statistic', ['totalHasOrderSeller'], ['totalHasOrderSeller']) }} as totalhasorderseller,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('suppliers') }} as table_alias
-- statistic at suppliers/statistic
where 1 = 1
and statistic is not null

