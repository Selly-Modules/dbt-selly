{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('events_notice_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_events_hashid',
        adapter.quote('label'),
        adapter.quote('value'),
    ]) }} as _airbyte_notice_hashid,
    tmp.*
from {{ ref('events_notice_ab2') }} tmp
-- notice at events/notice
where 1 = 1

