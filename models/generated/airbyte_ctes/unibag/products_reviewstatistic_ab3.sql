{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('products_reviewstatistic_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_products_hashid',
        'total',
        'totalreview',
        'totalscore1',
        'totalscore2',
        'totalscore3',
        'totalscore4',
        'totalscore5',
        'scoreaverage',
        'totalhasmedia',
        'totalhascontent',
        'scoreaverageweektotal',
        'scoreaverageyeartotal',
        'scoreaveragemonthtotal',
        'scoreaveragetwomonthtotal',
    ]) }} as _airbyte_reviewstatistic_hashid,
    tmp.*
from {{ ref('products_reviewstatistic_ab2') }} tmp
-- reviewstatistic at products/reviewStatistic
where 1 = 1
