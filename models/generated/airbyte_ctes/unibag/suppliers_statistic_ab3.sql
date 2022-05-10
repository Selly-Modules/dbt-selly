{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('suppliers_statistic_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_suppliers_hashid',
        'salestotal',
        'salespending',
        'salessuccess',
        'totalproduct',
        'salescancelled',
        'salesweektotal',
        'salesyeartotal',
        'totalinventory',
        'salesmonthtotal',
        'totalquantitysale',
        'salestwomonthtotal',
        'totalhasorderseller',
    ]) }} as _airbyte_statistic_hashid,
    tmp.*
from {{ ref('suppliers_statistic_ab2') }} tmp
-- statistic at suppliers/statistic
where 1 = 1

