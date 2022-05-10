{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('product_categories_icon_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_product_categories_hashid',
        '_id',
        adapter.quote('name'),
        object_to_string('dimensions'),
    ]) }} as _airbyte_icon_hashid,
    tmp.*
from {{ ref('product_categories_icon_ab2') }} tmp
-- icon at product-categories/icon
where 1 = 1

