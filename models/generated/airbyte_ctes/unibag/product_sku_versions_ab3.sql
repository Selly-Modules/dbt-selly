{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('product_sku_versions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'sku',
        'info',
        adapter.quote('name'),
        'price',
        adapter.quote('source'),
        'codesku',
        'picture',
        'product',
        'statistic',
        adapter.quote('version'),
        'createdat',
        'updatedat',
        array_to_string('properties'),
    ]) }} as _airbyte_product_sku_versions_hashid,
    tmp.*
from {{ ref('product_sku_versions_ab2') }} tmp
-- product_sku_versions
where 1 = 1

