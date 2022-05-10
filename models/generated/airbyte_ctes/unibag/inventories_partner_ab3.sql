{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('inventories_partner_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_inventories_hashid',
        'code',
        'identitycode',
    ]) }} as _airbyte_partner_hashid,
    tmp.*
from {{ ref('inventories_partner_ab2') }} tmp
-- partner at inventories/partner
where 1 = 1

