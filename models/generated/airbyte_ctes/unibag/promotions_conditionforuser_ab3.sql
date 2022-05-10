{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('promotions_conditionforuser_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_promotions_hashid',
        'gender',
        'applyfor',
        array_to_string('segments'),
    ]) }} as _airbyte_conditionforuser_hashid,
    tmp.*
from {{ ref('promotions_conditionforuser_ab2') }} tmp
-- conditionforuser at promotions/conditionForUser
where 1 = 1

