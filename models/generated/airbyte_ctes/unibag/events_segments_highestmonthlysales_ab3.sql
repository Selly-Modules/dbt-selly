{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('events_segments_highestmonthlysales_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_segments_hashid',
        adapter.quote('to'),
        adapter.quote('from'),
        boolean_to_string('active'),
    ]) }} as _airbyte_highestmonthlysales_hashid,
    tmp.*
from {{ ref('events_segments_highestmonthlysales_ab2') }} tmp
-- highestmonthlysales at events/segments/highestMonthlySales
where 1 = 1

