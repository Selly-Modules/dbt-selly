{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('suppliers_statistic_ab3') }}
select
    _airbyte_suppliers_hashid,
    salestotal,
    salespending,
    salessuccess,
    totalproduct,
    salescancelled,
    salesweektotal,
    salesyeartotal,
    totalinventory,
    salesmonthtotal,
    totalquantitysale,
    salestwomonthtotal,
    totalhasorderseller,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_statistic_hashid
from {{ ref('suppliers_statistic_ab3') }}
-- statistic at suppliers/statistic from {{ ref('suppliers') }}
where 1 = 1

