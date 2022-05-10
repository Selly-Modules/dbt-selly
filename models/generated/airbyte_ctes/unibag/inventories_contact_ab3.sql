{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('inventories_contact_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_inventories_hashid',
        adapter.quote('name'),
        'email',
        'phone',
        'address',
    ]) }} as _airbyte_contact_hashid,
    tmp.*
from {{ ref('inventories_contact_ab2') }} tmp
-- contact at inventories/contact
where 1 = 1

