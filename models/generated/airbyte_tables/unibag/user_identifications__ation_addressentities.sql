{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_identifications__ation_addressentities_ab3') }}
select
    _airbyte_detectinformation_hashid,
    ward,
    street,
    district,
    province,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_addressentities_hashid
from {{ ref('user_identifications__ation_addressentities_ab3') }}
-- addressentities at user-identifications/detectInformation/addressEntities from {{ ref('user_identifications_detectinformation') }}
where 1 = 1

