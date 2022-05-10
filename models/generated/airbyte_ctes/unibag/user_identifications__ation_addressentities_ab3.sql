{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "_airbyte_unibag",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('user_identifications__ation_addressentities_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_detectinformation_hashid',
        'ward',
        'street',
        'district',
        'province',
    ]) }} as _airbyte_addressentities_hashid,
    tmp.*
from {{ ref('user_identifications__ation_addressentities_ab2') }} tmp
-- addressentities at user-identifications/detectInformation/addressEntities
where 1 = 1

