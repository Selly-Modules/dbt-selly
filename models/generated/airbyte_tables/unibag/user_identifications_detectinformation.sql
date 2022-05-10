{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('user_identifications_detectinformation_ab3') }}
select
    _airbyte_user_identifications_hashid,
    {{ adapter.quote('id') }},
    dob,
    doe,
    sex,
    home,
    {{ adapter.quote('name') }},
    {{ adapter.quote('type') }},
    idprob,
    address,
    dobprob,
    doeprob,
    sexprob,
    typenew,
    homeprob,
    nameprob,
    addressprob,
    nationality,
    overallscore,
    addressentities,
    nationalityprob,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_detectinformation_hashid
from {{ ref('user_identifications_detectinformation_ab3') }}
-- detectinformation at user-identifications/detectInformation from {{ ref('user_identifications') }}
where 1 = 1

