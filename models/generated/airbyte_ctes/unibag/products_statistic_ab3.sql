{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('products_statistic_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_products_hashid',
        adapter.quote('view'),
        'skutotal',
        'saletotal',
        'skuactive',
        'totalpost',
        'salestotal',
        'salepending',
        'salewaiting',
        'salecashback',
        'salecancelled',
        'saledelivered',
        'saleweektotal',
        'saleyeartotal',
        'saledelivering',
        'salemonthtotal',
        'salesweektotal',
        'salesyeartotal',
        'salesmonthtotal',
        'saletwomonthtotal',
        'salestwomonthtotal',
        'salepaymentprocessing',
        'totalinventory_aibyte_transform',
    ]) }} as _airbyte_statistic_hashid,
    tmp.*
from {{ ref('products_statistic_ab2') }} tmp
-- statistic at products/statistic
where 1 = 1

