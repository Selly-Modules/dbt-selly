{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('product_sku_versions_info_category_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_info_hashid',
        adapter.quote('id'),
        adapter.quote('name'),
        'searchstring',
    ]) }} as _airbyte_category_hashid,
    tmp.*
from {{ ref('product_sku_versions_info_category_ab2') }} tmp
-- category at product-sku-versions/info/category
where 1 = 1

