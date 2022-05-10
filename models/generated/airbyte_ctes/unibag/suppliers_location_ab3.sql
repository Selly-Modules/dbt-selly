{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('suppliers_location_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_suppliers_hashid',
        'ward',
        'address',
        'district',
        adapter.quote('location'),
        'province',
        'fulladdress',
    ]) }} as _airbyte_location_hashid,
    tmp.*
from {{ ref('suppliers_location_ab2') }} tmp
-- location at suppliers/location
where 1 = 1

