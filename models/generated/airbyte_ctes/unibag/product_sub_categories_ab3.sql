{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('product_sub_categories_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        adapter.quote('name'),
        adapter.quote('order'),
        boolean_to_string('active'),
        'parent',
        'createdat',
        'updatedat',
        'searchstring',
        'totalproduct',
    ]) }} as _airbyte_product_sub_categories_hashid,
    tmp.*
from {{ ref('product_sub_categories_ab2') }} tmp
-- product_sub_categories
where 1 = 1

