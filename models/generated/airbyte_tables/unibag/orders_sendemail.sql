{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('orders_sendemail_ab3') }}
select
    _airbyte_orders_hashid,
    status,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sendemail_hashid
from {{ ref('orders_sendemail_ab3') }}
-- sendemail at orders/sendEmail from {{ ref('orders') }}
where 1 = 1

