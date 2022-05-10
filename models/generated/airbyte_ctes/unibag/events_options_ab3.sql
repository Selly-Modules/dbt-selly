{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('events_options_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_events_hashid',
        'cash',
        adapter.quote('percent'),
        'validindays',
        'minordervalue',
        'minordertoclaim',
        'usercreatedbeforedate',
    ]) }} as _airbyte_options_hashid,
    tmp.*
from {{ ref('events_options_ab2') }} tmp
-- options at events/options
where 1 = 1

