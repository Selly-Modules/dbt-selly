{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('order_deliveries_promotion_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_order_deliveries_hashid',
        adapter.quote('type'),
        'discount',
        boolean_to_string('isapplied'),
        'minordervalue',
    ]) }} as _airbyte_promotion_hashid,
    tmp.*
from {{ ref('order_deliveries_promotion_ab2') }} tmp
-- promotion at order-deliveries/promotion
where 1 = 1

