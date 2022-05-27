{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('brands_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        adapter.quote('desc'),
        'logo',
        adapter.quote('name'),
        'slug',
        boolean_to_string('active'),
        array_to_string('photos'),
        'country',
        'createdat',
        'updatedat',
        'searchstring',
        'totalproduct',
    ]) }} as _airbyte_brands_hashid,
    tmp.*
from {{ ref('brands_ab2') }} tmp
-- brands
where 1 = 1

