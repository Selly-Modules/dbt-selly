{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('product_categories') }}
select
    _airbyte_product_categories_hashid,
    {{ json_extract_scalar('statistic', ['salesTotal'], ['salesTotal']) }} as salestotal,
    {{ json_extract_scalar('statistic', ['totalShare'], ['totalShare']) }} as totalshare,
    {{ json_extract_scalar('statistic', ['salesWeekTotal'], ['salesWeekTotal']) }} as salesweektotal,
    {{ json_extract_scalar('statistic', ['salesYearTotal'], ['salesYearTotal']) }} as salesyeartotal,
    {{ json_extract_scalar('statistic', ['salesMonthTotal'], ['salesMonthTotal']) }} as salesmonthtotal,
    {{ json_extract_scalar('statistic', ['salesTwoMonthTotal'], ['salesTwoMonthTotal']) }} as salestwomonthtotal,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('product_categories') }} as table_alias
-- statistic at product-categories/statistic
where 1 = 1
and statistic is not null

