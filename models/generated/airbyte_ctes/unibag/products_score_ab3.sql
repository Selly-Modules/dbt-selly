{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('products_score_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_products_hashid',
        adapter.quote('view'),
        adapter.quote('order'),
        'profit',
        adapter.quote('current'),
    ]) }} as _airbyte_score_hashid,
    tmp.*
from {{ ref('products_score_ab2') }} tmp
-- score at products/score
where 1 = 1

