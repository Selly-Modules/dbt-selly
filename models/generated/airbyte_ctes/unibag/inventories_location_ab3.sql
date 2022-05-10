{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('inventories_location_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_inventories_hashid',
        'ward',
        'address',
        'district',
        object_to_string(adapter.quote('location')),
        'province',
    ]) }} as _airbyte_location_hashid,
    tmp.*
from {{ ref('inventories_location_ab2') }} tmp
-- location at inventories/location
where 1 = 1

