{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('event_rewards_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'cash',
        adapter.quote('type'),
        adapter.quote('user'),
        adapter.quote('event'),
        'status',
        adapter.quote('options'),
        'createdat',
        'updatedat',
    ]) }} as _airbyte_event_rewards_hashid,
    tmp.*
from {{ ref('event_rewards_ab2') }} tmp
-- event_rewards
where 1 = 1

