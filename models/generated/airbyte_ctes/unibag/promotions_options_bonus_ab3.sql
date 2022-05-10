{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('promotions_options_bonus_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_options_hashid',
        adapter.quote('type'),
        adapter.quote('value'),
    ]) }} as _airbyte_bonus_hashid,
    tmp.*
from {{ ref('promotions_options_bonus_ab2') }} tmp
-- bonus at promotions/options/bonus
where 1 = 1

