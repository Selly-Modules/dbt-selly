{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('session_deliveries_customer_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_session_deliveries_hashid',
        '_id',
        adapter.quote('name'),
        'phone',
    ]) }} as _airbyte_customer_hashid,
    tmp.*
from {{ ref('session_deliveries_customer_ab2') }} tmp
-- customer at session-deliveries/customer
where 1 = 1

