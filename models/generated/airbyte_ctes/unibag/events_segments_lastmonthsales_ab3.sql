{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('events_segments_lastmonthsales_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_segments_hashid',
        adapter.quote('to'),
        adapter.quote('from'),
        boolean_to_string('active'),
    ]) }} as _airbyte_lastmonthsales_hashid,
    tmp.*
from {{ ref('events_segments_lastmonthsales_ab2') }} tmp
-- lastmonthsales at events/segments/lastMonthSales
where 1 = 1

