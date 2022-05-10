{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_sendemail_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_orders_hashid',
        'status',
    ]) }} as _airbyte_sendemail_hashid,
    tmp.*
from {{ ref('orders_sendemail_ab2') }} tmp
-- sendemail at orders/sendEmail
where 1 = 1

