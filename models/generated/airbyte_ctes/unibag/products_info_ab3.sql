{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('products_info_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_products_hashid',
        'profit',
        object_to_string('category'),
        object_to_string('supplier'),
        object_to_string('inventory'),
    ]) }} as _airbyte_info_hashid,
    tmp.*
from {{ ref('products_info_ab2') }} tmp
-- info at products/info
where 1 = 1

