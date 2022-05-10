{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('product_categories_statistic_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_product_categories_hashid',
        'salestotal',
        'totalshare',
        'salesweektotal',
        'salesyeartotal',
        'salesmonthtotal',
        'salestwomonthtotal',
    ]) }} as _airbyte_statistic_hashid,
    tmp.*
from {{ ref('product_categories_statistic_ab2') }} tmp
-- statistic at product-categories/statistic
where 1 = 1

