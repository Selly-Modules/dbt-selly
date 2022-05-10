{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('promotions_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'code',
        'rest',
        adapter.quote('type'),
        'endat',
        'title',
        boolean_to_string('active'),
        object_to_string(adapter.quote('options')),
        'startat',
        object_to_string('applyfor'),
        'quantity',
        'articleid',
        'createdat',
        object_to_string('statistic'),
        'updatedat',
        'searchstring',
        object_to_string('conditionforuser'),
        object_to_string('suppliercommission'),
        boolean_to_string('isunlimitedquantity'),
        'maximumlimitperuser',
        array_to_string('milestonesstatistic'),
        boolean_to_string('isapplyfororderwholesale'),
    ]) }} as _airbyte_promotions_hashid,
    tmp.*
from {{ ref('promotions_ab2') }} tmp
-- promotions
where 1 = 1

