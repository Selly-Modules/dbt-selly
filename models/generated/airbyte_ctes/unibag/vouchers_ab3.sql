{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('vouchers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'code',
        adapter.quote('desc'),
        object_to_string('logo'),
        adapter.quote('type'),
        'endat',
        'title',
        boolean_to_string('active'),
        array_to_string('covers'),
        object_to_string(adapter.quote('options')),
        'startat',
        object_to_string('applyfor'),
        'articleid',
        'createdat',
        'updatedat',
        'searchstring',
        boolean_to_string('isapplyfororderwholesale'),
    ]) }} as _airbyte_vouchers_hashid,
    tmp.*
from {{ ref('vouchers_ab2') }} tmp
-- vouchers
where 1 = 1

