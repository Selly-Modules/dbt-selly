{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('events_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'code',
        adapter.quote('desc'),
        object_to_string('icon'),
        adapter.quote('name'),
        adapter.quote('type'),
        object_to_string('cover'),
        'endat',
        boolean_to_string('active'),
        object_to_string('notice'),
        'article',
        object_to_string(adapter.quote('options')),
        'startat',
        object_to_string('segments'),
        'createdat',
        array_to_string('suppliers'),
        'updatedat',
        array_to_string('information'),
        'displayendat',
        boolean_to_string('isapplyforall'),
        'displaystartat',
    ]) }} as _airbyte_events_hashid,
    tmp.*
from {{ ref('events_ab2') }} tmp
-- events
where 1 = 1

