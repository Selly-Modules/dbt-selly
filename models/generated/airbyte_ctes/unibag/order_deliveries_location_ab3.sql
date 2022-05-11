{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('order_deliveries_location_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_order_deliveries_hashid',
        '_id',
        'ward',
        'address',
        'district',
        'province',
        'fulladdress',
    ]) }} as _airbyte_location_hashid,
    tmp.*
from {{ ref('order_deliveries_location_ab2') }} tmp
-- location at order-deliveries/location
where 1 = 1
