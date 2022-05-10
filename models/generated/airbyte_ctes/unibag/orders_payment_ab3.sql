{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_payment_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_orders_hashid',
        '_id',
        adapter.quote('method'),
        'status',
    ]) }} as _airbyte_payment_hashid,
    tmp.*
from {{ ref('orders_payment_ab2') }} tmp
-- payment at orders/payment
where 1 = 1

