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
        'rest',
        adapter.quote('type'),
        'endat',
        'title',
        boolean_to_string('active'),
        adapter.quote('options'),
        'startat',
        'applyfor',
        'quantity',
        'articleid',
        'createdat',
        'updatedat',
        'searchstring',
        'sharepercent',
        'conditionforuser',
        boolean_to_string('isunlimitedquantity'),
        boolean_to_string('isapplyfororderwholesale'),
    ]) }} as _airbyte_promotions_hashid,
    tmp.*
from {{ ref('promotions_ab2') }} tmp
-- promotions
where 1 = 1

