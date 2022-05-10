{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('product_sku_versions_info_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_product_sku_versions_hashid',
        'weight',
        object_to_string('category'),
        object_to_string('supplier'),
        'dimension',
        object_to_string('inventory'),
    ]) }} as _airbyte_info_hashid,
    tmp.*
from {{ ref('product_sku_versions_info_ab2') }} tmp
-- info at product-sku-versions/info
where 1 = 1

