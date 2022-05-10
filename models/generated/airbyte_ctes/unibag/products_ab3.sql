{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('products_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        adapter.quote('desc'),
        object_to_string('info'),
        adapter.quote('name'),
        adapter.quote('temp'),
        'brand',
        object_to_string(adapter.quote('order')),
        object_to_string('price'),
        object_to_string('score'),
        boolean_to_string('active'),
        'author',
        array_to_string('guides'),
        array_to_string('photos'),
        array_to_string('videos'),
        'quantity',
        'createdat',
        array_to_string('documents'),
        'sharedesc',
        object_to_string('statistic'),
        'updatedat',
        array_to_string('categories'),
        'inactiveat',
        array_to_string('properties'),
        'reactiveat',
        array_to_string('inventories'),
        'displayskuid',
        boolean_to_string('isoutofstock'),
        object_to_string('pricepercent'),
        'searchstring',
        array_to_string('subcategories'),
        'inactivereason',
        'propertiesmain',
        object_to_string('sharestatistic'),
        'updateactiveid',
        boolean_to_string('canissueinvoice'),
        boolean_to_string('pendinginactive'),
        object_to_string('reviewstatistic'),
        array_to_string('highlightproperties'),
    ]) }} as _airbyte_products_hashid,
    tmp.*
from {{ ref('products_ab2') }} tmp
-- products
where 1 = 1

