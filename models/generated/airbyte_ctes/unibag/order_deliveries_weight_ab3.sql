{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('order_deliveries_weight_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_order_deliveries_hashid',
        adapter.quote('real'),
        'sent',
        'converted',
        'multiplier',
        'convertedwithmultiplier',
    ]) }} as _airbyte_weight_hashid,
    tmp.*
from {{ ref('order_deliveries_weight_ab2') }} tmp
-- weight at order-deliveries/weight
where 1 = 1

