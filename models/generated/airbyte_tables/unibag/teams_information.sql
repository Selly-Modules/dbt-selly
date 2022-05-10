{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    schema = "unibag",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('teams_information_ab3') }}
select
    _airbyte_teams_hashid,
    communicationchannel,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_information_hashid
from {{ ref('teams_information_ab3') }}
-- information at teams/information from {{ ref('teams') }}
where 1 = 1

