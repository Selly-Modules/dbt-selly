{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('products_info_inventory_location_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_inventory_hashid',
        'ward',
        'address',
        'district',
        object_to_string(adapter.quote('location')),
        'province',
        'provincename',
    ]) }} as _airbyte_location_hashid,
    tmp.*
from {{ ref('products_info_inventory_location_ab2') }} tmp
-- location at products/info/inventory/location
where 1 = 1

