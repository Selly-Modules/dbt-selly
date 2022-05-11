{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_unibag",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('cash_flows_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_id',
        'hash',
        adapter.quote('user'),
        adapter.quote('value'),
        adapter.quote('action'),
        adapter.quote('options'),
        'category',
        'targetid',
        'createdat',
        boolean_to_string('isaudited'),
        'updatedat',
        'newbalance',
        'oldbalance',
        'targettype',
        boolean_to_string('isprocessed'),
        'processstatus',
    ]) }} as _airbyte_cash_flows_hashid,
    tmp.*
from {{ ref('cash_flows_ab2') }} tmp
-- cash_flows
where 1 = 1

