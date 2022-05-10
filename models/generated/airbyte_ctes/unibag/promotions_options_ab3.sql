{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('promotions_options_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_promotions_hashid',
        object_to_string('bonus'),
        array_to_string('milestones'),
        array_to_string('suppliermilestones'),
        'transactionminvalue',
    ]) }} as _airbyte_options_hashid,
    tmp.*
from {{ ref('promotions_options_ab2') }} tmp
-- options at promotions/options
where 1 = 1

