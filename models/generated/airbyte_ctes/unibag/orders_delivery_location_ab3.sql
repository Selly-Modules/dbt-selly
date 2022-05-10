{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_delivery_location_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_delivery_hashid',
        '_id',
        'ward',
        'address',
        'district',
        'province',
        'fulladdress',
    ]) }} as _airbyte_location_hashid,
    tmp.*
from {{ ref('orders_delivery_location_ab2') }} tmp
-- location at orders/delivery/location
where 1 = 1

