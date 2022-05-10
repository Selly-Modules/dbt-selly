{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('events_segments_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_events_hashid',
        array_to_string('segments'),
        'usersegment',
        object_to_string('lastmonthsales'),
        object_to_string('highestmonthlysales'),
    ]) }} as _airbyte_segments_hashid,
    tmp.*
from {{ ref('events_segments_ab2') }} tmp
-- segments at events/segments
where 1 = 1

